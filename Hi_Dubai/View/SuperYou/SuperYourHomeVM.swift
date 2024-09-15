//
//  SuperYourHomeVM.swift
//  Hi_Dubai
//
//  Created by Asif Khan on 17/05/2023.
//

import Foundation
import SwiftyJSON
import UIKit
protocol SuperYouHomeVMDelegate: NSObject {
    func willHitSuperYouApi()
    func getSuperYouDataSuccess(successMsg: String, isPullToRefresh: Bool, lastPageScrolled: Int)
//    func getSuperYouDataFailed(failedToGetData: String, isPullToRefresh: Bool,errorType: ErrorType)
    func updateDeviceTokenSuccess(successMsg: String)
    func updateDeviceTokenFailed(failedToGetData: String)
}

extension SuperYouHomeVMDelegate{
    func willHitSuperYouApi(){}
    func getSuperYouDataSuccess(successMsg: String, isPullToRefresh: Bool, lastPageScrolled: Int){}
//    func getSuperYouDataFailed(failedToGetData: String, isPullToRefresh: Bool,errorType: ErrorType)
    func updateDeviceTokenSuccess(successMsg: String){}
    func updateDeviceTokenFailed(failedToGetData: String){}
}
class SuperYouHomeVM {
    
    weak var delegate: SuperYouHomeVMDelegate?
    var superYouData: SuperYouHomeModel? = SuperYouHomeModel(nextPageStatus: true)
    var nextPageStatus: Bool = false
    var firstTimeApiCompletion: Bool = false
    var page: Int = 0
    private var isDataLoadedFromLocalDB: Bool = false
    var apiHitCount: Int = 0

 
//    func deleteClassFromEachRail(classType: SuperYouHomeModel.TableViewCell ,classModel: ClassModel? = nil, talkModel: TalkModel? = nil) {
//
//        switch classType {
//
//        case .talksCell:
//            guard let model = talkModel else { return }
//            if let index = self.superYouData?.mostDiscussedTalks.firstIndex(where: {$0.id == model.id}) {
//                self.superYouData?.mostDiscussedTalks.remove(at: index)
//                if !(self.superYouData?.mostDiscussedTalks.count ?? 0 > 0) {
//                    self.superYouData?.tableCellAtIndexPath.removeObject([.talksCell])
//                } else {
//                    printDebug(" There is data in liveClassesCell ")
//                }
//            }
//
//        case .upcomingCell:
//            guard let model = classModel else { return }
//            if let index = self.superYouData?.upcomingDataArr.firstIndex(where: {$0.id == model.id}) {
//                self.superYouData?.upcomingDataArr.remove(at: index)
//                if !(self.superYouData?.upcomingDataArr.count ?? 0 > 0) {
//                    self.superYouData?.tableCellAtIndexPath.removeObject([.upcomingCell])
//                } else {
//                    printDebug(" There is data in upcomingCell ")
//                }
//            }
//        default:
//
//            guard let model = classModel else { return }
////            if let index = self.superYouData?.mostLovedArr.firstIndex(where: {$0.id == model.id}) {
////                self.superYouData?.mostLovedArr.remove(at: index)
////                if !(self.superYouData?.mostLovedArr.count ?? 0 > 0) {
////                    self.superYouData?.tableCellAtIndexPath.removeObject([.mostLovedClassesCell])
////                } else {
////                    printDebug(" There is data in liveClassesCell ")
////                }
////            }
//
////            guard let feaModel = classModel else { return }
////            if let index = self.superYouData?.featuredDataArr.firstIndex(where: {$0.title == feaModel.id}) {
////                self.superYouData?.featuredDataArr.remove(at: index)
////                if !(self.superYouData?.featuredDataArr.count ?? 0 > 0) {
////                    self.superYouData?.tableCellAtIndexPath.removeObject([.featuredCell])
////                } else {
////                    printDebug(" There is data in liveClassesCell ")
////                }
////            }
//        }
//    }
}


struct ClassInitalLayoutConstants {
    
    static let tableHeaderHeight : CGFloat = CGFloat((570/812) * screen_height - 18) // 594
    static let tableFooterHeight : CGFloat = 504
    static let tableSectionHeader = CGFloat((104/812) * screen_height)
    static let tableSectionFooter = CGFloat((50/812) * screen_height) + 58 //Extra space
    static let collLiveCellWidth = CGFloat((165/375) * screen_height)
    static let collLiveCellHeight = CGFloat((347/812) * screen_height)
    static let collMyFavCellHeight = CGFloat((300/812) * screen_height)
    static let newCollLiveCellHeight = CGFloat((293/812) * screen_height) < 270 ? 270 : CGFloat((293/812) * screen_height)
    static let collCellWidth = CGFloat((276/375) * screen_width)
    static let collUpcomingCellWidth = CGFloat((220.0/360.0) * screen_width)
    static let collUpcomingCellHeight = CGFloat((329/812) * screen_height) < 300 ? 300 : CGFloat((329/812) * screen_height)
    static let collCellHeight = CGFloat((447/812) * screen_height)
    static let mostLovedHomeCollCellHeight = CGFloat((349/812) * screen_height) < 320 ? 320 : CGFloat((349/812) * screen_height)
    static let mostLovedHomeCollCellWidth = CGFloat((220.0/375) * screen_width)
    static let collProfileClassCellHeight = CGFloat((349/812) * screen_height)
    static let CollProfileYourtalkHeight = CGFloat((349/812) * screen_height)
    static let collProfileClassCellWidth = CGFloat((220.0/375) * screen_width) + 18
    static let collProfileWhatNewCellHeight = CGFloat(( 86.0/812) * screen_height)
    static let collProfileSuperPowerCellHeight = CGFloat(( 240.0/812) * screen_height) < 220 ? 220 : CGFloat(( 240.0/812) * screen_height)
    //static let collUpcomingCellHeight = CGFloat((267/812) * Screen.HEIGHT) + 40
}

