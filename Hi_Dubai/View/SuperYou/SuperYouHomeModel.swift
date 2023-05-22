//
//  SuperYouHomeModel.swift
//  Hi_Dubai
//
//  Created by Asif Khan on 17/05/2023.
//

import Foundation
import UIKit
import SwiftyJSON
typealias JSONDictionary = [String : Any]
typealias JSONDictionaryArray = [JSONDictionary]
typealias SuccessJSONResponse = (_ json : JSON) -> Void
typealias FailureResponse = (NSError) -> (Void)
typealias ResponseMessage = (_ message : String) -> ()
class SuperYouHomeModel {
    //now talksCell is most discussed cell
    enum TableViewCell {
        case titleAndSubTitle, cardCells, videoCell, upcomingCell, favoritesCell,liveClassesCell, mostLovedClassesCell, newSuperShesCell, featuredCell, superPowers, pastLive, categories
    }
    
    var tableCellAtIndexPath: [[TableViewCell]] = []
    var sectionData: [Int] = []
    var titleData: SuperYouHomeTitleData?
    var cardData: SuperYouCardData?
    var videoData: SuperYouVideoData?
    var upcomingDataArr: [Record] = []
    var liveNowDataArr: [Record] = []
    var favouriteDataArr: [Record] = []
    var newSuperShesArr: [Record] = []
    var mostDiscussedTalks: [Record] = []
    var mostLovedArr: [Record] = []
    var featuredDataArr: [Record] = []
    var pastLiveData: [Record] = []
    var categories: [Record] = []
    var isFirstTime: Bool = true
    
    convenience init(nextPageStatus: Bool) {
        self.init(jsonArr: [[:]], isDataFromLocalDB: false, nextPageStatus: nextPageStatus)
    }
    
