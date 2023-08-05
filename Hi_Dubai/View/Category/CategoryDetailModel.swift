//
//  CategoryDetailModel.swift
//  Hi_Dubai
//
//  Created by Asif Khan on 25/07/2023.
//

import Foundation
enum TableViewCells {
    case section1, section2, section3,section4, section5, section6
}
class CategoryDetailModel {
    var animals: [Animal] = Bundle.main.decode("animal.json")
    //now talksCell is most discussed cell
    var tableCellAtIndexPath: [[TableViewCells]] = []
    var section1Data: [Record] = []
    var section2Data: [Record] = []
    var section3Data: [Record] = []
    var section4Data: [Record] = []
    var section5Data: [Record] = []
    var section6Data: [Animal] = []
//    var section6Data: [Record] = []
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
                self.section1Data = result.record
                self.section2Data = result.record
                self.section3Data = result.record
                self.section4Data = result.record
                self.section5Data = result.record
//                self.section6Data = self.animals
                self.section6Data = self.animals
//                self.section6Data.append(contentsOf: result.record)
//                self.section6Data.append(contentsOf: result.record)
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
            self.tableCellAtIndexPath.append([.section1])
            self.tableCellAtIndexPath.append([.section2])
            self.tableCellAtIndexPath.append([.section3])
            self.tableCellAtIndexPath.append([.section4])
            self.tableCellAtIndexPath.append([.section5])
        }else{
            self.tableCellAtIndexPath.append([.section1])
            self.tableCellAtIndexPath.append([.section2])
            self.tableCellAtIndexPath.append([.section3])
            self.tableCellAtIndexPath.append([.section4])
            self.tableCellAtIndexPath.append([.section5])
            self.tableCellAtIndexPath.append([.section6])
        }
        getNewsListing()
    }
}
