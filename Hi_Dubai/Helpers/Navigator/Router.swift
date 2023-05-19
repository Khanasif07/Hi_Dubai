//
//  Router.swift
//  Hi_Dubai
//
//  Created by Asif Khan on 17/05/2023.
//

import Foundation
import UIKit
import AVKit
//import DataCache
//import UserNotifications
//import FirebaseDatabase

class Router: NSObject {
    
    static let shared = Router()
    var player: AVPlayer?
    
    var showingVersionPopup: Bool = false
    
    private override init() { }
    
    let mainNavigation: UINavigationController = {
        let navigation = UINavigationController()
        navigation.isNavigationBarHidden = true
        navigation.automaticallyAdjustsScrollViewInsets = false
        navigation.interactivePopGestureRecognizer?.isEnabled = true
        return navigation
    }()
    
    var currentTabNavigation: UINavigationController?
//    var tabbar: TabBarVC?
    
}

typealias FunctionType<Result: Any> = (() -> Result)?

protocol VCConfigurator {
    
    associatedtype RequiredParams
    func configureWithParameters(param : RequiredParams)
}

extension VCConfigurator {
    func configureWithParameters(param : ()){ }
}

extension Router {
    
    enum NavigationController {
        case main, current
    }
    
    enum NavigationAction {
        case push, pop, present, dismiss
    }
    
    func navigate(vc: UIViewController? = nil,
                  action: NavigationAction = .push,
                  navigationController: Router.NavigationController = .current) {
        
//        switch action {
//        case .push, .present:
//            guard let vc = vc else { return }
//            if navigationController == .main {
//                if action == .push {
//                    self.mainNavigation.dismiss(animated: true, completion: nil)
//                    self.mainNavigation.pushViewController(vc, animated: true)
////                    if showingVersionPopup {
////                        if let data = AppUserDefaults.value(forKey: .versionData).dictionaryObject {
////                            self.checkForUpdate(data: data,isMandatory:true)
////                        }
////                    }
//                } else {
//                    self.mainNavigation.present(vc, animated: true, completion: nil)
//                }
//            } else {
//                if action == .push {
//                    if !(CallController.shared.connected || CallController.shared.pictureInPictureMode) {
//                        self.currentTabNavigation?.dismiss(animated: true, completion: nil)
//                    }
//                    self.currentTabNavigation?.pushViewController(vc, animated: true)
//                } else {
//                    self.currentTabNavigation?.present(vc, animated: true, completion: nil)
//                }
//            }
//        case .pop, .dismiss:
//            guard let vc = vc else {
//                let nav = navigationController == .current ? self.currentTabNavigation ?? self.mainNavigation : self.mainNavigation
//                if action == .pop {
//                    nav.popViewController(animated: true)
//                } else if action == .dismiss {
//                    nav.dismiss(animated: true, completion: nil)
//                }
//                return
//            }
//
//            if navigationController == .main {
//                guard let toVC = self.mainNavigation.viewControllers.last(where: {$0 === vc}) else { return }
//                if action == .pop {
//                    self.mainNavigation.popToViewController(toVC, animated: true)
//                } else {
//                    toVC.dismiss(animated: true, completion: nil)
//                }
//            } else {
//                guard let toVC = self.currentTabNavigation?.viewControllers.last(where: {$0 === vc}) else { return }
//                if action == .pop {
//                    self.currentTabNavigation?.popToViewController(toVC, animated: true)
//                } else {
//                    toVC.dismiss(animated: true, completion: nil)
//                }
//            }
//        }
    }
    