    init(jsonArr: [JSONDictionary], isDataFromLocalDB: Bool, nextPageStatus: Bool) {
        
        self.dataMappingInModel(jsonArr: jsonArr)
    }
    // api....
    weak var delegate: NewsListViewModelDelegate?
    private (set) var newsData = [Record]()
    var error : Error?
    func getNewsListing(){
        NetworkManager.shared.getDataFromServer(requestType: .get, endPoint: EndPoint.news.rawValue) { (results : Result<News,Error>)  in
            switch results {
            case .success(let result):
                self.mostLovedArr = result.record
                self.upcomingDataArr = result.record
                self.liveNowDataArr = result.record
                self.featuredDataArr = result.record
                self.newSuperShesArr = result.record
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
            self.tableCellAtIndexPath.append([.mostLovedClassesCell])
//            self.tableCellAtIndexPath.append([.upcomingCell])
            self.tableCellAtIndexPath.append([.liveClassesCell])
            self.tableCellAtIndexPath.append([.featuredCell])
            self.tableCellAtIndexPath.append([.newSuperShesCell])
            self.tableCellAtIndexPath.append([.categories])
            self.tableCellAtIndexPath.append([.upcomingCell])
            self.tableCellAtIndexPath.append([.pastLive])
        }else{
           
            self.tableCellAtIndexPath.append([.mostLovedClassesCell])
//            self.tableCellAtIndexPath.append([.upcomingCell])
            self.tableCellAtIndexPath.append([.liveClassesCell])
            self.tableCellAtIndexPath.append([.newSuperShesCell])
            self.tableCellAtIndexPath.append([.categories])
            self.tableCellAtIndexPath.append([.featuredCell])
            self.tableCellAtIndexPath.append([.newSuperShesCell])
            self.tableCellAtIndexPath.append([.upcomingCell])
            self.tableCellAtIndexPath.append([.pastLive])
        }
        
        getNewsListing()
//        for (index,json) in jsonArr.enumerated() {
//            if let type = json[ApiKey.type] as? Int {
//                switch type {
//                case 0:
//                    print(type)
//                case 1:
//                    if let obj = json[ApiKey.mostLoved] as? JSONDictionaryArray, obj.count > 0 {
////                        self.mostLovedArr = ClassModel.getClassesArray(JSON(obj))
//                        if !self.tableCellAtIndexPath.contains([.mostLovedClassesCell]) && self.mostLovedArr.count > 0 {
//                            self.tableCellAtIndexPath.append([.mostLovedClassesCell])
//                            self.sectionData.append(index)
//                        }
//                    }
//                    print(type)
//                case 2:
//                    if let obj = json[ApiKey.upcoming] as? JSONDictionaryArray, obj.count > 0 {
////                        self.upcomingDataArr = ClassModel.getClassesArray(JSON(obj))
//                        if !self.tableCellAtIndexPath.contains([.upcomingCell]) && self.upcomingDataArr.count > 0 {
//                            self.tableCellAtIndexPath.append([.upcomingCell])
//                            self.sectionData.append(index)
//                        }
//                    }
//                    print(type)
//                case 3:
//                    if let obj = json[ApiKey.live] as? JSONDictionaryArray, obj.count > 0 {
////                        self.liveNowDataArr = ClassModel.getClassesArray(JSON(obj))
//                        if !self.tableCellAtIndexPath.contains([.liveClassesCell]) && self.liveNowDataArr.count > 0  {
//                            self.tableCellAtIndexPath.append([.liveClassesCell])
//                            self.sectionData.append(index)
//                        }
//                    }
//                    print(type)
//                case 4:
//                    if let obj = json[ApiKey.featured] as? JSONDictionaryArray, obj.count > 0 {
////                        self.featuredDataArr = ClassModel.getClassesArray(JSON(obj))
//                        if !self.tableCellAtIndexPath.contains([.featuredCell]) && self.featuredDataArr.count > 0 {
//                            self.tableCellAtIndexPath.append([.featuredCell])
//                        }
//                    }
//                    print(type)
//                case 5:
//                    if let obj = json[ApiKey.newSupershes] as? JSONDictionaryArray, obj.count > 0 {
////                        self.newSuperShesArr = UserModel.getUserArray(JSON(obj))
//                        if !self.tableCellAtIndexPath.contains([.newSuperShesCell]) && self.newSuperShesArr.count > 0 {
//                            self.tableCellAtIndexPath.append([.newSuperShesCell])
//                            self.sectionData.append(index)
//                        }
//                    }
//                    print(type)
//                case 6:
//                    if let obj = json[ApiKey.favourites] as? JSONDictionaryArray, obj.count > 0 {
////                        self.favouriteDataArr = NotificationModel.getNotArray(JSON(obj))
//                        if !self.tableCellAtIndexPath.contains([.favoritesCell]) && self.favouriteDataArr.count > 0 {
//                            self.tableCellAtIndexPath.append([.favoritesCell])
//                            self.sectionData.append(index)
//                        }
//                    }
//                    print(type)
//                case 7:
//                    if let obj = json[ApiKey.mostDiscussed] as? JSONDictionaryArray, obj.count > 0 {
////                        self.mostDiscussedTalks = TalkModel.getTalksArray(JSON(obj))
//                        if !self.tableCellAtIndexPath.contains([.talksCell]) && self.mostDiscussedTalks.count > 0 {
//                            self.tableCellAtIndexPath.append([.talksCell])
//                            self.sectionData.append(index)
//                        }
//                    }
//                    print(type)
//                case 8:
//                    if let obj = json[ApiKey.welcomeMessage] as? JSONDictionary , !obj.isEmpty {
////                        self.titleData = SuperYouHomeTitleData(json: obj)
//                        self.titleData?.type = type
//                        if !self.tableCellAtIndexPath.contains([.titleAndSubTitle]) && !obj.isEmpty {
//                            self.tableCellAtIndexPath.append([.titleAndSubTitle])
//                        }
//                    }
//                    print(type)
//                case 9:
//                    if let obj = json[ApiKey.welcomeVideo] as? JSONDictionary, !obj.isEmpty {
////                        self.videoData = SuperYouVideoData(json: obj)
//                        self.videoData?.type = type
//                        if !self.tableCellAtIndexPath.contains([.videoCell]) && !obj.isEmpty {
//                            self.tableCellAtIndexPath.append([.videoCell])
//                        }
//                    }
//                    print(type)
//                case 10:
//                    if let obj = json[ApiKey.rewardsDetail] as? [JSONDictionary], obj.count > 0 {
////                        self.cardData = SuperYouCardData(jsonArr: obj)
//                        self.cardData?.type = type
//                        if !self.tableCellAtIndexPath.contains([.cardCells]) && obj.count > 0 {
//                            self.tableCellAtIndexPath.append([.cardCells])
//                        }
//                    }
//                    print(type)
//                case 21:
//                    if let obj = json[ApiKey.pastLive] as? [JSONDictionary], obj.count > 0 {
////                        self.pastLiveData = ClassModel.getClassesArray(JSON(obj))
//                        if !self.tableCellAtIndexPath.contains([.pastLive]) && self.pastLiveData.count > 0 {
//                            self.tableCellAtIndexPath.append([.pastLive])
//                            self.sectionData.append(index)
//                        }
//                    }
//
//                case 999:
//                    if !self.tableCellAtIndexPath.contains([.inviteCell]) && !nextPageStatus {
//                        self.tableCellAtIndexPath.append([.inviteCell])
//                    }
//
//                default:
//                    print(type)
//                }
//            }
//        }
    }
}

struct SuperYouHomeTitleData {
    
