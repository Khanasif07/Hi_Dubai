//
//  MainTabBarViewController.swift
//  Hi_Dubai
//
//  Created by Asif Khan on 17/05/2023.
//

import Foundation
//import MaterialShowcase
import UIKit
var myProfileVC: UINavigationController?
var badgeAdjusted = false
var wasLaunched = false

class MainTabBarViewController: UITabBarController{
   
    @objc var searchType = 0
    @objc var fromSearchHome = false
    @objc var myProfileVC: UINavigationController?
    @objc var settingsVC: UINavigationController?
//    @objc weak var listeVC: ListsGridVC?
    @objc var keywordsFlag = false
    @objc var fromNotification = false
    @objc var keywordsParam: String?

    private var lastItemSelected = 0
    private var tabViewControllersLogged: [UINavigationController]?
    private var tabViewControllersUnlogged: [UINavigationController]?
    private var exploreVC: ExploreViewController?
    private var tabBarItemNames: [String]?
    private var isTabbarVisible = false
    //@property BOOL shouldShowcaseExploreTab;
    //@property MaterialShowcase *explorShowcaseCointainer;
    private var showCaseSection: String?
    
    
    @objc override var selectedIndex: Int {
        get {
            super.selectedIndex
        }
        set(newValue) {
            print("MainTabBarVC set SelectedIndex = \(newValue)");
            super.selectedIndex = newValue
            
            print("MainTabBarVC dispatch sync");
            self.lastItemSelected = newValue;
//            prepareGlobalSearch()
            
            if (newValue != 2){
//                exploreVC?.removeHighlightShowCaseViewProgramatically()
            }
//            if (appDelegate.fromWebEngageDeeplink) {
//                let childVC = (viewControllers?[0] as? UINavigationController)?.viewControllers[0] as? NewGlobalSearchViewController
//
//                if (appDelegate.webEngageDeeplink == TAB_TOPIC_SECTION) {
//                    childVC?.goToTopicSectionPage()
//                } else if (appDelegate.webEngageDeeplink  == TAB_BUSINESS_SECTION) {
//                    childVC?.go(toBusinessSectionPage: false)
//                } else if (appDelegate.webEngageDeeplink == TAB_LIST_SECTION) {
//                    childVC?.goToListSectionPage()
//                } else if (appDelegate.webEngageDeeplink  == TAB_PEOPLE_SECTION) {
//                    childVC?.goToPeopleSectionPage()
//                }
//
//            }
            
//            if (appDelegate.fromStandardDeeplink) {
//
//
//
//               // print("PUSHPUSH selectedIndex func:\(#line) notificationCode=\((appDelegate.notificationCode as? String) ?? "")")
//
//                let childVC = (viewControllers?[0] as? UINavigationController)?.viewControllers[0] as? NewGlobalSearchViewController
//
//                var notificationCodeInt = Int32(0)
//                let notificationCodeAny:Any = appDelegate.notificationCode
//                if notificationCodeAny is NSNumber {
//                    if let notificationCodeNumber = notificationCodeAny as? NSNumber, let notificationCodeNumberInt = notificationCodeNumber as? Int {
//                        notificationCodeInt = Int32(notificationCodeNumberInt)
//                    }
//
//                }else if notificationCodeAny is String {
//                    if let notificationCodeIntRef  = Int32((notificationCodeAny as? String) ?? "0"){
//                        notificationCodeInt = notificationCodeIntRef
//                    }
//                }
//
//                print("PUSHPUSH notificationCode=\(notificationCodeInt)")
//
//                switch notificationCodeInt {
//                case BUSINESS_STARTED_FOLLOWING:
//                    appDelegate.idFromWebEngageDeeplink = appDelegate.userIdFromStandardDeeplink
//                    childVC?.goToPeopleSectionPage() // user_id
//                case BUSINESS_ADDED_TO_LIST_OR_USER_ADDED_TO_LIST:
//                    appDelegate.idFromWebEngageDeeplink = appDelegate.listIdFromStandardDeeplink
//                    childVC?.goToListSectionPage() // list_id
//                case BUSINESS_SUGGEST_CHANGES:
//                    childVC?.goToBusinessSettingsPage() // business_id
//                case BUSINESS_NOTIFIED_PROBLEM_DEALS:
//                    childVC?.goToBusinessSettingsPage() // business_id
//                case BUSINESS_NOTIFIED_CLOSED_REMOVED:
//                    childVC?.goToBusinessSettingsPage() // business_id
//                case BUSINESS_IMAGE_VIDEO_INAPPROPRIATE:
//                    childVC?.goToBusinessSettingsPage() // business_id
//                case BUSINESS_SUGGEST_ISSUE:
//                    childVC?.goToBusinessSettingsPage() // business_id
//                case USER_STARTED_FOLLOWING:
//                    appDelegate.idFromWebEngageDeeplink = appDelegate.businessIdFromStandardDeeplink;
//                    childVC?.go(toBusinessSectionPage: false) // business_id
//                case USER_CREATED_LIST:
//                    appDelegate.idFromWebEngageDeeplink = appDelegate.listIdFromStandardDeeplink;
//                    childVC?.goToListSectionPage() // list_id
//                case USER_STARTED_FOLLOWING_YOU:
//                    appDelegate.idFromWebEngageDeeplink = appDelegate.userIdFromStandardDeeplink;
//                    childVC?.goToPeopleSectionPage() // user_id
//                case USER_REPLIED_TO_REVIEW:
//                    childVC?.goToReviewPage() // review_id and business_id
//                case BO_REPLIED_TO_REVIEW:
//                    childVC?.goToReviewPage() // review_id and business_id
//                case USER_DEAL:
//                    appDelegate.idFromWebEngageDeeplink = appDelegate.businessIdFromStandardDeeplink;
//                    childVC?.goToDealSectionPage() // goToDeal deal_id and business_id
//                case USER_NEW_VERSION:
//                    childVC?.goToUpdateAppFromStore() // updateUrlIos
//                case USER_CLAIMED_BUSINESS:
//                    print("\( appDelegate.user?._id ?? "")");
//                    if appDelegate.token != nil && (appDelegate.token != "") {
//                        appDelegate.idFromWebEngageDeeplink = appDelegate.businessIdFromStandardDeeplink;
//                        appDelegate.fromStandardDeeplink = false;
//                        childVC?.switchProfileAndGoToBusinessSectionPage() // business_id and user_id
//                    }else {
//                        let errorAlert = UIAlertController(
//                            title: appDelegate.alertTitle,
//                            message: appDelegate.accessToResourceDenied,
//                            preferredStyle: .alert)
//
//                        let okButton = UIAlertAction(
//                            title: appDelegate.ok,
//                            style: .cancel,
//                            handler: { [weak self] action in
//                                self?.navigationController?.popViewController(animated: true)
//                            })
//                        errorAlert.addAction(okButton)
//                        present(errorAlert, animated: true)
//                    }
//                case USER_FRIEND_JOINED_THE_APP:
//                    appDelegate.idFromWebEngageDeeplink = appDelegate.userIdFromStandardDeeplink;
//                    childVC?.goToPeopleSectionPage() // user_id
//                case BUSINESS_POSTED_REVIEW:
//                    childVC?.goToReviewPage() // review_id and business_id
//                case BUSINESS_RATED:
//                    childVC?.goToReviewPage() // review_id and business_id
//                case BUSINESS_POSTED_MEDIA:
//                    childVC?.goToReviewPage() // review_id and business_id
//                case BUSINESS_POSTED_MEDIA_FROM_SETTINGS:
//                    //[APPDEL.delegateBar showNotifPage];
//                    childVC?.goToImagePage()
//                default:
//                    print("routing not found")
//                }
//
//
//
//            }
            
            print("MainTabBarVC dispatch sync ended")
            
        }
    }
   

