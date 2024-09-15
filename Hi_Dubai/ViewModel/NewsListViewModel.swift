//
//  NewsListViewModel.swift
//  Hi_Dubai
//
//  Created by Admin on 11/02/23.
//

import Foundation
protocol NewsListViewModelDelegate: NSObject {
    func newsListingSuccess()
    func newsListingFailure(error: Error)
    func pumpkinDataSuccess()
    func pumpkinDataFailure(error: Error)
    func movieDataSuccess()
    func movieDataFailure(error: Error)
    func movieDetailSuccess()
    func movieDetailFailure(error: Error)
}

extension NewsListViewModelDelegate{
    func pumpkinDataSuccess(){}
    func pumpkinDataFailure(error: Error){}
    func newsListingSuccess(){}
    func newsListingFailure(error: Error){}
    func movieDataSuccess(){}
    func movieDataFailure(error: Error){}
    func movieDetailSuccess(){}
    func movieDetailFailure(error: Error){}
}

class NewsListViewModel{
    //Pagination
    var hideLoader: Bool = false
    var currentPage = 1
    var totalPages = 5
    var nextPageAvailable = true
    var isRequestinApi = false
    var showPaginationLoader: Bool {
        return  hideLoader ? false : nextPageAvailable
    }
    
    //
    var businessCategories:[Category] = []
    var categories:[Category] = []
    
    var animals: [Animal] = Bundle.main.decode("animal.json")
    var searchValue: String = ""{
        didSet{
            categories = searchValue.isEmpty ? businessCategories : businessCategories.filter({(category: Category) -> Bool in
                return category.children?.filter ({ (subCategory: Child) -> Bool in
                    subCategory.name?.en?.range(of: searchValue, options: .caseInsensitive) != nil
                }).count ?? 0 > 0
            }).map({ (subCategories:Category) in
                let filtered =  subCategories.children?.filter { (subCategoriesName:Child)->Bool in
                    subCategoriesName.name?.en?.range(of: self.searchValue, options: .caseInsensitive) != nil
                }
                var category = subCategories
                category.children = filtered
                return category
            })
        }
    }
    var animalCategories: [Animal] = []
   
    //will implement viewmodel by implementing depedency injection like SwiftUIInUICollectionViewAndUITableView-main project
    //
    weak var delegate: NewsListViewModelDelegate?
    var newsData = [NewsModel]()
    var pumkinsData = [Pumpkin]()
    var moviesResponse: MoviesResponse? = nil
    var moviesDetail: MovieDetail? = nil
    var error : Error?
    func getNewsListing(){
        NetworkManager.shared.getDataFromServer(requestType: .get, endPoint: EndPoint.news.rawValue) { (results : Result<News,Error>)  in
            switch results{
            case .success(let result):
                self.newsData = result.record
                _ = self._cdNewsDataRepository.insertNewsRecords(records: result.record)
                self.delegate?.newsListingSuccess()
            case .failure(let error):
                self.error = error
                self.newsData = []
                self.delegate?.newsListingFailure(error: error)
            }
        }
    }
    
    //
    private let _cdMovieDataRepository : MovieDataRepository = MovieDataRepository()
    private let _cdNewsDataRepository : NewsDataRepository = NewsDataRepository()
//    private let _movieApiRepository: AnimalApiResourceRepository = AnimalApiRepository()

    func getNewsListingRecord(completionHandler:@escaping(_ result: Array<NewsModel>?)-> Void) {

        _cdNewsDataRepository.getNewsRecords { response in
            if(response != nil && response?.count != 0){
                // return response to the view controller
                self.newsData = response ?? []
                self.delegate?.newsListingSuccess()
                completionHandler(response)
            }else {
                // call the api
                self.getNewsListing()
            }
        }

    }
    //
    