    var firstName: String = ""
    var bottomTtitle: String = ""
    var topTitle: String = ""
    var type: Int = -1
    
    init() {
        self.init(json: [:])
    }
    
    init(json: JSONDictionary) {
        if let obj = json[ApiKey.firstName] {
            self.firstName = "\(obj)"
        }
        if let obj = json[ApiKey.bottom] {
            self.bottomTtitle = "\(obj)"
        }
        if let obj = json[ApiKey.top] {
            self.topTitle = "\(obj)"
        }
        if let obj = json[ApiKey.type] as? Int {
            self.type = obj
        }
    }
}

struct SuperYouCardData {
    
    enum CollectionCellTypes {
        case credsCell, rewardCell, badgesCell, redeemCell
    }
    
    var credData: SuperYouCredsData?
    var rewardData: SuperYouCrushingItData?
    var type: Int = -1
    var cellData: [CollectionCellTypes] = []
    var badgeData: SuperYouBadgeData?
    var redeemData: SuperYouRedeemData?
    
    init() {
        self.init(jsonArr: [[:]])
    }
    
    init(jsonArr: [JSONDictionary]) {
        self.cellData.append(.credsCell)
        self.cellData.append(.rewardCell)
        for json in jsonArr {
//            if let type = json[ApiKey.type] as? String {
//                if type == "CREDS" {
//                    self.credData = Record()
//                    self.cellData.append(.credsCell)
//                } else if type == "TIER" {
//                    self.rewardData = Record()
//                    self.cellData.append(.rewardCell)
//                } else if type == "BADGE" {
//                    self.badgeData = Record()
//                    self.cellData.append(.badgesCell)
//                } else if type == "REDEEM" {
//                    self.redeemData = Record()
//                    self.cellData.append(.redeemCell)
//                }
//            }
        }
    }
    
    
    
    struct SuperYouCredsData {
        var name: String = ""
        var rewards: Int = 0
        var colour: String = ""
        var icon: String = ""
        var type: String = ""
        
        init() {
            self.init(json: [:])
        }
        
        init(json: JSONDictionary) {
            if let obj = json[ApiKey.name] {
                self.name = "\(obj)"
            }
            if let obj = json[ApiKey.rewards] as? Int {
                self.rewards = obj
            }
            if let obj = json[ApiKey.colour] {
                self.colour = "\(obj)"
            }
            if let obj = json[ApiKey.icon] {
                self.icon = "\(obj)"
            }
        }
    }
    
    struct SuperYouCrushingItData {
        var message: String = ""
        var currentLevel: Int = 1
        var totalLevels: Int = 1
        var colour: String = ""
        var icon: String = ""
        var type: String = ""
        var getPlaceHolderImageName: UIImage {
            
            switch self.currentLevel {
                
            case 1:
                return #imageLiteral(resourceName: "red_Unstoppable")
            case 2:
                return #imageLiteral(resourceName: "red_crushing_It")
            case 3:
                return #imageLiteral(resourceName: "fierce_AF")
            case 4:
                return #imageLiteral(resourceName: "the_Queen")
            default:
                return #imageLiteral(resourceName: "the_Queen")
            }
            
        }
        
        
        init() {
            self.init(json: [:])
        }
        
        init(json: JSONDictionary) {
            if let obj = json[ApiKey.message] {
                self.message = "\(obj)"
            }
            if let obj = json[ApiKey.currentLevel] as? Int {
                self.currentLevel = obj
            }
            if let obj = json[ApiKey.totalLevels] as? Int {
                self.totalLevels = obj
            }
            if let obj = json[ApiKey.colour] {
                self.colour = "\(obj)"
            }
            if let obj = json[ApiKey.icon] {
                self.icon = "\(obj)"
            }
        }
    }
    
    struct SuperYouBadgeData {
        var badgeIcon: [String] = []
        var message: String = ""
        var type: String = ""
        var colour: String = ""
        
        init() {
            self.init(json: [:])
        }
        
        init(json: JSONDictionary) {
            if let obj = json[ApiKey.message] {
                self.message = "\(obj)"
            }
            if let obj = json[ApiKey.colour] {
                self.colour = "\(obj)"
            }
            if let obj = json[ApiKey.type] {
                self.type = "\(obj)"
            }
            if let obj = json[ApiKey.colour] {
                self.colour = "\(obj)"
            }
            if let obj = json[ApiKey.badgeData] as? [String] {
                self.badgeIcon = obj
            }
        }
    }
    
    struct SuperYouRedeemData {
        var name: String = ""
        var message: String = ""
        var type: String = ""
        var icon: String = ""
        var colour: String = ""
        
        init() {
            self.init(json: [:])
        }
        