    func navigate<T: VCConfigurator & UIViewController, U: Any>(to: T.Type,
                                                                storyboard: AppStoryboard?,
                                                                action: NavigationAction = .push,
                                                                animated: Bool = true,
                                                                navigationController: Router.NavigationController = .current,
                                                                closure : FunctionType<U>) {
        switch action {
        case .push, .present:
            let toVC: T
            if let storyboard = storyboard {
                toVC = T.instantiate(fromAppStoryboard: storyboard)
            } else {
                toVC = T()
            }
            
            if let params = closure?() as? T.RequiredParams {
                toVC.configureWithParameters(param: params)
            }
            if navigationController == .main {
                if action == .push {
                    self.mainNavigation.dismiss(animated: true, completion: nil)
                    self.mainNavigation.pushViewController(toVC, animated: animated)
//                    if showingVersionPopup {
//                        if let data = AppUserDefaults.value(forKey: .versionData).dictionaryObject {
////                            self.checkForUpdate(data: data,isMandatory:true)
//                        }
//                    }
                } else {
                    self.mainNavigation.present(toVC, animated: animated, completion: nil)
                }
            } else {
//                if action == .push {
//                    if !(CallController.shared.connected || CallController.shared.pictureInPictureMode) {
//                        self.currentTabNavigation?.dismiss(animated: true, completion: nil)
//                    }
//                    self.currentTabNavigation?.pushViewController(toVC, animated: animated)
//                } else {
//                    self.currentTabNavigation?.present(toVC, animated: animated, completion: nil)
//                }
            }
        case .pop, .dismiss:
            if navigationController == .main {
                guard let toVC = self.mainNavigation.viewControllers.last(where: {$0 is T}) else { return }
                if action == .pop {
                    self.mainNavigation.popToViewController(toVC, animated: animated)
                } else {
                    toVC.dismiss(animated: animated, completion: nil)
                }
            } else {
                guard let toVC = self.currentTabNavigation?.viewControllers.last(where: {$0 is T}) else { return }
                if action == .pop {
                    self.currentTabNavigation?.popToViewController(toVC, animated: animated)
                } else {
                    toVC.dismiss(animated: animated, completion: nil)
                }
            }
        }
    }
}

extension Router {
    
    /// Show Action Sheet With Actions Array
    func showActionSheetWithActionArray(_ title: String?, message: String?,
                                        viewController: UIViewController = Router.shared.mainNavigation,
                                        alertActionArray : [UIAlertAction],
                                        preferredStyle: UIAlertController.Style)  {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: preferredStyle)
        
        alertActionArray.forEach{ alert.addAction($0) }
        
        DispatchQueue.main.async {
            viewController.present(alert, animated: true, completion: nil)
        }
    }
    
    /// Setup First screen
    func goToFirstScreen() {
//        let tutorialDisplayed = AppUserDefaults.value(forKey: .tutorialDisplayed).stringValue
//
//        if !tutorialDisplayed.isEmpty {
//
//            if UserModel.main.id.isNotBlank {
//                if let isSubscriptionExpired =  UserModel.main.isSubscriptionExpired, isSubscriptionExpired {
//                    goToPlansVC()
//                } else {
//                    self.goToHome()
//                }
//            } else {
//
//                if AppDelegate.shared.openedFromUrl {
//
//                    self.goToLogin(forcePush: true)
//
//                } else {
//
//                    //                    self.goToLogin()
//                    self.goToWalkthrough()
//                }
//            }
//
//        } else {
//            self.goToWalkthrough()
//        }
//        if let data = AppUserDefaults.value(forKey: .versionData).dictionaryObject {
//            Router.shared.checkForUpdate(data: data,isMandatory:true)
//        }
    }
    
    /// Go To Home Screen