    override func viewDidLoad() {
        super.viewDidLoad()
        isTabbarVisible = true
        
        tabBarItemNames = ["Search", "Lists", "Explore", "Notifications", "Profile"]
        wasLaunched = AppPreferences.getWasLaunched()
        print("MainTabBarVC DidLoad")
//        appDelegate.delegateBar = self
        
        //self.view.transform = CGAffineTransformMakeScale(-1.0, 1.0);
        //EXPLORETAB
        var exploreNCC =  ExploreViewController.instantiate(fromAppStoryboard: .Main)
        let exploreNC = UINavigationController(rootViewController: exploreNCC)
//        exploreVC = exploreNC?.visibleViewController as? ExploreViewController
//        exploreVC?.setExploreSessionId(Int(arc4random_uniform(128)))
//
        //LIST TAB
        var newsVC =  NewsListVC.instantiate(fromAppStoryboard: .Main)
        let listeVC = UINavigationController(rootViewController: newsVC)
       
//        listeVC?.tabLayout = true
//        listeVC?.showHeader = true
        
//        let container = WalifUtils.getEmptyContainerVC()
//        container?.setChild(listeVC, withTitle: "Lists")
//        var listNavCont: UINavigationController? = nil
//        if let container = container {
//            listNavCont = UINavigationController(rootViewController: container)
//        }
        
        //SEARCH TAB
        var searchVCC =  SearchVC.instantiate(fromAppStoryboard: .Main)
        let searchVC = UINavigationController(rootViewController: searchVCC)
        
        //NOTIFICATIONS TAB
        var homeVCC =  HomeVC.instantiate(fromAppStoryboard: .Main)
        let notificationsVC = UINavigationController(rootViewController: homeVCC)
        //AUTHENTICATION TAB LISTS
        var authVCC =  HotelResultVC.instantiate(fromAppStoryboard: .Main)
        let authVC = UINavigationController(rootViewController: authVCC)
//        let authLists = storyboard.instantiateViewController(withIdentifier: "LoginVC") as! AuthViewController
//        authLists.isFromSettingsView = true
//        authLists.isNested = true
//        authLists.currentVC = self
//        authLists.modalPresentationStyle = .fullScreen
//
//        let authNavLists = UINavigationController(rootViewController: authLists)
//        authNavLists.navigationBar.topItem?.title = "Lists"
        
        //AUTHENTICATION TAB NOTIFICATIONS
        
//        let authNotif = storyboard.instantiateViewController(withIdentifier: "LoginVC") as! AuthViewController
//        authNotif.isFromSettingsView = true
//        authNotif.isNested = true
//        authNotif.currentVC = self
//        let authNavNotif = UINavigationController(rootViewController: authNotif)
//        authNavNotif.modalPresentationStyle = .fullScreen
//        authNavNotif.navigationBar.topItem?.title = "Notifications"
//        if let font = UIFont(name: "OpenSans-Semibold", size: 16) {
//            authNavNotif.navigationBar.titleTextAttributes = [
//            NSAttributedString.Key.foregroundColor: UIColor.white,
//            NSAttributedString.Key.font: font
//            ]
//        }
        
//        if appDelegate.isBusinessProfile {
//            //BUSINESS TAB
//            myProfileVC = UIStoryboard(name: "SettingsBusiness", bundle: nil).instantiateViewController(withIdentifier: "SettingsBusinessNC") as? UINavigationController
//            //APPDEL.panicButton = NO;
//        }else {
//            //PROFILE TAB
//            myProfileVC = UIStoryboard(name: "UserProfile", bundle: nil).instantiateViewController(withIdentifier: "MyProfileNC") as? UINavigationController
//            //APPDEL.panicButton = YES;
//        }
//        myProfileVC?.setNavigationBarHidden(false, animated: false)
//
//        let settingsVC = UIStoryboard(name: "Settings", bundle: nil).instantiateViewController(withIdentifier: "SettingsNC") as? UINavigationController
        
//        tabViewControllersLogged = [UINavigationController]()
//        tabViewControllersLogged?.append(searchVC!)
//        tabViewControllersLogged?.append(listeVC!)
//        tabViewControllersLogged?.append(exploreNC!)
//        tabViewControllersLogged?.append(notificationsVC!)
//        tabViewControllersLogged?.append(authVC!)
        
        
        tabViewControllersUnlogged = [UINavigationController]()
        tabViewControllersUnlogged?.append(searchVC)
        tabViewControllersUnlogged?.append(listeVC)
        tabViewControllersUnlogged?.append(exploreNC)
        tabViewControllersUnlogged?.append(notificationsVC)
        tabViewControllersUnlogged?.append(authVC)
        
//        if appDelegate.token != nil && (appDelegate.token != "") {
            self.setViewControllers(tabViewControllersLogged, animated: false)
            //[self setBadge: [AppPreferences getNotificationsCount]];
//        }else {
//            self.setViewControllers(tabViewControllersUnlogged, animated: false)
//        }
        
        tabViewControllersLogged?[1].title = "Lists"
        tabViewControllersUnlogged?[1].title = "Lists"
       
        searchVC.tabBarItem = UITabBarItem(title: "Search", image: UIImage(named: "search_tab_unselected_icon.png"), tag: 0)
        listeVC.tabBarItem = UITabBarItem(title: "Lists", image: UIImage(named: "list_tab_unselected_icon.png"), tag: 1)
        listeVC.tabBarItem = UITabBarItem(title: "Lists", image: UIImage(named: "list_tab_unselected_icon.png"), tag: 1)
        exploreNC.tabBarItem = UITabBarItem(title: "Explore", image: UIImage(named: "map_tab_unselected_icon.png"), tag: 2)
        notificationsVC.tabBarItem = UITabBarItem(title: "Notifications", image: UIImage(named: "notif_tab_unselected_icon.png"), tag: 3)
        notificationsVC.tabBarItem = UITabBarItem(title: "Notifications", image: UIImage(named: "notif_tab_unselected_icon.png"), tag: 3)
        authVC.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(named: "profile_tab_unselected_icon.png"), tag: 4)
        authVC.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(named: "profile_tab_unselected_icon.png"), tag: 4)
        
//        didPorfileAPICall()
        
       
//        self.tabBar.items?[3].badgeColor = WalifTheme.walifGreen()
        
        for (idx, itemRef) in self.tabBar.items!.enumerated() {
            itemRef.title = self.tabBarItemNames?[idx] ?? ""
            itemRef.imageInsets = UIEdgeInsets(top: -1, left: 0, bottom: -1, right: 0)
        }