        init(json: JSONDictionary) {
            if let obj = json[ApiKey.name] {
                self.name = "\(obj)"
            }
            if let obj = json[ApiKey.message] {
                self.message = "\(obj)"
            }
            if let obj = json[ApiKey.type] {
                self.type = "\(obj)"
            }
            if let obj = json[ApiKey.colour] {
                self.colour = "\(obj)"
            }
            if let obj = json[ApiKey.icon] {
                self.icon = "\(obj)"
            }
        }
    }
    
}

struct SuperYouVideoData {
    var thumbnail: String = ""
    var original: String = ""
    var height: Double = 0.0
    var width: Double = 0.0
    var preview: String = ""
    var type: Int = -1
    
    init() {
        self.init(json: [:])
    }
    
    init(json: JSONDictionary) {
        if let obj = json[ApiKey.thumbnail] {
            self.thumbnail = "\(obj)"
        }
        if let obj = json[ApiKey.original] {
            self.original = "\(obj)"
        }
//        if let obj = json[ApiKey.height] {
//            self.height = obj
//        }
//        if let obj = json[ApiKey.width] {
//            self.width =  obj
//        }
        if let obj = json[ApiKey.preview] {
            self.preview = "\(obj)"
        }
    }
}

struct FavouriteData {
    var message: String = ""
//    var userData: UserModel?
    var createdOn: String = ""
    var entityId: String = ""

    init() {
        self.init(json: [:])
    }

    init(json: JSONDictionary) {
        if let obj = json[ApiKey.message] {
            self.message = "\(obj)"
        }
//        if let obj = json[ApiKey.userData] {
//            self.userData = UserModel(JSON(obj))
//        }
        if let obj = json[ApiKey.createdOn] {
            self.createdOn = "\(obj)"
        }
        if let obj = json[ApiKey.entityId] {
            self.entityId = "\(obj)"
        }
    }
    
    static func getFavouriteData(_ jsonArr: JSONDictionaryArray) -> [FavouriteData] {
        var favouriteData: [FavouriteData] = []
        for json in jsonArr {
            favouriteData.append(FavouriteData(json: json))
        }
        return favouriteData
    }
}





struct MyProfileModel {
    
    enum TableViewCell {
        case whatsNewCell, yourClassesCell, yourTalksCell, savedClassesCell, superPowers
    }
    
    var tableCellAtIndexPath: [[TableViewCell]] = []
    var whatsNewData: [Record] = []
    var yourClassesData: [Record] = []
    var yourTalksData: [Record] = []
    var savedClassesData: [Record] = []
    var savedTalksData: [Record] = []
    var superPowerData: [Record] = []
    
    init() {
        self.init(jsonArr: [[:]])
    }
    
    init(jsonArr: [JSONDictionary]) {
        
        for json in jsonArr {
            if let type = json[ApiKey.type] as? Int {
                switch type {
                case 1:
                    if let obj = json[ApiKey.ownClasses] as? JSONDictionaryArray {
//                        self.yourClassesData = ClassModel.getClassesArray(JSON(obj))
                        if obj.count > 0 && self.yourClassesData.count > 0 {
                            self.tableCellAtIndexPath.append([.yourClassesCell])
                        }
                    }
                    print(type)

                case 16:
                    if let obj = json[ApiKey.ownNotification] as? JSONDictionaryArray {
//                        self.whatsNewData = NotificationModel.getNotArray(JSON(obj))
                        if obj.count > 0 && self.whatsNewData.count > 0 {
                            self.tableCellAtIndexPath.append([.whatsNewCell])
                        }
                    }
                    
                case 17:
                    if let obj = json[ApiKey.ownTalks] as? JSONDictionaryArray {
//                        self.yourTalksData = TalkModel.getTalksArray(JSON(obj))
                        if obj.count > 0 && self.yourTalksData.count > 0 {
                            self.tableCellAtIndexPath.append([.yourTalksCell])
                        }
                    }
                    print(type)
                    
                case 18:
                    if let obj = json["savedContent"] as? JSONDictionaryArray {
//                        self.savedClassesData = ClassModel.getClassesArray(JSON(obj))
                        if obj.count > 0 && self.savedClassesData.count > 0 {
                            self.tableCellAtIndexPath.append([.savedClassesCell])
                        }
                    }
                    print(type)
                case 20:
                    if let obj = json["superPower"] as? JSONDictionaryArray {
//                        self.superPowerData = TopicModel.getTopicsArray(JSON(obj))
                        if obj.count > 0 && self.superPowerData.count > 0  {
                     self.tableCellAtIndexPath.append([.superPowers])
                        }
                    }
                    print(type)
                default:
                    break
                }
            }
        }
    }
}


