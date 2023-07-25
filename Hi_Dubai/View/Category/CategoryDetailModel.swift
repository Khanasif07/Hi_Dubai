//
//  CategoryDetailModel.swift
//  Hi_Dubai
//
//  Created by Asif Khan on 25/07/2023.
//

import Foundation
enum TableViewCells {
    case videoCell, upcomingCell, favoritesCell,liveClassesCell, mostLovedClassesCell, categories
}
class CategoryDetailModel {
    //now talksCell is most discussed cell
    var tableCellAtIndexPath: [[TableViewCells]] = []
    var sectionData: [Int] = []
    var cardData: SuperYouCardData?
    var videoData: [Record] = []
    var upcomingDataArr: [Record] = []
    var liveNowDataArr: [Record] = []
    var favouriteDataArr: [Record] = []
    var newSuperShesArr: [Record] = []
    var mostDiscussedTalks: [Record] = []
    var mostLovedArr: [Record] = []
    var featuredDataArr: [Record] = []
    var pastLiveData: [Record] = []
    var businessCategories: [Record] = []
    var categories: [Record] = []
    var musicData: [Record] = []
    var isFirstTime: Bool = false
    
    convenience init(nextPageStatus: Bool) {
        self.init(jsonArr: [[:]], nextPageStatus: nextPageStatus)
    }
    
    init(jsonArr: [JSONDictionary], nextPageStatus: Bool) {
        
        self.dataMappingInModel(jsonArr: jsonArr)
    }
    // api....
    weak var delegate: NewsListViewModelDelegate?
    private (set) var newsData = [Record]()
    var error : Error?
    func getNewsListing(){
        NetworkManager.shared.getDataFromServer(requestType: .get, endPoint: EndPoint.news.rawValue) { (result: Result<News,Error>) in
            switch result{
            case .success(let result):
                self.videoData = result.record
                self.musicData = result.record
                self.mostLovedArr = result.record
                self.upcomingDataArr = result.record
                self.liveNowDataArr = result.record
                self.featuredDataArr = self.isFirstTime ? [] : result.record
                self.newSuperShesArr = result.record
                self.businessCategories =  result.record
                self.categories =  result.record
                self.pastLiveData = result.record
                self.isFirstTime =  !self.isFirstTime
                self.delegate?.newsListingSuccess()
            case .failure(let error):
                self.error = error
                self.newsData = []
                self.delegate?.newsListingFailure(error: error)
                
            }
        }
    }
    
    func dataMappingInModel(jsonArr: [JSONDictionary]) {
        self.tableCellAtIndexPath.removeAll()
        if isFirstTime{
            self.tableCellAtIndexPath.append([.videoCell])
            self.tableCellAtIndexPath.append([.mostLovedClassesCell])
            self.tableCellAtIndexPath.append([.liveClassesCell])
            self.tableCellAtIndexPath.append([.upcomingCell])
            self.tableCellAtIndexPath.append([.categories])
        }else{
            self.tableCellAtIndexPath.append([.videoCell])
            self.tableCellAtIndexPath.append([.mostLovedClassesCell])
            self.tableCellAtIndexPath.append([.liveClassesCell])
            self.tableCellAtIndexPath.append([.categories])
            self.tableCellAtIndexPath.append([.upcomingCell])
        }
        getNewsListing()
    }
}