//        if (self.searchType != 0)
//        {
//            self.lastItemSelected = 0
//        }else if (getBadge() > 0 || appDelegate.fromNotifications) {
//            self.lastItemSelected = 3
//            appDelegate.fromNotifications = false
//        }else {
//            if(!wasLaunched) {
//                self.lastItemSelected = 0
//            } else {
//                self.lastItemSelected = 2
//            }
//        }
        
        print("MainTabBarVC set SelectedIndex lastItemSelected =\(lastItemSelected)")
        setupTabBar()
//        showcaseExploreTab()
        
        NotificationCenter.default.addObserver(self, selector: #selector(didReceiveShowcaseData), name: NSNotification.Name.init(rawValue: "didReceiveShowcaseDataNotification"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(didTabBarVisible), name: NSNotification.Name.init(rawValue: "tabbarVisibleNotification"), object: nil)
    
                
    }
    
    @objc func didReceiveShowcaseData() {
//        showcaseExploreTab()
    }
    
//    @objc func isExploreScreenHighlightVisible() -> Bool {
//        return exploreVC?.highlightShowcaseViewVisible() ?? false
//    }
    @objc func didTabBarVisible() {
        self.isTabbarVisible = true
//        showcaseExploreTab()
    }
    
//    func showcaseExploreTab(){
//
//        print("Explore Tab Highlight - showcaseExploreTab check started")
//
//        if(self.isTabbarVisible == true){
//            var exploreTabShowcaseTitle = ""
//            var exploreTabShowcaseDesc = ""
//            var shouldShowcaseExploreTab = false
//
//            if (FIRConfig.shared.exploreDealsShouldShowcase == true) {
//                print("Explore Tab Highlight - About to highlight")
//
//                let isDealsSectionShowCaseDoneAlready = AppPreferences.getDealsShowCaseShownStatus();
//
//                var exploreTabShowcasedCountInt = 0;
//
//                let exploreTabShowcasedCount = AppPreferences.getShowCasedCountForExploreDeals()
//
//                if (exploreTabShowcasedCount != nil ){
//                    exploreTabShowcasedCountInt = exploreTabShowcasedCount?.intValue ?? 0
//                }
//
//
//                var isMaxAttemptToShowExceed = false;
//
//                let configuredMaxAttemptToTry =  FIRConfig.shared.exploreDealsShowCaseMaxAttemptIfSkipped;
//
//                if (exploreTabShowcasedCountInt >= configuredMaxAttemptToTry) {
//                    isMaxAttemptToShowExceed = true;
//                }
//
//                if(isDealsSectionShowCaseDoneAlready == false && isMaxAttemptToShowExceed == false){
//                    exploreTabShowcaseTitle = FIRConfig.shared.exploreDealShowcase_ExploreTitle ?? ""
//                    exploreTabShowcaseDesc = FIRConfig.shared.exploreDealShowcase_ExploreDescription  ?? ""
//                    shouldShowcaseExploreTab = true;
//                    self.showCaseSection = HightlightSection.DEALSID;
//                }else {
//                    shouldShowcaseExploreTab = false;
//                    self.showCaseSection = nil;
//                }
//
//            } else if (FIRConfig.shared.exploreFeaturedVideoShouldShowcase == true) {
//                print("Explore Tab Highlight - About to highlight")
//                let isFeaturedVideoSectionShowCaseDoneAlready = AppPreferences.getFeaturedVideoShowCaseShownStatus()
//
//                var exploreTabShowcasedCountInt = 0;
//
//                let exploreTabShowcasedCount = AppPreferences.getShowCasedCountForExploreFeaturedVideo()
//
//                if (exploreTabShowcasedCount != nil ){
//                    exploreTabShowcasedCountInt = exploreTabShowcasedCount?.intValue ?? 0
//                }
//
//
//                var isMaxAttemptToShowExceed = false
//
//                let configuredMaxAttemptToTry =  FIRConfig.shared.exploreFeaturedVideoShowCaseMaxAttemptIfSkipped
//
//                if (exploreTabShowcasedCountInt >= configuredMaxAttemptToTry) {
//                    isMaxAttemptToShowExceed = true;
//                }
//
//                if(isFeaturedVideoSectionShowCaseDoneAlready == false && isMaxAttemptToShowExceed == false){
//                    exploreTabShowcaseTitle = FIRConfig.shared.exploreFeaturedVideoShowcase_ExploreTitle ?? ""
//                    exploreTabShowcaseDesc = FIRConfig.shared.exploreFeaturedVideoShowcase_ExploreDescription ?? ""
//                    shouldShowcaseExploreTab = true;
//                    self.showCaseSection = HightlightSection.FEATUREDVIDEOSID;
//                }else {
//                    shouldShowcaseExploreTab = false;
//                    self.showCaseSection = nil;
//                }
//
//            }else if (FIRConfig.shared.exploreFeaturedArticlesShouldShowcase == true) {
//                print("Explore Tab Highlight - About to highlight")
//                let isFeaturedArticlesSectionShowCaseDoneAlready = AppPreferences.getFeaturedArticlesShowCaseShownStatus()
//
//                var exploreTabShowcasedCountInt = 0;
//
//                let exploreTabShowcasedCount = AppPreferences.getShowCasedCountForExploreFeaturedArticles()
//
//                if (exploreTabShowcasedCount != nil ){
//                    exploreTabShowcasedCountInt = exploreTabShowcasedCount?.intValue ?? 0
//                }
//
//
//                var isMaxAttemptToShowExceed = false;
//
//                let configuredMaxAttemptToTry =  FIRConfig.shared.exploreFeaturedArticlesShowCaseMaxAttemptIfSkipped;
//
//                if (exploreTabShowcasedCountInt >= configuredMaxAttemptToTry) {
//                    isMaxAttemptToShowExceed = true;
//                }
//
//                if(isFeaturedArticlesSectionShowCaseDoneAlready == false && isMaxAttemptToShowExceed == false){
//                    exploreTabShowcaseTitle = FIRConfig.shared.exploreFeaturedArticlesShowcase_ExploreTitle ?? ""
//                    exploreTabShowcaseDesc = FIRConfig.shared.exploreFeaturedArticlesShowcase_ExploreDescription ?? ""
//                    shouldShowcaseExploreTab = true;
//                    self.showCaseSection = HightlightSection.FEATUREDARTICLESID;
//                }else {
//                    shouldShowcaseExploreTab = false;
//                    self.showCaseSection = nil;
//                }
//
//            }else if (FIRConfig.shared.exploreBlogsShouldShowcase == true) {
//                print("Explore Tab Highlight - About to highlight");
//                let isBlogsSectionShowCaseDoneAlready = AppPreferences.getBlogsShowCaseShownStatus()
//
//                var exploreTabShowcasedCountInt = 0;
//
//                let exploreTabShowcasedCount = AppPreferences.getShowCasedCountForExploreBlogs()
//
//                if (exploreTabShowcasedCount != nil ){
//                    exploreTabShowcasedCountInt = exploreTabShowcasedCount?.intValue ?? 0
//                }
//
//                var isMaxAttemptToShowExceed = false;
//
//                let configuredMaxAttemptToTry =  FIRConfig.shared.exploreBlogsShowCaseMaxAttemptIfSkipped;
//
//                if (exploreTabShowcasedCountInt >= configuredMaxAttemptToTry) {
//                    isMaxAttemptToShowExceed = true;
//                }
//
//                if(isBlogsSectionShowCaseDoneAlready == false && isMaxAttemptToShowExceed == false){
//                    exploreTabShowcaseTitle = FIRConfig.shared.exploreBlogsShowcase_ExploreTitle ?? ""
//                    exploreTabShowcaseDesc = FIRConfig.shared.exploreBlogsShowcase_ExploreDescription ?? ""
//                    shouldShowcaseExploreTab = true;
//                    self.showCaseSection = HightlightSection.BLOGSID;
//                }else {
//                    shouldShowcaseExploreTab = false;
//                    self.showCaseSection = nil;
//                }
//
//            }else {
//                shouldShowcaseExploreTab = false;
//                self.showCaseSection = nil;
//
//                let exploreNavControl = self.viewControllers?[2] as? UINavigationController
//                let exploreViewController = exploreNavControl?.viewControllers[0]
//
//                if exploreViewController is ExploreViewController {
//                    (exploreViewController as? ExploreViewController)?.removeHighlightShowCaseViewProgramatically()
//                }
//
//            }
//
//            if (shouldShowcaseExploreTab) {
//
//                let exploreNavControl = self.viewControllers?[2] as? UINavigationController
//                let exploreViewController = exploreNavControl?.viewControllers[0]
//
//                if exploreViewController is ExploreViewController {
//
//                    if showCaseSection == HightlightSection.DEALSID {
//                        (exploreViewController as? ExploreViewController)?.prepareForHighlightingDealsSection()
//                    }else if showCaseSection == HightlightSection.FEATUREDVIDEOSID {
//                        (exploreViewController as? ExploreViewController)?.prepareForHighlightingFeaturedVideosSection()
//                    }else if showCaseSection == HightlightSection.FEATUREDARTICLESID {
//                        (exploreViewController as? ExploreViewController)?.prepareForHighlightingFeaturedArticleSection()
//                    }else if showCaseSection == HightlightSection.BLOGSID {
//                        (exploreViewController as? ExploreViewController)?.prepareForHighlightingBlogSection()
//                    }
//                }
//
//
//                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1.2) {
//                    var isKeyBoardVisible = UIApplication.shared.isKeyboardPresented
//                    isKeyBoardVisible = false // since this condition is not need
//
//                    if isKeyBoardVisible {
//                        print("Explore Tab Highlight - KEYBOARD VISIBLE = true , cannot showcase explore tab")
//                        return
//                    }else {
//                        //UIApplication.shared.keyWindow?.rootViewController
//                        print("Explore Tab Highlight - KEYBOARD VISIBLE = false");
//
//                        let aTopVisibleController = UIApplication.getTopViewController(base: UIApplication.shared.keyWindow?.rootViewController)
//
//                        print("aTopVisibleController aTopVisibleController= \(aTopVisibleController)");
//
//                        var isTabVisible = false;
//                        if (aTopVisibleController?.tabBarController?.tabBar != nil){
//
//                            if (aTopVisibleController!.tabBarController!.tabBar.isHidden == false) {
//                                isTabVisible = true;
//                            }
//
//                        }
//
//                        let exploreNavControl = self.viewControllers?[2] as? UINavigationController
//
//                        print(" isTabVisible = \(isTabVisible)");
//                        print(" self.selectedIndex = \(self.selectedIndex)");
//                        print(" exploreNavControl.viewControllers.count = \(exploreNavControl?.viewControllers.count ?? 0)");
//
//                        if(isTabVisible && self.selectedIndex == 2 && (exploreNavControl?.viewControllers.count ?? 0) == 1){
//                            print("Explore Tab Highlight - Tab bar visible = true, can showcase explore tab");
//                            self.highlightFeaturedSection()
//                           // [self createShowcaseExploreTabWithTitle:exploreTabShowcaseTitle desc:exploreTabShowcaseDesc];
//                        }else {
//                            print("Explore Tab Highlight - Tab bar visible = false, cannot showcase explore tab")
//                        }
//
//
//                    }
//
//                }
//
//            }
//
//        }
//    }
    
    /*
    -(void)createShowcaseExploreTabWithTitle:(NSString*)title desc:(NSString*)desc{
        if (self.shouldShowcaseExploreTab && self.explorShowcaseCointainer == nil){
            self.explorShowcaseCointainer = [[MaterialShowcase alloc]init];
            [self.explorShowcaseCointainer setTargetViewWithTabBar:self.tabBar itemIndex:2 tapThrough:false];
            self.explorShowcaseCointainer.backgroundAlpha = 1.0;
            self.explorShowcaseCointainer.backgroundViewType = 1;
            self.explorShowcaseCointainer.targetHolderRadius = 42.0;
            self.explorShowcaseCointainer.targetHolderColor = [UIColor clearColor];
            self.explorShowcaseCointainer.aniComeInDuration = 0.3;
            self.explorShowcaseCointainer.aniRippleColor = [UIColor colorNamed:@"showcasePrimaryTextColor"];
            //self.explorShowcaseCointainer.aniRippleAlpha = 1.0;
           // self.explorShowcaseCointainer.aniRippleColor =[UIColor clearColor];
            self.explorShowcaseCointainer.aniRippleScale = 7.0;
            self.explorShowcaseCointainer.primaryText = title;
            
            NSString *descString =  desc;
            if(descString!= nil) {
                descString = [NSString stringWithFormat:@"\n%@",descString];
            }
            self.explorShowcaseCointainer.secondaryText = descString;
            self.explorShowcaseCointainer.primaryTextAlignment = NSTextAlignmentLeft;
            self.explorShowcaseCointainer.secondaryTextAlignment = NSTextAlignmentLeft;
            self.explorShowcaseCointainer.secondaryTextSize = 16;
            self.explorShowcaseCointainer.primaryTextSize = 22;
            
            self.explorShowcaseCointainer.primaryTextFont = [UIFont fontWithName:@"OpenSans-Semibold" size:22.0];
            self.explorShowcaseCointainer.secondaryTextFont = [UIFont fontWithName:@"OpenSans" size:16.0];
            
            self.explorShowcaseCointainer.delegate = self;
            
            self.explorShowcaseCointainer.backgroundPromptColor = [UIColor colorNamed:@"showcaseBGColor"];
            
            
            self.explorShowcaseCointainer.primaryTextColor = [UIColor colorNamed:@"showcasePrimaryTextColor"];//[UIColor colorWithRed:20 / 255.0 green:154 / 255.0 blue:180 / 255.0 alpha:1];
            self.explorShowcaseCointainer.secondaryTextColor = [UIColor colorNamed:@"showcaseSecondaryTextColor"];//[UIColor colorWithRed:20 / 255.0 green:154 / 255.0 blue:180 / 255.0 alpha:1];
            if (@available(iOS 12.0, *)) {
                if( self.traitCollection.userInterfaceStyle == UIUserInterfaceStyleDark ){
                               //is dark
                    self.explorShowcaseCointainer.backgroundPromptColorAlpha = 0.96;
                    
                }else{
                    self.explorShowcaseCointainer.backgroundPromptColorAlpha = 0.9;
                               //is light
                }
               
            }else {
                self.explorShowcaseCointainer.backgroundPromptColorAlpha = 0.9;
            }
            
            
          //  showcase.isTapRecognizerForTargetView = true
            self.explorShowcaseCointainer.backgroundRadius = self.view.frame.size.width * 0.65;
            
            [self.explorShowcaseCointainer showWithAnimated:true hasShadow:false hasSkipButton:false completion:^{
                
                if([self.showCaseSection isEqualToString:HightlightSection.DEALSID]) {
                    [self incrementShowcaseAttemptCountForExploreDeal];
                }else if([self.showCaseSection isEqualToString:HightlightSection.FEATUREDVIDEOSID]) {
                    [self incrementShowcaseAttemptCountForExploreFeaturedVideo];
                }else if([self.showCaseSection isEqualToString:HightlightSection.FEATUREDARTICLESID]) {
                    [self incrementShowcaseAttemptCountForExploreFeaturedArticles];
                }
                
               
            }];
            
            [FIRAnalytics logEventWithName:GA_ACTION_VIEWED_EXPLORETAB_HIGHLIGHT
                            parameters:@{
                                         WE_EVENT_NAME : GA_ACTION_VIEWED_EXPLORETAB_HIGHLIGHT,
                                         GA_EVENT_CATEGORY : GA_CATEGORY_NAVBAR,
                                         GA_EVENT_LABEL : GA_EVENT_VIEWED_EXPLORETAB_HIGHLIGHT
                            }];
            
            self.shouldShowcaseExploreTab = false;
            
        }
    }*/
    

    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        //    if(![AppPreferences getHideSearchTypeSelector]) {
        //         //APPDEL.firstTime=NO;
        //        [self checkOnSearchOptions];
        //    }
        
        wasLaunched = AppPreferences.getWasLaunched()
        if(!wasLaunched) {
//             checkOnSearchOptions()
            //APPDEL.firstTime=NO;
        }
        
        //    if (APPDEL.authFromDeepLink) {
        //
        //        if (APPDEL.viewToOpenFromDeepLink != nil) {
        //            //[APPDEL.delegateBar setLoggedTabViewController];
        //            //[WalifUtils postLoginActions:APPDEL.viewToOpenFromDeepLink];
        //            [self dismissViewControllerAnimated:YES completion:nil];
        //            [WalifUtils postRegistratonActions:APPDEL.viewToOpenFromDeepLink fromVC:self];
        //            APPDEL.viewToOpenFromDeepLink = nil;
        //            //[self showMainVC];
        //        }
        //    }
    }
    
    
   
    