//    func goToHome() {
//
//        if let referredCode = AppUserDefaults.value(forKey: .referredCode).string, !referredCode.isEmpty {
//            AppUserDefaults.removeValue(forKey: .referredCode)
//        }
//
//        let mainViewController = TabBarVC.instantiate(fromAppStoryboard: .Home)
//        printDebug("""
//        goToHome
//        ====================
//        ==============
//        ====================
//        """)
//        ChatSocketHelper.sharedInstance.establishConnection()
//
//        self.mainNavigation.viewControllers.removeAll()
//        self.mainNavigation.viewControllers.insert(mainViewController, at: 0)
//
//        self.mainNavigation.interactivePopGestureRecognizer?.isEnabled = true
//
//
//        UIView.transition(with: AppDelegate.shared.window!, duration: 0.33, options: UIView.AnimationOptions.transitionCrossDissolve, animations: {
//            AppDelegate.shared.window?.rootViewController = self.mainNavigation
//        }, completion: { (finished) in
//            UIApplication.shared.registerForRemoteNotifications()
//        })
//
//        AppDelegate.shared.window?.becomeKey()
//        AppDelegate.shared.window?.makeKeyAndVisible()
//    }
    
    /// Go To Pick Up Plan Screen
//    func goToPlansVC() {
//
//        if let referredCode = AppUserDefaults.value(forKey: .referredCode).string, !referredCode.isEmpty {
//            AppUserDefaults.removeValue(forKey: .referredCode)
//        }
//
//        let mainViewController = SignUpStep4VC.instantiate(fromAppStoryboard: .UpdatedPreLogin)
//        mainViewController.configureWithParameters(param: (UserModel.main , .subscriptionExpired, ""))
//        mainViewController.isFirstScreen = true
//        printDebug("""
//        goToPlansVC
//        ====================
//        ==============
//        ====================
//        """)
//        ChatSocketHelper.sharedInstance.establishConnection()
//
//        self.mainNavigation.viewControllers.removeAll()
//        self.mainNavigation.viewControllers.insert(mainViewController, at: 0)
//
//        self.mainNavigation.interactivePopGestureRecognizer?.isEnabled = true
//
//
//        UIView.transition(with: AppDelegate.shared.window!, duration: 0.33, options: UIView.AnimationOptions.transitionCrossDissolve, animations: {
//            AppDelegate.shared.window?.rootViewController = self.mainNavigation
//        }, completion: { (finished) in
//            UIApplication.shared.registerForRemoteNotifications()
//        })
//
//        AppDelegate.shared.window?.becomeKey()
//        AppDelegate.shared.window?.makeKeyAndVisible()
//    }
    
    /// Go To Login Screen
    // Force Push to push a screen based on url open
//    func goToLogin(forcePush : Bool = false) {
//
//        //        HTTPCookieStorage.shared.removeCookies(since: Date.distantPast)
//        //        AppUserDefaults.removeAllValues()
//
//        let getStartedScene = SignUpStep2VC.instantiate(fromAppStoryboard: .UpdatedPreLogin)
//        //        let getStartedScene = NewLoginVC.instantiate(fromAppStoryboard: .NewPreLogin)
//
//        self.mainNavigation.viewControllers.removeAll()
//        self.mainNavigation.viewControllers.insert(getStartedScene, at: 0)
//
//        UIView.transition(with: AppDelegate.shared.window!, duration: 0.33, options: UIView.AnimationOptions.transitionCrossDissolve, animations: {
//            AppDelegate.shared.window?.rootViewController = self.mainNavigation
//        }, completion: nil)
//
//        AppDelegate.shared.window?.becomeKey()
//        AppDelegate.shared.window?.makeKeyAndVisible()
//
//        if forcePush {
//            Router.shared.navigate(to: SignUpStep1VC.self, storyboard: .UpdatedPreLogin, action: .push, navigationController: .current) {() -> SignUpStep1VC.RequiredParams in
//                return (SignUpType.email, .walkThrough, UserModel(), nil)
//            }
//        }
//    }
    
