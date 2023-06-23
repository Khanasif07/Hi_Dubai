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
}

extension NewsListViewModelDelegate{
    func pumpkinDataSuccess(){}
    func pumpkinDataFailure(error: Error){}
    func newsListingSuccess(){}
    func newsListingFailure(error: Error){}
    func movieDataSuccess(){}
    func movieDataFailure(error: Error){}
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
    
    //will implement viewmodel by implementing depedency injection like SwiftUIInUICollectionViewAndUITableView-main project
    //
    weak var delegate: NewsListViewModelDelegate?
    var newsData = [Record]()
    var pumkinsData = [Pumpkin]()
    var moviesResponse: MoviesResponse? = nil
    var error : Error?
    func getNewsListing(){
        NetworkManager.shared.getDataFromServer(requestType: .get, endPoint: EndPoint.news.rawValue) { (results : Result<News,Error>)  in
            switch results{
            case .success(let result):
                self.newsData = result.record
                self.delegate?.newsListingSuccess()
            case .failure(let error):
                self.error = error
                self.newsData = []
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
        NetworkManager.shared.getPumpkinDataFromServer(requestType: .get, endPoint: EndPoint.searchMovie.rawValue,dict) { (results : Result<MoviesResponse,Error>)  in
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
    
    func getCellViewModel(at indexpath: IndexPath) -> Record{
        return newsData[indexpath.row]
    }
}