//    func didPorfileAPICall() {
//
//        if appDelegate.token != nil && (appDelegate.token != "") {
//
//            appDelegate.getUserProfileData { [self] success, response in
//                appDelegate.userProfiles = response;
//
//                if (success) {
//                    appDelegate.isInitialProfileAPISuccess = true;
//                    appDelegate.isBusinessProfile = false;
//
//                    if (response?.profiles.count ?? 0) > 0 {
//
//                        if (response?.profiles.count ?? 0) > 1 {
//                            appDelegate.isBusinessProfile = true
//                            print("Business profile true")
//                            DispatchQueue.main.async(execute: { [self] in
//                                myProfileVC = UIStoryboard(name: "SettingsBusiness", bundle: nil).instantiateViewController(withIdentifier: "SettingsBusinessNC") as? UINavigationController
//                                myProfileVC?.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(named: "hamburgher_tab_icon.png"), tag: 4)
//                                myProfileVC?.setNavigationBarHidden(false, animated: false)
//                                tabViewControllersLogged?.removeLast()
//                                tabViewControllersLogged?.append(myProfileVC!)
//                                self.setViewControllers(tabViewControllersLogged, animated: false)
//                                self.tabBar.tintColor = UIColor.white
//
//                                for (idx, itemRef) in self.tabBar.items!.enumerated() {
//                                    itemRef.title = self.tabBarItemNames?[idx] ?? ""
//                                    itemRef.imageInsets = UIEdgeInsets(top: -1, left: 0, bottom: -1, right: 0)
//                                }
//
//                                setupTabBar()
//                                setNeedsStatusBarAppearanceUpdate()
//                            })
//                        }else {
//                            appDelegate.isBusinessProfile = false
//                            setLoggedTabViewController()
//                        }
//                    }
//
//                }else {
//                    appDelegate.isBusinessProfile = false
//
//                    DispatchQueue.main.async(execute: { [self] in
//                        myProfileVC = UIStoryboard(name: "Settings", bundle: nil).instantiateViewController(withIdentifier: "SettingsNC") as? UINavigationController
//                        myProfileVC?.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(named: "profile_tab_unselected_icon.png"), tag: 4)
//                        myProfileVC?.setNavigationBarHidden(false, animated: false)
//                        tabViewControllersLogged?.removeLast()
//                        tabViewControllersLogged?.append(myProfileVC!)
//                        self.setViewControllers(tabViewControllersLogged, animated: false)
//                        self.tabBar.tintColor = UIColor.white
//
//                        for (idx, itemRef) in self.tabBar.items!.enumerated() {
//                            itemRef.title = self.tabBarItemNames?[idx] ?? ""
//                            itemRef.imageInsets = UIEdgeInsets(top: -1, left: 0, bottom: -1, right: 0)
//                        }
//
//                        setupTabBar()
//                        setNeedsStatusBarAppearanceUpdate()
//                    })
//                }
//                appDelegate.profilesMeInProgress = false
//            }
//
//        }
//
//    }
    