//    func goToWalkthrough() {
//
//        HTTPCookieStorage.shared.removeCookies(since: Date.distantPast)
//        let latestReceiptValue = AppUserDefaults.value(forKey: .transactionId).stringValue
//        let id = AppUserDefaults.value(forKey: .subscriptionPlanType).stringValue
//        let userId = AppUserDefaults.value(forKey: .subscribedUserId).stringValue
//        AppUserDefaults.removeAllValues()
//        ChatSocketHelper.sharedInstance.closeConnection()
//        AppUserDefaults.save(value: "Displayed", forKey: .tutorialDisplayed)
//
//        if !id.isEmpty {
//            AppUserDefaults.save(value: latestReceiptValue, forKey: .transactionId)
//        }
//
//        if !latestReceiptValue.isEmpty {
//            AppUserDefaults.save(value: id, forKey: .subscriptionPlanType)
//        }
//
//        if !userId.isEmpty {
//            AppUserDefaults.save(value: userId, forKey: .subscribedUserId)
//        }
//
//        let getStartedScene = UpdatedIntroVC.instantiate(fromAppStoryboard: .UpdatedPreLogin)
//
//        self.currentTabNavigation?.viewControllers.removeAll()
//        self.mainNavigation.viewControllers.removeAll()
//        self.mainNavigation.viewControllers.insert(getStartedScene, at: 0)
//
//        UIView.transition(with: AppDelegate.shared.window!, duration: 0.33, options: UIView.AnimationOptions.transitionCrossDissolve, animations: {
//            AppDelegate.shared.window?.rootViewController = self.mainNavigation
//        }, completion: nil)
//
//        AppDelegate.shared.window?.becomeKey()
//        AppDelegate.shared.window?.makeKeyAndVisible()
//    }
    
    /// Go To Call Screen
    //    func goToCall() {
    //
    //        let mainViewController = DummyCallVC.instantiate(fromAppStoryboard: .Call)
    //
    //        self.mainNavigation.viewControllers.removeAll()
    //        self.mainNavigation.viewControllers.insert(mainViewController, at: 0)
    //
    //        UIView.transition(with: AppDelegate.shared.window!, duration: 0.33, options: UIView.AnimationOptions.transitionCrossDissolve, animations: {
    //            AppDelegate.shared.window?.rootViewController = self.mainNavigation
    //        }, completion: { (finished) in
    //            UIApplication.shared.registerForRemoteNotifications()
    //        })
    //
    //        AppDelegate.shared.window?.becomeKey()
    //        AppDelegate.shared.window?.makeKeyAndVisible()
    //    }
    
//    func logout() {
//        logoutHandling()
//    }
    
//    func logoutHandling(onGoingCall : Bool = false) {
//
//        onGoingCall ? self.endCallOnLogout() : self.changeOnlineUserStatus()
//
//        QUserController.shared.logout()
//
//        let dbRef = FireData.shared.databaseRef
//        let userNode = FireDBRootNode.users.rawValue+"/"+FireUserModel.main.fireUserId
//        dbRef.child(userNode).removeAllObservers()
//
//        if onGoingCall {
//            let latestReceiptValue = AppUserDefaults.value(forKey: .transactionId).stringValue
//            let id = AppUserDefaults.value(forKey: .subscriptionPlanType).stringValue
//            let userId = AppUserDefaults.value(forKey: .subscribedUserId).stringValue
//            AppUserDefaults.removeAllValues()
//            ChatSocketHelper.sharedInstance.closeConnection()
//
//            if !id.isEmpty {
//                AppUserDefaults.save(value: latestReceiptValue, forKey: .transactionId)
//            }
//
//            if !latestReceiptValue.isEmpty {
//                AppUserDefaults.save(value: id, forKey: .subscriptionPlanType)
//            }
//
//            if !userId.isEmpty {
//                AppUserDefaults.save(value: userId, forKey: .subscribedUserId)
//            }
//        }
//
//        //Remove all Local dataBase data
//        DataCache.instance.cleanAll()
//        CreateClassApiModel.shared.resetDataModel()
//        CreateTalkApiModel.shared.resetDataModel()
//
//        UserModel.main = UserModel()
//        Router.shared.goToFirstScreen()
//
//        DeviceDetail.fcmToken = "DummyFcmToken"
//        DeviceDetail.deviceToken = "DummyDeviceToken"
//        DeviceDetail.voipToken = "DummyVoipToken"
//
//        //        NotificationCenter.default.post(name: .endCallsOnLogout, object: self)
//        UIApplication.shared.applicationIconBadgeNumber = 0
//        UNUserNotificationCenter.current().removeAllDeliveredNotifications()
//    }
    
