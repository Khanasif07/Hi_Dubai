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
}

extension NewsListViewModelDelegate{
    func pumpkinDataSuccess(){}
    func pumpkinDataFailure(error: Error){}
    func newsListingSuccess(){}
    func newsListingFailure(error: Error){}
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
                self.delegate?.pumpkinDataSuccess()
            case .failure(let error):
                self.isRequestinApi = false
                self.error = error
                self.delegate?.pumpkinDataFailure(error: error)
            }
        }
    }
    
    func getCellViewModel(at indexpath: IndexPath) -> Record{
        return newsData[indexpath.row]
    }
}