//    func didProfileMeDetailAPICall() {
//        let data = ObjCNetworkLayer().profilesMeDetailGet()
//        NetworkLayer(data) { [self] result, error in
//
//            if error != nil {
//                DispatchQueue.main.async(execute: { [self] in
//                    Environment.shared.showCommonAlert()
//                })
//            }
//
//            if result != nil {
//                print("Result:\(result)")
//
//                DispatchQueue.main.async(execute: { [self] in
//                    appDelegate.user  = result as? WALIFPersonalUserProfileDetailedResource
//                    if appDelegate.user?.clusterId != nil {
//                        appDelegate.userClusterId = appDelegate.user?.clusterId
//                    }else {
//                        appDelegate.userClusterId = nil
//                    }
//                    appDelegate.userFirstName = appDelegate.user?.firstName
//                    appDelegate.interests = appDelegate.user?.interestsIds
//                    self.didPorfileAPICall()
//
//                })
//
//            }
//
//        }
//    }
    
    
//    func adjustBadge() {
//        for tabBarButton in tabBar.subviews {
//                for badgeView in tabBarButton.subviews {
//                    let className = NSStringFromClass(type(of: badgeView).self)
//
//                    // Looking for _UIBadgeView
//                    if (className as NSString).range(of: "BadgeView").location != NSNotFound {
//                        badgeAdjusted = true
//                    }
//                }
//            }
//    }
    
    
    func initSettingsVC() {
        
        //UINavigationController *settingsVC = (UINavigationController *)[[UIStoryboard storyboardWithName:@"Settings" bundle:nil] instantiateViewControllerWithIdentifier:@"SettingsNC"];
    }
    
    
    @objc func setUnloggedTabViewController() {
        
        DispatchQueue.main.async(execute: { [self] in
           
            if self.tabBar == nil {
                setupTabBar()
            }
            self.setViewControllers(tabViewControllersUnlogged, animated: false)
        
            let unselectedColor = WalifTheme.newTabBarGrey()
            
            for (idx, itemRef) in self.tabBar.items!.enumerated() {
                
                itemRef.image = itemRef.selectedImage?.withTintColor(unselectedColor!).withRenderingMode(.alwaysTemplate)
                itemRef.title = self.tabBarItemNames?[idx] ?? ""
                itemRef.imageInsets = UIEdgeInsets(top: -1, left: 0, bottom: -1, right: 0)
            }
            AppPreferences.setNotificationsCount(0)
            self.setBadge(Int32(AppPreferences.getNotificationsCount()))
            UIApplication.shared.applicationIconBadgeNumber = Int(AppPreferences.getNotificationsCount())
            self.setNeedsStatusBarAppearanceUpdate()
            
            
        })
        
    }
    
