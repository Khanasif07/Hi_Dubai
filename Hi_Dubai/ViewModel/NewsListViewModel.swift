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
}

class NewsListViewModel{
    weak var delegate: NewsListViewModelDelegate?
    var newsData = [Record]()
    func getNewsListing(){
        NetworkManager.shared.getDataFromServer(requestType: .get, endPoint: EndPoint.news.rawValue) { (results : Result<News,Error>)  in
            switch results{
            case .success(let result):
                self.newsData = result.record
                self.delegate?.newsListingSuccess()
            case .failure(let error):
                self.delegate?.newsListingFailure(error: error)
            }
        }
    }
}