    func getCategoriesListing(){
        NetworkManager.shared.getCategoriesDataFromServer(requestType: .get, endPoint: EndPoint.hidubai_categories.rawValue) { (results : Result<CategoriesList,Error>)  in
            switch results{
            case .success(let result):
                print(result)
                self.businessCategories = result.embedded.categories ?? []
                print(self.businessCategories)
                self.delegate?.newsListingSuccess()
            case .failure(let error):
                self.error = error
                self.delegate?.newsListingFailure(error: error)
            }
        }
    }
    
    
    func getPumpkinListing(page: Int,loader: Bool = false,pagination: Bool = false){
        //
        if pagination {
            guard nextPageAvailable, !isRequestinApi else { return }
        } else {
            guard !isRequestinApi else { return }
        }
        isRequestinApi = true
        //
        let dict:[String:String] = ["page":"\(page)","per_page":"\(15)"]
        NetworkManager.shared.getPumpkinDataFromServer(requestType: .get, endPoint: EndPoint.pumpkin.rawValue,dict) { (results : Result<Welcome,Error>)  in
            switch results{
            case .success(let result):
                if result.isEmpty {
                    self.hideLoader = true
                    self.pumkinsData = []
                    self.isRequestinApi = false
                    self.delegate?.pumpkinDataSuccess()
                    return
                }
                self.nextPageAvailable = self.currentPage < self.totalPages
                if self.currentPage == 1 {
                    self.pumkinsData = result
                } else {
                    self.pumkinsData.append(contentsOf: result)
                }
                self.currentPage += 1
                self.isRequestinApi = false
                self.hideLoader = false
                self.delegate?.pumpkinDataSuccess()
            case .failure(let error):
                self.isRequestinApi = false
                self.error = error
                self.delegate?.pumpkinDataFailure(error: error)
            }
        }
    }
    
    func getMovieListing(page: Int,loader: Bool = false,pagination: Bool = false,search: String = ""){
        //
        if pagination {
            guard nextPageAvailable, !isRequestinApi else { return }
        } else {
            guard !isRequestinApi else { return }
        }
        isRequestinApi = true
        //
        let dict:[String:String] = [ApiKey.page: "\(page)",ApiKey.query: search,ApiKey.api_key: EndPoint.tmdb_api_key.rawValue]
        NetworkManager.shared.getPumpkinDataFromServer(requestType: .get, endPoint: search.isEmpty ? EndPoint.popularMovie.rawValue : EndPoint.searchMovie.rawValue,dict) { (results : Result<MoviesResponse,Error>)  in
            switch results{
            case .success(let result):
                if result.results.isEmpty && self.currentPage == 1 {
                    self.hideLoader = true
                    self.moviesResponse?.results = []
                    self.isRequestinApi = false
                    self.delegate?.movieDataSuccess()
                    return
                }
                self.currentPage = result.page ?? 0
                self.totalPages = result.totalPages ?? 5
                self.nextPageAvailable = self.currentPage < self.totalPages
                if self.currentPage == 1 {
                    self.moviesResponse = result
                } else {
                    self.moviesResponse?.results.append(contentsOf: result.results)
                }
                self.currentPage += 1
                self.isRequestinApi = false
                self.hideLoader = false
                self.delegate?.movieDataSuccess()
            case .failure(let error):
                self.isRequestinApi = false
                self.error = error
                self.delegate?.movieDataFailure(error: error)
            }
        }
    }
    
    func getMovieDetail(path: String!){
        let dict:[String:String] = [ApiKey.api_key: EndPoint.tmdb_api_key.rawValue]
        NetworkManager.shared.getMovieDetailDataFromServer(requestType: .get, endPoint: EndPoint.movieDetail.rawValue,dict,path) { (results : Result<MovieDetail,Error>)   in
            switch results{
            case .success(let result):
                self.moviesDetail = result
                print("moviesDetail:-\(String(describing: self.moviesDetail))")
                self.delegate?.movieDetailSuccess()
            case .failure(let error):
                self.error = error
                self.moviesDetail =  nil
                self.delegate?.movieDetailFailure(error: error)
            }
        }
    }
    
    func getCellViewModel(at indexpath: IndexPath) -> NewsModel{
        return newsData[indexpath.row]
    }
}