//    func showAlert(string : String) {
//        let alert = UIAlertController(title: "" , message: string, preferredStyle: UIAlertController.Style.alert)
//        alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
//        alert.addAction(UIAlertAction(title: "Logout", style: .default, handler: { action in
//            self.endCallOnLogout()
//            self.logoutHandling(onGoingCall: true)
//        }))
//        AppDelegate.shared.window?.rootViewController?.present(alert, animated: true, completion: nil)
//    }
    
//    func endCallOnLogout(fromBlock : Bool = false) {
//        if let callUUId = CallController.shared.callUUID {
//            CallKitManager.instance.endCall(with: callUUId) { [weak self] in
//                CallController.shared.pictureInPictureMode = false
//                CallController.shared.audioCallOngoing = false
//                printDebug("endCall")
//                if !fromBlock {
//                    self?.changeOnlineUserStatus()
//                }
//            }
//        }
//    }
    
//    func changeOnlineUserStatus() {
//        //        FireUserModel.main.deviceToken = " "
//        FireUserModel.main.setUserOnlineStatus(isOnline: false, success: { (ref) in
//            printDebug("success")
//            AppUserDefaults.removeValue(forKey: .fireUserData)
//            let latestReceiptValue = AppUserDefaults.value(forKey: .transactionId).stringValue
//            let id = AppUserDefaults.value(forKey: .subscriptionPlanType).stringValue
//            let userId = AppUserDefaults.value(forKey: .subscribedUserId).stringValue
//            AppUserDefaults.removeAllValues()
//            ChatSocketHelper.sharedInstance.closeConnection()
//
//            if !id.isEmpty {
//                AppUserDefaults.save(value: latestReceiptValue, forKey: .transactionId)
//            }
//
//            if !latestReceiptValue.isEmpty {
//                AppUserDefaults.save(value: id, forKey: .subscriptionPlanType)
//            }
//
//            if !userId.isEmpty {
//                AppUserDefaults.save(value: userId, forKey: .subscribedUserId)
//            }
//
//            FireUserModel.main = FireUserModel()
//        }, failure: { (error) in
//            showToast(error.localizedDescription)
//        })
//    }
//
//
//    func goToUserProfile(userId : String, placeHolderImage: UIImage?, userModel: UserModel?, fromPresentedVC: Bool = false, context: UIViewController? = nil, uploadedByAdmin: Bool = false) {
//
//        if uploadedByAdmin {
//
//            //            self.openAdminPopUP(adminImage: placeHolderImage?.getRoundedImage(size: CGSize(width: 35.0, height: 35.0)) ?? #imageLiteral(resourceName: "Icon-App-29x29"), imageTintColor: AppColors.superBlack, textColor: AppColors.superBlack)
//            FireUserModel.main.findOrCreateSingleChatRoomWithAdmin { (room) in
//                Router.shared.navigate(to: ChatVC.self, storyboard: .Chat, action: .push, navigationController: .current) { () -> ChatVC.RequiredParams in
//                    return (room , .adminChat, nil)
//                }
//            }
//        }
//
//        else {
//
//            if UserModel.main.id != userId {
//
//                if UIApplication.topViewController().className == OtherUserProfileVC.className {
//                    return
//                }
//
//                if fromPresentedVC {
//
//                    let otherUserVC = OtherUserProfileVC.instantiate(fromAppStoryboard: .Chat)
//                    otherUserVC.configureWithParameters(param: (ChatRoomModel(), userId,nil,placeHolderImage,userModel))
//                    let nav = UINavigationController(rootViewController: otherUserVC)
//                    nav.isNavigationBarHidden = true
//                    context?.presentDetail(nav)
//
//                } else {
//                    Router.shared.navigate(to: OtherUserProfileVC.self, storyboard: .Chat, action: .push, navigationController: .current) { () -> OtherUserProfileVC.RequiredParams in
//                        return (ChatRoomModel(), userId,nil,placeHolderImage,userModel)
//                    }
//                }
//
//            } else {
//
//                if UIApplication.topViewController().className == MyProfileVC.className {
//                    return
//                }
//
//                if fromPresentedVC {
//
//                    let myProfileVC = MyProfileVC.instantiate(fromAppStoryboard: .SuperYou)
//
//                    let nav = UINavigationController(rootViewController: myProfileVC)
//                    nav.isNavigationBarHidden = true
//                    context?.presentDetail(nav)
//
//                } else {
//                    Router.shared.navigate(to: MyProfileVC.self, storyboard: .SuperYou, action: .push, navigationController: .current) {() -> MyProfileVC.RequiredParams in
//                        return
//                    }
//                }
//            }
//        }
//    }
//
//    func createEditTalkClass(nameOfVC : String ,toEdit: Bool, fromTalk: Bool, talk: TalkModel?, classe: ClassModel?) {
//
//        if fromTalk {
//
//            AppUserDefaults.save(value: nameOfVC, forKey: AppUserDefaults.Key.talkCreateFromVC)
//
//            if toEdit {
//
//                CreateTalkApiModel.shared.isEditing = true
//
//                /// Deep Copy
//                CreateTalkApiModel.shared.talkModel = talk?.copy() as? TalkModel
//
//                Router.shared.navigate(to: CreateClassVC.self, storyboard: .Classes, action: .push, navigationController: .current) { () -> CreateClassVC.RequiredParams in
//                    return (true, nil, [])
//                }
//
//            } else {
//
//                Router.shared.navigate(to: TalksFilterVC.self, storyboard: .UpdatedTalks, action: .push, navigationController: .current) {() -> TalksFilterVC.RequiredParams in
//                    return
//                }
//            }
//
//        } else {
//
//            guard CreateClassApiModel.shared.dataModel.title.isEmpty else {
//
//                showToast(LS.alreadyCreatingClass)
//                return
//            }
//
//            AppUserDefaults.save(value: nameOfVC, forKey: AppUserDefaults.Key.classCreateFromVC)
//
//            if toEdit {
//
//                CreateClassApiModel.shared.isEditing = true
//
//                /// Deep Copy
//                CreateClassApiModel.shared.dataModel = (classe ?? ClassModel()).copy() as! ClassModel
//
//                Router.shared.navigate(to: CreateClassVC.self, storyboard: .Classes, action: .push, navigationController: .current) { () -> CreateClassVC.RequiredParams in
//                    return (false, nil, [])
//                }
//
//            } else {
//
//                let vc = CreateYourClassVC.instantiate(fromAppStoryboard: .LiveVideo)
//                Router.shared.currentTabNavigation?.pushViewController(vc, animated: true)
//            }
//        }
//    }
//
//    func editScheduleClass(nameOfVC : String, classe: ClassModel?) {
//
//        AppUserDefaults.save(value: nameOfVC, forKey: AppUserDefaults.Key.classCreateFromVC)
//
//        let vc = AddYourTitleVC.instantiate(fromAppStoryboard: .LiveVideo)
////        var model = LiveUserModel(userData: classe?.userData, classModel: classe)
//        vc.classModel = classe
////        vc.scheduledOn = classe?.scheduledOn
////        vc.liveUserModel = model
//        vc.toEdit = true
//        Router.shared.currentTabNavigation?.pushViewController(vc, animated: true)
//    }
//
//    func openAVPlayerVC(videoUrl: String?) {
//        if let vUrl = URL(string: /videoUrl) {
//            let player = AVPlayer(url: vUrl)
//
//            let pController = AVPlayerViewController()
//            pController.player = player
//            Router.shared.currentTabNavigation?.present(pController, animated: true, completion: {
//                player.play()
//            })
//        }
//    }
//
////    @objc func didEnterBackground(){
////        printDebug("player is paused!")
////        self.player?.pause()
////    }
////
////    @objc func applicationDidBecomeActive(){
////        printDebug("player is playing again!")
////        self.player?.play()
////    }
//
//    func redirectToNotificationType(model: NotificationModel, isFromMyProfile: Bool = false, placeHolderImage: UIImage?, userModel: UserModel? = nil ) {
//
//        if  let type = model.type, !type.isEmpty {
//
//            switch type {
//
//            case "8", "1800": //.LIKE_DISLIKE_CLASS postId -> classId
//
//                let classModel = ClassModel.init()
//                classModel.id = /model.enitiyId//.pushData?.postId
//
//                let vc = ClassDetailVC.instantiate(fromAppStoryboard: .Classes)
//                vc.isStory = model.isStory ?? false
//                vc.configureWithParameters(param: classModel)
//
//                if let commentId = model.commentId {
//                    classModel.commentId = commentId
//                    vc.shouldOpenComment = true
//                }
//
//                Router.shared.currentTabNavigation?.dismiss(animated: true, completion: nil)
//                Router.shared.currentTabNavigation?.pushViewController(vc, animated: true)
//                break
//
//
//            case "9","11": //.LIKE_DISLIKE_TALK , .TALK_COMMENT postId -> talkId
//
//                let modelTalk = TalkModel.init()
//                modelTalk.id = /model.enitiyId //.pushData?.postId  // entityId for normal cases
//
//                if let commentId = model.commentId {
//                    modelTalk.commentId = commentId
//                }
//
//                Router.shared.navigate(to: TalkDetailVC.self, storyboard: .UpdatedTalks, action: .push, navigationController: .current) {() -> TalkDetailVC.RequiredParams in
//                    return (modelTalk, .main,nil , nil)
//                }
//
//                break
//
//            case "16": //.FOLLOW_USER userId - > Profile open
//                Router.shared.goToUserProfile(userId: model.userData.id, placeHolderImage: placeHolderImage, userModel: userModel)
//                break
//
//            default:
//                break
//            }
//            return
//        }
//
//        if let type = model.typeInt, type >= 0 {
//
//            switch type {
//
//            case 8, 1800: //.LIKE_DISLIKE_CLASS postId -> classId
//
//                let classModel = ClassModel.init()
//                classModel.id = /model.enitiyId//.pushData?.postId
//
//                let vc = ClassDetailVC.instantiate(fromAppStoryboard: .Classes)
//                vc.isStory = model.isStory ?? false
//                vc.configureWithParameters(param: classModel)
//
//                vc.shouldOpenComment = type == 1800
//
//                //                vc.isStory = true
//                Router.shared.currentTabNavigation?.dismiss(animated: true, completion: nil)
//                Router.shared.currentTabNavigation?.pushViewController(vc, animated: true)
//                break
//
//
//            case 9,11: //.LIKE_DISLIKE_TALK , .TALK_COMMENT postId -> talkId
//
//                let modelTalk = TalkModel.init()
//                modelTalk.id = /model.enitiyId //.pushData?.postId  // entityId for normal cases
//
//                Router.shared.navigate(to: TalkDetailVC.self, storyboard: .UpdatedTalks, action: .push, navigationController: .current) {() -> TalkDetailVC.RequiredParams in
//                    return (modelTalk, .main,nil , nil)
//                }
//
//                break
//
//            case 16: //.FOLLOW_USER userId - > Profile open
//                Router.shared.goToUserProfile(userId: model.userData.id, placeHolderImage: placeHolderImage, userModel: userModel)
//                break
//
//            default:
//                break
//            }
//        }
//    }
}