//    @objc func setBusinessTabViewController() {
//
//        //APPDEL.panicButton = NO;
//        NotificationCenter.default.post(name: NSNotification.Name.init(rawValue: "pb_reload_data"), object: self)
//
//        DispatchQueue.main.async(execute: { [self] in
//
//            myProfileVC = UIStoryboard(name: "SettingsBusiness", bundle: nil).instantiateViewController(withIdentifier: "SettingsBusinessNC") as? UINavigationController
//            myProfileVC?.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(named: "hamburgher_tab_icon.png"), tag: 4)
//            myProfileVC?.setNavigationBarHidden(false, animated: false)
//            tabViewControllersLogged?.removeLast()
//            tabViewControllersLogged?.append(myProfileVC!)
//
//            let unselectedColor = WalifTheme.newTabBarGrey()
//
//            myProfileVC?.tabBarItem.image = myProfileVC?.tabBarItem.selectedImage?.withColor(unselectedColor).withRenderingMode(.alwaysTemplate)
//
//            self.setViewControllers(tabViewControllersLogged, animated: false)
//
//            for (idx, itemRef) in self.tabBar.items!.enumerated() {
//
//                itemRef.image = itemRef.selectedImage?.withColor(unselectedColor).withRenderingMode(.alwaysTemplate)
//                itemRef.title = self.tabBarItemNames?[idx] ?? ""
//                itemRef.imageInsets = UIEdgeInsets(top: -1, left: 0, bottom: -1, right: 0)
//            }
//
//            self.selectedIndex = self.lastItemSelected;
//
//            self.tabBar.items?[3].badgeColor = WalifTheme.walifGreen()
//
//            if (AppPreferences.getNotificationsCount() > 0) {
//                //if(!badgeAdjusted)
//                self.adjustBadge();
//            }
//            self.setNeedsStatusBarAppearanceUpdate()
//
//        })
//
//    }

//    @objc func setListTabViewController() {
//
//        let unselectedColor = WalifTheme.newTabBarGrey()
//
//        for (idx, itemRef) in self.tabBar.items!.enumerated() {
//
//            itemRef.image = itemRef.selectedImage?.withColor(unselectedColor).withRenderingMode(.alwaysTemplate)
//            itemRef.title = self.tabBarItemNames?[idx] ?? ""
//            itemRef.imageInsets = UIEdgeInsets(top: -1, left: 0, bottom: -1, right: 0)
//        }
//
//    }
      
   
//    @objc func setLoggedTabViewController() {
//
//        //APPDEL.panicButton = NO;
//        NotificationCenter.default.post(name: NSNotification.Name.init(rawValue: "pb_reload_data"), object: self)
//
//        DispatchQueue.main.async(execute: { [self] in
//
//            myProfileVC = UIStoryboard(name: "UserProfile", bundle: nil).instantiateViewController(withIdentifier: "MyProfileNC") as? UINavigationController
//            myProfileVC?.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(named: "profile_tab_unselected_icon.png"), tag: 4)
//            myProfileVC?.setNavigationBarHidden(false, animated: false)
//            tabViewControllersLogged?.removeLast()
//            tabViewControllersLogged?.append(myProfileVC!)
//            let unselectedColor = WalifTheme.newTabBarGrey()
//            myProfileVC?.tabBarItem.image = myProfileVC?.tabBarItem.selectedImage?.withColor(unselectedColor).withRenderingMode(.alwaysTemplate)
//
//            self.setViewControllers(tabViewControllersLogged, animated: false)
//            // generate a tinted unselected image based on image passed via the storyboard
//            for (idx, itemRef) in self.tabBar.items!.enumerated() {
//
//                itemRef.image = itemRef.selectedImage?.withColor(unselectedColor).withRenderingMode(.alwaysTemplate)
//                itemRef.title = self.tabBarItemNames?[idx] ?? ""
//                itemRef.imageInsets = UIEdgeInsets(top: -1, left: 0, bottom: -1, right: 0)
//            }
//
//            self.selectedIndex = self.lastItemSelected;
//
//            self.tabBar.items?[3].badgeColor = WalifTheme.walifGreen()
//
//            if (AppPreferences.getNotificationsCount() > 0) {
//                //if(!badgeAdjusted)
//                self.adjustBadge();
//            }
//            self.setNeedsStatusBarAppearanceUpdate()
//
//        })
//
//    }
    
   @objc func setBadge(_ n: Int32) {
        for tagItem in tabBar.items ?? [] {
            if tagItem.tag == 3 && n != 0 {
                tagItem.badgeValue = NSNumber(value: n).stringValue
                if !badgeAdjusted {
//                    adjustBadge()
                }
            } else {
                tagItem.badgeValue = nil
            }
        }
    }
    

    @objc func getBadge() -> Int32 {
        return Int32(tabBar.items?[3].badgeValue ?? "") ?? 0
    }
    
    
    func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .lightContent
    }


    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("MainTabBarVC will appear")
        
//        NotificationCenter.default.addObserver(self, selector: #selector(updateSearchType(_:)), name: NSNotification.Name.init(rawValue: NOTIF_UPDATE_SEARCH_TYPE), object: nil)
        
//        if appDelegate.token != nil && (appDelegate.token != "") {
            self.setViewControllers(tabViewControllersLogged, animated: false)
//            //[self setBadge: [AppPreferences getNotificationsCount]];
//        }else {
//            self.setViewControllers(tabViewControllersUnlogged, animated: false)
//        }
        setupTabBar()
        