//MARK :- VERSION MANAGEMENT
//==========================
extension Router {
    
//    func checkForUpdate(data:[AnyHashable:Any]?,isMandatory:Bool = false){
//        guard let data = data else{
//            AppUserDefaults.removeValue(forKey: .versionData)
//            if showingVersionPopup {
//                showingVersionPopup = false
//                mainNavigation.dismiss(animated: true, completion: nil)
//            }
//            return
//        }
//        if let lastForceUpdateVersionData = VersionModel(jsonDict: JSON(data)["lastforceupdatedetails"].stringValue.dictValue){
//            if AppUserDefaults.value(forKey: .laterVersion).stringValue != lastForceUpdateVersionData.versionNumber {
//                if showingVersionPopup {
//                    showingVersionPopup = false
//                    mainNavigation.dismiss(animated: true, completion: nil)
//                }
//            }
//            if checkIfHigherVersion(version: lastForceUpdateVersionData.versionNumber) {
//                AppUserDefaults.save(value: data, forKey: .versionData)
//                self.showUpdatePopUp(version: lastForceUpdateVersionData,isMandatory: isMandatory)
//                return
//            }
//        }
//        if let currentVersionData = VersionModel(jsonDict: JSON(data)["currentversiondetails"].stringValue.dictValue) {
//            if AppUserDefaults.value(forKey: .laterVersion).stringValue != currentVersionData.versionNumber {
//                if showingVersionPopup {
//                    showingVersionPopup = false
//                    mainNavigation.dismiss(animated: true, completion: nil)
//                }
//            }
//            if checkIfHigherVersion(version: currentVersionData.versionNumber) {
//                AppUserDefaults.save(value: data, forKey: .versionData)
//                self.showUpdatePopUp(version: currentVersionData,isMandatory: isMandatory)
//                return
//            }
//        }
//        if showingVersionPopup {
//            showingVersionPopup = false
//            mainNavigation.dismiss(animated: true, completion: nil)
//        }
//        AppUserDefaults.removeValue(forKey: .versionData)
//    }
//    
//    private func checkIfHigherVersion(version: String) -> Bool {
//        guard let versionComparison = Bundle.main.versionNumber?.compare(version, options: .numeric) else{return false}
//        switch versionComparison {
//        case .orderedSame, .orderedDescending:
//            return false
//        case .orderedAscending:
//            return true
//        }
//    }
//    
//    func showUpdatePopUp(version:VersionModel,isMandatory:Bool = false){
//        if AppUserDefaults.value(forKey: .laterVersion).stringValue == version.versionNumber && !isMandatory && version.versionType != .force {
//            return
//        }
//        AppUserDefaults.save(value: version.versionNumber, forKey: .laterVersion)
//        showingVersionPopup = true
//        let alert = UIAlertController(title: version.versionTitle, message: version.versionDescription, preferredStyle: .alert)
//        let updateAction = UIAlertAction(title: LS.update.uppercased(), style: .default) { (action) in
//            if let url = URL(string: AppConstants.appStoreUrl) {
//                UIApplication.shared.open(url, options: [:], completionHandler: nil)
//                if version.versionType == .force {
//                    self.showUpdatePopUp(version: version)
//                }
//            }
//        }
//        let laterAction = UIAlertAction(title: LS.later.uppercased(), style: .default) { (action) in
//            alert.dismiss(animated: true, completion: nil)
//            self.showingVersionPopup = false
//        }
//        if version.versionType == .normal {
//            alert.addAction(laterAction)
//        }
//        alert.addAction(updateAction)
//
//        self.navigate(vc: alert, action: .present, navigationController: .main)
//    }
//    
    
    
}


/*
 case CALLING    = "1"
 case START_LIVE = "4"
 
 case LIKE_DISLIKE_TALK = "9"
 case LIKE_DISLIKE_CLASS = "8"
 
 case TALK_COMMENT = "11"
 case FOLLOW_USER = "16"
 
 case SCHEDULE_LIVE_STREAM = "17"
 
 case CHAT_IMAGE = "13"
 case CHAT_TEXT = "14"
 case CHAT_VIDEO = "15"
 
 */