//        if(appDelegate.fromSearchHome) {
//            appDelegate.fromSearchHome = false
//            initSearchViewController()
//        }
        
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("MainTabBarVC WillDisappear")
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func updateSearchType(_ notification: Notification) {
        if let info:[AnyHashable:Any] = notification.userInfo,
           let searchTypeNumber = info["searchType"] as? NSNumber {
            searchType = searchTypeNumber.intValue
        }
      
        
    }
    
    func getBottomTabArea() -> CGFloat {
        if #available(iOS 11.0, *) {
            if UIDevice.current.userInterfaceIdiom == .phone {
                if Int(UIScreen.main.nativeBounds.size.height) == 2436 {
                    return 83
                }
            }
        }
        return tabBar.frame.size.height
    }
    
    
    func setupTabBar(){
        // set the selected colors
        tabBar.tintColor = AppColors.appBlueColor
//        tabBar.backgroundImage = UIImage(from:  UIColor(named: "primaryBgColor"), height: Float(tabBar.frame.size.height), width: Float(tabBar.frame.size.width))
//
//        let widthRef = (self.tabBar.frame.size.width)/CGFloat((self.tabBar.items?.count ?? 1))
//
//        let selectedItemBg = UIImage(from:  UIColor.clear, height: Float(getBottomTabArea()), width: Float(widthRef))
        
//        UITabBar.appearance().selectionIndicatorImage = selectedItemBg
        let unselectedColor = AppColors.lightGray
        // generate a tinted unselected image based on image passed via the storyboard
        for (idx, itemRef) in self.tabBar.items!.enumerated() {
            
//            itemRef.image = itemRef.selectedImage?.withColor(unselectedColor).withRenderingMode(.alwaysTemplate)
            itemRef.title = self.tabBarItemNames?[idx] ?? ""
            itemRef.imageInsets = UIEdgeInsets(top: -1, left: 0, bottom: -1, right: 0)
        }
        
        self.selectedIndex = self.lastItemSelected;
        
        if #available(iOS 15.0, *) {
            let aAppearence = UITabBarAppearance()
            aAppearence.configureWithOpaqueBackground()
            //   aAppearence.backgroundColor = [WalifTheme newTabBarBlue];
            UITabBar.appearance().standardAppearance = aAppearence
            UITabBar.appearance().scrollEdgeAppearance = UITabBar.appearance().standardAppearance
            
        }
        
    }
    
//    @objc func initSearchViewController() {
//
//        let childVC = (viewControllers?[0] as? UINavigationController)?.viewControllers[0] as? NewGlobalSearchViewController
////        if appDelegate.fromSearchHome {
////            fromSearchHome = false
////            showSearchpage()
////        }
//        childVC?.initUI()
//    }

   
    
//    func checkOnSearchOptions(){
//        if !AppPreferences.getHideSearchTypeSelector() {
//            let sb = UIStoryboard(name: "Main", bundle: nil)
//            let vc = sb.instantiateViewController(withIdentifier: "SearchHomeVC") as? SearchHomeViewController
//            vc?.modalTransitionStyle = .coverVertical
//            if let vc = vc {
//                present(vc, animated: true)
//            }
//        }
//    }
    
    
    
    @objc func showExplorePage() {
        self.selectedIndex = 2
        self.lastItemSelected = 2
//        exploreVC?.setExploreSessionId(Int(arc4random_uniform(128)))
//        setNeedsStatusBarAppearanceUpdate()
    }

    @objc func showListPage() {
        self.selectedIndex = 1
        self.lastItemSelected = 1
//        setNeedsStatusBarAppearanceUpdate()
    }

    @objc func showSearchpage() {
        self.selectedIndex = 0
        self.lastItemSelected = 0
//        setNeedsStatusBarAppearanceUpdate()
    }

    @objc func showNotifPage() {
//        appDelegate.fromNotifications = false;
        self.selectedIndex = 3;
        self.lastItemSelected = 3;
//        setNeedsStatusBarAppearanceUpdate()
    }

    @objc func showProfilePage() {
        self.selectedIndex = 4;
        self.lastItemSelected = 4;
//        setNeedsStatusBarAppearanceUpdate()
    }

    @objc func enableTapBarInteractions() {
        self.tabBar.isUserInteractionEnabled = true
    }

    @objc func disableTapBarInteractions() {
        self.tabBar.isUserInteractionEnabled = false
    }
    
//    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
//        // if any highlight in explore tab, remove if selectewd index is not explore tab
//        if (item.tag != 2){
//            self.exploreVC?.removeHighlightShowCaseViewProgramatically()
//        }
//
//        self.tabViewControllersLogged?[1].title = "Lists"
//        self.tabViewControllersUnlogged?[1].title = "Lists"
//
//        if(item.tag == 4 ) {
//
//            if (!appDelegate.isInitialProfileAPISuccess && appDelegate.token != nil && (appDelegate.token != "") ) {
//                didProfileMeDetailAPICall()
//            }
//
//        } else if(item.tag == 2) {
//            //EXPLORE
//            exploreVC?.setExploreSessionId(Int(arc4random_uniform(128)))
//        } else if(item.tag == 1) {
//            //lists
//            //if([WalifUtils loginNeeded:self]) return;
//            self.tabViewControllersLogged?[1].title = "Lists"
//            self.tabViewControllersUnlogged?[1].title = "Lists"
//            listeVC?.reloadSavedList = true
//            listeVC?.reloadPersonalList = true
//
//        } else if (item.tag==0 && self.lastItemSelected==0) {
//            // SEARCH
//            let childVC = (viewControllers?[0] as? UINavigationController)?.viewControllers[0] as? NewGlobalSearchViewController
//            childVC?.searchType = self.searchType;
//            //childVC.keywordFlag = NO;
//            //childVC.theKeyword = nil;
//            childVC?.tabSearchButtonTapped()
//        }
//
//
//        self.lastItemSelected = item.tag;
//    }
    
    //-(void)unsetGlobalSearch{
    //    NewGlobalSearchViewController *childVC = (NewGlobalSearchViewController *)[[((UINavigationController *)[[self viewControllers] objectAtIndex:2]) viewControllers] objectAtIndex:0];
    //
    //    childVC.searchType = self.searchType;
    //    childVC.keywordFlag = NO;
    //    childVC.theKeyword = nil;
    //    [childVC initUI];
    //}

    
//    func prepareGlobalSearch() {
//        let childVC = (viewControllers?[0] as? UINavigationController)?.viewControllers[0] as? NewGlobalSearchViewController
//        childVC?.searchType = searchType
//        childVC?.keywordFlag = keywordsFlag
//
//        if let keywordsParamRef = keywordsParam {
//            print("passing \(keywordsParamRef) to GlobalSearch")
//            childVC?.theKeyword = keywordsParamRef
//            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double(0.5 * Double(NSEC_PER_SEC)) / Double(NSEC_PER_SEC), execute: {
//                childVC?.businessDetailsKeywordTapped()
//            })
//
//            //[childVC businessDetailsKeywordTapped];
//            keywordsParam = nil
//        } else {
//            childVC?.initUI()
//        }
//
//    }
    
//    @objc func reloadSearchViewController() {
//        if selectedViewController?.childViewControllers[0] is NewGlobalSearchViewController {
//            let vc = selectedViewController?.childViewControllers[0] as? NewGlobalSearchViewController
//            vc?.showBusinessRetailPage()
//        }
//    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
    }
    
//    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
//        if #available(iOS 12.0, *) {
//            if newCollection.userInterfaceStyle == .light {
//                tabBar.backgroundImage = UIImage(from: UIColor.white, height: Float(tabBar.frame.size.height), width: Float(tabBar.frame.size.width))
//            } else {
//                tabBar.backgroundImage = UIImage(from: UIColor.black, height: Float(tabBar.frame.size.height), width: Float(tabBar.frame.size.width))
//            }
//        } else {
//            // Fallback on earlier versions
//            tabBar.backgroundImage = UIImage(from: UIColor.white, height: Float(tabBar.frame.size.height), width: Float(tabBar.frame.size.width))
//        }
//    }
   
   
    
    
//    func highlightFeaturedSection() {
//
//        if(self.selectedIndex != 2){
//            self.selectedIndex = 2;
//        }
//
//        let exploreNavControl = self.viewControllers?[2] as? UINavigationController
//        let exploreViewController = exploreNavControl?.viewControllers[0]
//        exploreViewController?.view.isUserInteractionEnabled = false
//        view.isUserInteractionEnabled = false
//
//        /*[FIRAnalytics logEventWithName:GA_ACTION_CLICKED_EXPLORETAB_HIGHLIGHT
//                        parameters:@{
//                                     WE_EVENT_NAME : GA_ACTION_CLICKED_EXPLORETAB_HIGHLIGHT,
//                                     GA_EVENT_CATEGORY : GA_CATEGORY_NAVBAR,
//                                     GA_EVENT_LABEL : GA_EVENT_CLICKED_EXPLORETAB_HIGHLIGHT
//                        }];*/
//
//
//
//
//        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.0) {
//            let exploreNavControl = self.viewControllers?[2] as? UINavigationController
//            let exploreViewController = exploreNavControl?.viewControllers[0]
//            if exploreViewController is ExploreViewController {
//                exploreNavControl?.popToRootViewController(animated: false)
//                //
//               /* if([self.showCaseSection isEqualToString:HightlightSection.DEALSID]) {
//                    [self incrementShowcaseAttemptCountForExploreDeal];
//                }else if([self.showCaseSection isEqualToString:HightlightSection.FEATUREDVIDEOSID]) {
//                    [self incrementShowcaseAttemptCountForExploreFeaturedVideo];
//                }else if([self.showCaseSection isEqualToString:HightlightSection.FEATUREDARTICLESID]) {
//                    [self incrementShowcaseAttemptCountForExploreFeaturedArticles];
//                }*/
//                if self.showCaseSection == HightlightSection.DEALSID {
//                    (exploreViewController as? ExploreViewController)?.scrollDealSectionToTopAndShowcaseDealSection()
//                }else if self.showCaseSection == HightlightSection.FEATUREDVIDEOSID {
//                    (exploreViewController as? ExploreViewController)?.scrollFeaturedVideosSectionToTopAndShowcase()
//                }else if self.showCaseSection == HightlightSection.FEATUREDARTICLESID {
//                    (exploreViewController as? ExploreViewController)?.scrollFeaturedArticlesSectionToTopAndShowcase()
//                }else if self.showCaseSection == HightlightSection.BLOGSID {
//                    (exploreViewController as? ExploreViewController)?.scrollBlogSectionToTopAndShowcase()
//                }
//            }
//        }
//
//
//        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2.0) {
//            let exploreNavControl = self.viewControllers?[2] as? UINavigationController
//            let exploreViewController = exploreNavControl?.viewControllers[0]
//            exploreViewController?.view.isUserInteractionEnabled = true
//            self.view.isUserInteractionEnabled = true
//        }
//
//
//    }
    
   
    
   
      
}

    
//extension MainTabBarViewController: MaterialShowcaseDelegate {
//    func showCaseWillDismiss(showcase: MaterialShowcase, didTapTarget:Bool){
//
//    }
//    func showCaseDidDismiss(showcase: MaterialShowcase, didTapTarget:Bool)
//    {
//
//    }
//
//    /*
//    -(void)showCaseDidDismissWithShowcase:(MaterialShowcase *)showcase didTapTarget:(BOOL)didTapTarget{
//
//        if(didTapTarget){
//            if(self.selectedIndex != 0){
//                self.selectedIndex = 0;
//            }
//
//
//            UINavigationController *exploreNavControl = self.viewControllers[0];
//            ExploreViewController *exploreViewController = exploreNavControl.viewControllers[0];
//            [exploreViewController.view setUserInteractionEnabled:false];
//            [self.view setUserInteractionEnabled:false];
//
//            [FIRAnalytics logEventWithName:GA_ACTION_CLICKED_EXPLORETAB_HIGHLIGHT
//                            parameters:@{
//                                         WE_EVENT_NAME : GA_ACTION_CLICKED_EXPLORETAB_HIGHLIGHT,
//                                         GA_EVENT_CATEGORY : GA_CATEGORY_NAVBAR,
//                                         GA_EVENT_LABEL : GA_EVENT_CLICKED_EXPLORETAB_HIGHLIGHT
//                            }];
//
//            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                UINavigationController *exploreNavControl = self.viewControllers[0];
//                ExploreViewController *exploreViewController = exploreNavControl.viewControllers[0];
//                if( [exploreViewController isKindOfClass:[ExploreViewController class]]){
//                    [exploreNavControl popToRootViewControllerAnimated:false];
//                    if([self.showCaseSection isEqualToString:HightlightSection.DEALSID]) {
//                        [exploreViewController scrollDealSectionToTopAndShowcaseDealSection];
//                    }else if([self.showCaseSection isEqualToString:HightlightSection.FEATUREDVIDEOSID]) {
//                        [exploreViewController scrollFeaturedVideosSectionToTopAndShowcase];
//                    }else if([self.showCaseSection isEqualToString:HightlightSection.FEATUREDARTICLESID]) {
//                        [exploreViewController scrollFeaturedArticlesSectionToTopAndShowcase];
//                    }
//
//                }
//
//
//            });
//
//            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                UINavigationController *exploreNavControl = self.viewControllers[0];
//                ExploreViewController *exploreViewController = exploreNavControl.viewControllers[0];
//                [exploreViewController.view setUserInteractionEnabled:true];
//                [self.view setUserInteractionEnabled:true];
//            });
//
//
//        }else {
//
//            [FIRAnalytics logEventWithName:GA_ACTION_DISMISSED_EXPLORETAB_HIGHLIGHT
//                            parameters:@{
//                                         WE_EVENT_NAME : GA_ACTION_DISMISSED_EXPLORETAB_HIGHLIGHT,
//                                         GA_EVENT_CATEGORY : GA_CATEGORY_NAVBAR,
//                                         GA_EVENT_LABEL : GA_EVENT_DISMISSED_EXPLORETAB_HIGHLIGHT
//                            }];
//        }
//    }
//
//    -(void)showCaseWillDismissWithShowcase:(MaterialShowcase *)showcase didTapTarget:(BOOL)didTapTarget{
//
//    }*/
//}

   
