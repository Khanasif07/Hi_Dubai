//
//  AppUserDefaults.swift
//  Hi_Dubai
//
//  Created by Asif Khan on 17/05/2023.
//

import Foundation
import Foundation
extension AppPreferences {
    enum Key : String, Codable{
        case WAS_LAUNCHED
        case WAS_LOGGED
        case HIDE_SEARCH_TYPE_SELECTOR
        case ACCESS_TOKEN
        case GUEST_TOKEN
        case FACEBOOK_LOGIN
        case GOOGLE_LOGIN
        case APPLE_LOGIN
        case APPLE_LOGIN_EMAIL
        case APPLE_LOGIN_USER_FIRSTNAME
        case APPLE_LOGIN_USER_LASTNAME
        case RECENTLY_VISITED_BUSINESSES
        case RECENTLY_VISITED_LISTS
        case RECENTLY_VISITED_PEOPLE
        case APP_VERSION
        case LIST_ID_TO_FOLLOW
        case PEOPLE_ID_TO_FOLLOW
        case BUSINESS_ID_TO_FOLLOW
        case BUSINESS_NAME_TO_FOLLOW
        case MOBILE_PROMPT_TYPE
        case WAS_KILLED
        case MY_BUSINESSES_ID
        case BUSINESSES_REVIEW
        case CLAIM_BUSINESSES
        case BUSINESS_FILTER_CAT_NAME
        case BUSINESS_FILTER_CAT_MSCID
        case BUSINESS_FILTER_CAT_MCCID
        case BUSINESS_FILTER_ORDER_BY
        case BUSINESS_FILTER_DEAL
        case LIST_FILTER_ORDER_BY
        case LIST_FILTER_TYPE
        case PEOPLE_FILTER_ORDER_BY
        case NOTIFICATIONS_COUNT
        case SHOWCASE_DEALS_SHOWN
        case SHOWCASE_EXPLORETAB_DEAL_COUNT
        case SHOWCASE_FEATUREDVIDEO_SHOWN
        case SHOWCASE_EXPLORETAB_FEATUREDVIDEO_COUNT
        case SHOWCASE_FEATUREDARTICLES_SHOWN
        case SHOWCASE_EXPLORETAB_FEATUREDARTICLES_COUNT
        case SHOWCASE_BLOG_SHOWN
        case SHOWCASE_EXPLORETAB_BLOG_COUNT
        
        enum CodingKeys: String, CodingKey {
            case SHOWCASE_EXPLORETAB_BLOG_COUNT = "exploreTab_Blog_ShowcasedCount"
            case SHOWCASE_BLOG_SHOWN = "blogs"
            case SHOWCASE_EXPLORETAB_FEATUREDARTICLES_COUNT = "exploreTab_FeaturedArticles_ShowcasedCount"
            case SHOWCASE_FEATUREDARTICLES_SHOWN = "featuredArticles"
            case SHOWCASE_EXPLORETAB_FEATUREDVIDEO_COUNT = "exploreTab_FeaturedVideo_ShowcasedCount"
            case SHOWCASE_FEATUREDVIDEO_SHOWN = "featuredVideo"
            case SHOWCASE_EXPLORETAB_DEAL_COUNT = "exploreTab_Deal_ShowcasedCount"
            case SHOWCASE_DEALS_SHOWN = "deals"
        }
    }
}

@objc class AppPreferences: NSObject {
    // MARK:- Native Getter Setter Methods
    static func getBoolvalue(forKey key: Key) -> Bool {
        return  UserDefaults.standard.bool(forKey: key.rawValue)
    }
    static func getStringvalue(forKey key: Key) -> String {
        return  UserDefaults.standard.string(forKey: key.rawValue) ?? ""
    }
    static func getIntvalue(forKey key: Key) -> Int {
        return  UserDefaults.standard.integer(forKey: key.rawValue)
    }
    static func getObjectvalue(forKey key: Key) -> Any?{
        print("Get Data====\(key.rawValue)====\(UserDefaults.standard.object(forKey: key.rawValue) ?? nil)")
        return  UserDefaults.standard.object(forKey: key.rawValue)
    }
    static func save(value : Any?, forKey key : Key) {
        if value == nil {
            UserDefaults.standard.removeObject(forKey: key.rawValue)
            print("deleting the old valuse for key =\(key.rawValue)")
            
        }else {
            UserDefaults.standard.set(value, forKey: key.rawValue)
            UserDefaults.standard.synchronize()
        }
    }
    static func removeValue(forKey key : Key) {
        UserDefaults.standard.removeObject(forKey: key.rawValue)
        UserDefaults.standard.synchronize()
    }

    // MARK: - GETTERS
    @objc class func getHideSearchTypeSelector() -> Bool {
        return AppPreferences.getBoolvalue(forKey: .HIDE_SEARCH_TYPE_SELECTOR)
    }
    @objc class func getWasLaunched() -> Bool {
        return AppPreferences.getBoolvalue(forKey: .WAS_LAUNCHED)
    }
    @objc class func getWasLogged() -> Bool {
        return AppPreferences.getBoolvalue(forKey: .WAS_LOGGED)
    }
    @objc class func getAccessToken() -> String! {
        return AppPreferences.getStringvalue(forKey: .ACCESS_TOKEN)
    }
    @objc class func getGuesUserId() -> String! {
        return AppPreferences.getStringvalue(forKey: .GUEST_TOKEN)
    }
    @objc class func getIsFacebookLogin() -> Bool {
        return AppPreferences.getBoolvalue(forKey: .FACEBOOK_LOGIN)
    }
    @objc class func getIsGoogleLogin() -> Bool {
        return AppPreferences.getBoolvalue(forKey: .GOOGLE_LOGIN)
    }
    @objc class func getIsAppleLogin() -> Bool {
        return AppPreferences.getBoolvalue(forKey: .APPLE_LOGIN)
    }
    @objc class func getAppleLoginEmail() -> String! {
        return AppPreferences.getStringvalue(forKey: .APPLE_LOGIN_EMAIL)
    }
    @objc class func getAppleLoginUserFirstName() -> String! {
        return AppPreferences.getStringvalue(forKey: .APPLE_LOGIN_USER_FIRSTNAME)
    }
    @objc class func getAppleLoginUserLastName() -> String! {
        return AppPreferences.getStringvalue(forKey: .APPLE_LOGIN_USER_LASTNAME)
    }
    @objc class func removeCachedAppleLoginEmail() {
        //APPLE_LOGIN_EMAIL
        return AppPreferences.removeValue(forKey: .APPLE_LOGIN_EMAIL)
    }
    @objc class func removeCachedAppleLoginUserFirstName() {
        return AppPreferences.removeValue(forKey: .APPLE_LOGIN_USER_FIRSTNAME)
    }
    @objc class func removeCachedAppleLoginUserLastName() {
        return AppPreferences.removeValue(forKey: .APPLE_LOGIN_USER_LASTNAME)
    }
    @objc class func getFollowingListId() -> String! {
        return AppPreferences.getStringvalue(forKey: .LIST_ID_TO_FOLLOW)
    }
    @objc class func getFollowingPersonId() -> String! {
        return AppPreferences.getStringvalue(forKey: .PEOPLE_ID_TO_FOLLOW)
    }
    @objc class func getFollowingBusId() -> String! {
        return AppPreferences.getStringvalue(forKey: .BUSINESS_ID_TO_FOLLOW)
    }
    @objc class func getFollowingBusName() -> String! {
        return AppPreferences.getStringvalue(forKey: .BUSINESS_NAME_TO_FOLLOW)
    }
    @objc class func getClaimBusinessDict() -> NSMutableDictionary! {
        return AppPreferences.getObjectvalue(forKey: .CLAIM_BUSINESSES) as? NSMutableDictionary
    }
    @objc class func getRecentlyVisitedBusinesses() -> NSMutableArray {
        if AppPreferences.getObjectvalue(forKey: .RECENTLY_VISITED_BUSINESSES) == nil {
            return []
        }else {
            let dictArray:NSMutableArray =  (AppPreferences.getObjectvalue(forKey: .RECENTLY_VISITED_BUSINESSES) as AnyObject).mutableCopy() as? NSMutableArray ?? []
            let bussinessObjsArray:NSMutableArray = NSMutableArray()
//            for busDict in dictArray {
//                let business:WALIFLocalBusinessResource! = WALIFLocalBusinessResource()
//                if let dictt = busDict as? NSDictionary {
//                    business._id = (dictt["_id"] as? NSString ?? "") as String
//                    //WALIFLocalizedString
//                    let addressName :WALIFLocalizedString! = WALIFLocalizedString()
//                    if let addressNameDict = dictt.value(forKey: "address") as? NSDictionary{
//                        if (appDelegate.en == appDelegate.locale){
//                            addressName.en = (addressNameDict.value(forKey: "en") as? NSString ?? "") as String
//                        }else{
//                            addressName.ar = (addressNameDict.value(forKey: "ar") as? NSString ?? "") as String
//                        }
//                    }
//                    business.address = addressName
//                    //WALIFLocalizedString
//                    let businessName :WALIFLocalizedString! = WALIFLocalizedString()
//                    if let businessNameDict = dictt.value(forKey: "businessName") as? NSDictionary{
//                        if (appDelegate.en == appDelegate.locale){
//                            businessName.en = (businessNameDict.value(forKey: "en") as? NSString ?? "") as String
//                        }else{
//                            businessName.ar = (businessNameDict.value(forKey: "ar") as? NSString ?? "") as String
//                        }
//                    }
//                    business.businessName = businessName
//                    //
//                    business.followersCount = dictt["followersCount"] as? NSNumber ?? 0
//                    //WALIFPlainCategory
//                    let plainCategory :WALIFPlainCategory! = WALIFPlainCategory()
//                    if let plainCategoryDict = dictt.value(forKey: "macroCategories") as? NSDictionary{
//                        if (appDelegate.en == appDelegate.locale){
//                            plainCategory.en = (plainCategoryDict.value(forKey: "en") as? NSString ?? "") as String
//                        }else{
//                            plainCategory.ar = (plainCategoryDict.value(forKey: "ar") as? NSString ?? "") as String
//                        }
//                    }
//                    business.macroCategories = plainCategory
//                    //
//                    business.saved = (dictt["saved"] as? NSNumber ?? 0)
//                    business.thumbnailUrl = dictt["thumbnailUrl"] as? String ?? ""
//                    business.uuid = (dictt["uuid"] as? NSString ?? "") as String
//                    //WALIFAverageRating
//                    let averageRating :WALIFAverageRating! = WALIFAverageRating()
//                    if let averageRatingDict = dictt.value(forKey: "globalRating") as? NSDictionary{
//                        averageRating.courtesy = (averageRatingDict.value(forKey: "courtesy") as? NSNumber ?? 0)
//                        averageRating.quality = (averageRatingDict.value(forKey: "quality") as? NSNumber ?? 0)
//                        averageRating.satisfaction = (averageRatingDict.value(forKey: "satisfaction") as? NSNumber ?? 0)
//                        averageRating.global = (averageRatingDict.value(forKey: "global") as? NSNumber ?? 0)
//                    }
//                    business.globalRating = averageRating
//                    //WALIFAverageRating(dictionary: <#T##[AnyHashable : Any]!#>, error: <#T##()#>)
//                    business.connectedCount = (dictt["connectedCount"] as? NSNumber ?? 0)
//                    business.businessState = (dictt["businessState"] as? NSString ?? "") as String
//                    bussinessObjsArray.add(business)
//                }
//            }
            return bussinessObjsArray
        }
    }
    @objc class func getRecentlyVisitedBusinessesDict() -> NSMutableArray! {
        if AppPreferences.getObjectvalue(forKey: .RECENTLY_VISITED_BUSINESSES) == nil {
            return []
        }else {
            return (AppPreferences.getObjectvalue(forKey: .RECENTLY_VISITED_BUSINESSES) as AnyObject).mutableCopy() as? NSMutableArray ?? []
        }
    }
    @objc class func getRecentlyVisitedLists() -> NSMutableArray! {
        if AppPreferences.getObjectvalue(forKey: .RECENTLY_VISITED_LISTS) == nil {
            return []
        }else {
            let dictArray:NSMutableArray =  (AppPreferences.getObjectvalue(forKey: .RECENTLY_VISITED_LISTS) as AnyObject).mutableCopy() as? NSMutableArray ?? []
            let listObjsArray:NSMutableArray! = NSMutableArray()
//            for listDict in dictArray {
//                let list: WALIFListDetailedResource! = WALIFListDetailedResource()
//                if let dictt = listDict as? NSDictionary {
//                    // do whatever with jsonResult
//                    if (dictt.value(forKey: "name") is NSDictionary) {
//                        let listName:WALIFLocalizedString! = WALIFLocalizedString()
//                        list._id = (dictt["_id"] as? NSString ?? "") as String
//                        if let listNameDict = dictt.value(forKey: "name") as? NSDictionary{
//                            if (appDelegate.en == appDelegate.locale){
//                                listName.en = (listNameDict.value(forKey: "en") as? NSString ?? "") as String
//                            }else{
//                                listName.ar = (listNameDict.value(forKey: "ar") as? NSString ?? "") as String
//                            }
//                        }
//                        list.name = listName
//                    } else{
//                        list._id = (dictt["_id"]  as? NSString ?? "") as String
//                    }
//                    listObjsArray.add(list)
//                }
//            }
            return listObjsArray
        }
    }

    @objc class func getRecentlyVisitedListsDict() -> NSMutableArray! {
        if AppPreferences.getObjectvalue(forKey: .RECENTLY_VISITED_LISTS) == nil {
            return []
        }else {
            return (AppPreferences.getObjectvalue(forKey: .RECENTLY_VISITED_LISTS) as AnyObject).mutableCopy() as? NSMutableArray ?? []
        }
    }
    @objc class func getRecentlyVisitedPeople() -> NSMutableArray! {
        if AppPreferences.getObjectvalue(forKey: .RECENTLY_VISITED_PEOPLE) == nil {
            return []
        }else {
            let recentlyPeopleArray:NSMutableArray! = (AppPreferences.getObjectvalue(forKey: .RECENTLY_VISITED_PEOPLE) as AnyObject).mutableCopy() as? NSMutableArray ?? []
            let peopleObjsArray:NSMutableArray! = NSMutableArray()
//            for item in recentlyPeopleArray {
//                if let dictt = item as? NSDictionary {
//                    let person:WALIFUserProfileResource! = WALIFUserProfileResource()
//                    person._id = dictt.value(forKey: "_id") as? String ?? ""
//                    person.uuid = dictt.value(forKey: "uuid") as? String ?? ""
//                    person.fullName = dictt.value(forKey: "fullName") as? String ?? ""
//                    person.firstName = dictt.value(forKey: "firstName") as? String ?? ""
//                    person.lastName = dictt.value(forKey: "lastName") as? String ?? ""
//                    person.userType = dictt.value(forKey: "userType") as? String ?? ""
//                    person.thumbnailUrl = dictt.value(forKey: "thumbnailUrl") as? String ?? ""
//                    person.friendlyUrlName = dictt.value(forKey: "friendlyUrlName") as? String ?? ""
//                    person.followed = dictt.value(forKey: "followState") as? NSNumber ?? 0
//                    person.followersCount = dictt.value(forKey: "followersCount") as? NSNumber ?? 0
//                    person.followingCount = dictt.value(forKey: "followingCount")as? NSNumber ?? 0
//                    person.connectedCount = dictt.value(forKey: "connectedCount")as? NSNumber ?? 0
//                    //WALIFLocalizedString
//                    let reputation:WALIFLocalizedString! = WALIFLocalizedString()
//                    if let reputationDict = dictt.value(forKey: "reputation") as? NSDictionary {
//                        if (appDelegate.en == appDelegate.locale)
//                        {reputation.en = (reputationDict.value(forKey: "en") as? NSString ?? "") as String}
//                        else
//                        {reputation.ar = (reputationDict.value(forKey: "ar") as? NSString ?? "") as String}
//
//                        person.reputation = reputation
//                    }
//                    //NSLog(@"id = %@, %@, %@, %@, %@", person._id, person.fullName, person.followersCount, person.followedCount, person.connectedCount);
//                    print(person.description)
//                    peopleObjsArray.add(person)
//                }
//            }
            return peopleObjsArray
        }
    }
    @objc class func getMyBusinessesId() -> NSMutableArray! {
        if AppPreferences.getObjectvalue(forKey: .MY_BUSINESSES_ID) == nil {
            return []
        }else {
            return (AppPreferences.getObjectvalue(forKey: .MY_BUSINESSES_ID) as AnyObject).mutableCopy() as? NSMutableArray ?? []
        }
    }
    @objc class func getMobilePromptType() -> String? {
        return AppPreferences.getStringvalue(forKey:  .MOBILE_PROMPT_TYPE)
    }
    @objc class func getPromptWasClosed() -> Bool {
        return AppPreferences.getBoolvalue(forKey: .WAS_KILLED)
    }
    @objc class func getRecentlyVisitedPeopleDict() -> NSMutableArray! {
        if AppPreferences.getObjectvalue(forKey: .RECENTLY_VISITED_PEOPLE) == nil {
            return []
        }else {
            return (AppPreferences.getObjectvalue(forKey: .RECENTLY_VISITED_PEOPLE) as AnyObject).mutableCopy() as? NSMutableArray ?? []
        }
    }
    @objc class func getReviewDict() -> NSMutableArray! {
        if AppPreferences.getObjectvalue(forKey: .BUSINESSES_REVIEW) == nil {
            return []
        }else {
            let reviewArray:NSMutableArray! = (AppPreferences.getObjectvalue(forKey: .BUSINESSES_REVIEW) as AnyObject).mutableCopy()  as? NSMutableArray ?? []
            let reviewObjsArray:NSMutableArray! = NSMutableArray()
//            for item in reviewArray {
//                if let dictt = item as? NSDictionary {
//                    let review:WALIFRateReviewDto! = WALIFRateReviewDto()
//                    review.rating = dictt.value(forKey: "rating") as? NSNumber ?? 0
//                    review.text = dictt.value(forKey: "text") as? String ?? ""
//                    //NSLog(@"id = %@, %@, %@, %@, %@", person._id, person.fullName, person.followersCount, person.followedCount, person.connectedCount);
//                    reviewObjsArray.add(review)
//                }
//            }
            return reviewObjsArray
        }
    }
    @objc class func getAppVersion() -> Int32 {
        let version:Int32 = Int32(AppPreferences.getIntvalue(forKey: .APP_VERSION))
        return version
    }
    @objc class func getNotificationsCount() -> Int32 {
        let count:Int32 = Int32(AppPreferences.getIntvalue(forKey: .NOTIFICATIONS_COUNT))
        return count
    }

    // MARK: - SETTERS

    @objc class func setHideSearchTypeSelector(_ value:Bool) {
        AppPreferences.save(value: value, forKey: .HIDE_SEARCH_TYPE_SELECTOR)
    }
    @objc class func setWasLaunched(_ value:Bool) {
        AppPreferences.save(value: value, forKey: .WAS_LAUNCHED)
    }
    @objc class func setWasLogged(_ value:Bool) {
        AppPreferences.save(value: value, forKey:.WAS_LOGGED)
    }
    @objc class func setAccessToken(_ value:String) {
        AppPreferences.save(value: value, forKey:.ACCESS_TOKEN)
    }
    @objc class func setGuestUserId(_ value:String) {
        AppPreferences.save(value: value, forKey:.GUEST_TOKEN)
    }
    @objc class func setIsFacebookLogin(_ value:Bool) {
        AppPreferences.save(value:value, forKey:.FACEBOOK_LOGIN)
    }
    @objc class func setIsGoogleLogin(_ value:Bool) {
        AppPreferences.save(value: value, forKey:.GOOGLE_LOGIN)
    }
    @objc class func setIsAppleLogin(_ value:Bool) {
        AppPreferences.save(value: value, forKey:.APPLE_LOGIN)
    }
    @objc class func setAppleLoginEmail(_ value:String!) {
        AppPreferences.save(value: value, forKey:.APPLE_LOGIN_EMAIL)
    }
    @objc class func setAppleLoginUserFirstName(_ value:String!) {
        AppPreferences.save(value: value, forKey:.APPLE_LOGIN_USER_FIRSTNAME)
    }
    @objc class func setAppleLoginUserLastName(_ value:String!) {
        AppPreferences.save(value: value, forKey:.APPLE_LOGIN_USER_LASTNAME)
    }
    @objc class func setRecentlyVisitedBusinesses(_ value:NSMutableArray!) {
        AppPreferences.save(value: value, forKey:.RECENTLY_VISITED_BUSINESSES)
    }
    @objc class func setRecentlyVisitedLists(_ value:NSMutableArray!) {
        AppPreferences.save(value: value, forKey:.RECENTLY_VISITED_LISTS)
    }
    @objc class func setRecentlyVisitedPeople(_ value:NSMutableArray!) {
        AppPreferences.save(value: value, forKey:.RECENTLY_VISITED_PEOPLE)
    }
    @objc class func setMyBusinessesId(_ value:NSMutableArray) {
        AppPreferences.save(value: value, forKey:.MY_BUSINESSES_ID)
    }
    @objc class func setAppVersion(_ version:Int32) {
        let strVersion:String = String(format:"%d", version)
        AppPreferences.save(value: strVersion, forKey:.APP_VERSION)
    }
    @objc class func setFollowingListId(_ value:String!) {
        AppPreferences.save(value: value, forKey:.LIST_ID_TO_FOLLOW)
    }
    @objc class func setFollowingPersonId(_ value:String) {
        AppPreferences.save(value: value, forKey:.PEOPLE_ID_TO_FOLLOW)
    }
    @objc class func setFollowingBusId(_ value:String!) {
        AppPreferences.save(value: value, forKey:.BUSINESS_ID_TO_FOLLOW)
    }
    @objc class func setFollowingBusName(_ value:String) {
        AppPreferences.save(value: value, forKey:.BUSINESS_NAME_TO_FOLLOW)
    }
    @objc class func setMobilePromptType(_ value:String!) {
        NSLog("setMobilePromptType = %@", value)
        if (value == "") && (AppPreferences.getMobilePromptType() == "MP_MANDATORY"){// dont override REMINDER TYPE from MP_MANDATORY UNTIl mobile number is added
            return
        }
        AppPreferences.save(value: value, forKey:.MOBILE_PROMPT_TYPE)
        if (value == "MP_MANDATORY") || (value == "MP_NONE") {
//              WalifUtils.showMobilePromptInTopControllerForTypeMANDATORYorNONE()
        }
    }
    @objc class func setMobilePromptTypeAsEmptyOnMobileNumberAdd() {
        AppPreferences.save(value: "", forKey:.MOBILE_PROMPT_TYPE)
    }
    @objc class func setPromptWasClosed(_ value:Bool) {
        AppPreferences.save(value: value, forKey:.WAS_KILLED)
    }

    // filters
    @objc class func setReviewDict(_ value:NSMutableArray) {
        AppPreferences.save(value: value, forKey:.BUSINESSES_REVIEW)
    }
    @objc class func setNotificationsCount(_ count:Int32) {
        let strVersion:String = String(format:"%d", count)
        AppPreferences.save(value: strVersion, forKey:.NOTIFICATIONS_COUNT)
    }
    @objc class func setClaimBusinessNil() {
        AppPreferences.setClaimBusinessDict(nil, nil, nil, nil)
    }
    @objc class func setClaimBusinessDict(_ businessId: String?,_ mobile:String?,_ role:String?,_ emailId:String?) {
        if businessId != nil {
            let data:NSMutableDictionary = NSMutableDictionary()
            data["businessId"] = businessId
            data["mobile"] = mobile
            data["role"] = role
            data["emailId"] = emailId
            AppPreferences.save(value: data, forKey:.CLAIM_BUSINESSES)
        } else {
            AppPreferences.save(value: "", forKey:.CLAIM_BUSINESSES)
        }
    }

    // ===================== FeaturedDeals -- Start============================
    @objc class func setDealsShowCaseShownStatus(_ value:Bool) {
        AppPreferences.save(value: value, forKey:.SHOWCASE_DEALS_SHOWN)
    }
    @objc class func getDealsShowCaseShownStatus() -> Bool {
        return AppPreferences.getBoolvalue(forKey: .SHOWCASE_DEALS_SHOWN)
    }
    @objc class func getShowCasedCountForExploreDeals() -> NSNumber! {
        let exploreTabShowcasedCount:NSNumber! = AppPreferences.getObjectvalue(forKey: .SHOWCASE_EXPLORETAB_DEAL_COUNT) as? NSNumber
        return exploreTabShowcasedCount
    }
    @objc class func setShowCasedCountForExploreDeals(_ aCount:NSNumber!) {
        AppPreferences.save(value: aCount!, forKey:.SHOWCASE_EXPLORETAB_DEAL_COUNT)
    }
    @objc class func incrementShowcaseAttemptCountForExploreDeal() {
        var exploreTabShowcasedCountInt:Int = 0
        let exploreTabShowcasedCount:NSNumber! = AppPreferences.getShowCasedCountForExploreDeals()
        if exploreTabShowcasedCount != nil {
            exploreTabShowcasedCountInt = exploreTabShowcasedCount.intValue
        }
        exploreTabShowcasedCountInt = exploreTabShowcasedCountInt + 1
        let incrementedCount:NSNumber! = NSNumber(value: Int32(exploreTabShowcasedCountInt))
        AppPreferences.setShowCasedCountForExploreDeals(incrementedCount)
    }
    // ===================== FeaturedDeals -- End==============================
    
    // ===================== FeaturedVideo -- Start============================
    @objc class func setFeaturedVideoShowCaseShownStatus(_ value:Bool) {
        AppPreferences.save(value: value, forKey:.SHOWCASE_FEATUREDVIDEO_SHOWN)
    }
    @objc class func getFeaturedVideoShowCaseShownStatus() -> Bool {
        return AppPreferences.getBoolvalue(forKey:.SHOWCASE_FEATUREDVIDEO_SHOWN)
    }
    @objc class func getShowCasedCountForExploreFeaturedVideo() -> NSNumber! {
        let exploreTabShowcasedCount:NSNumber = AppPreferences.getObjectvalue(forKey: .SHOWCASE_EXPLORETAB_FEATUREDVIDEO_COUNT) as! NSNumber
        return exploreTabShowcasedCount
    }
    @objc class func setShowCasedCountForExploreFeaturedVideo(_ aCount:NSNumber!) {
        AppPreferences.save(value: aCount!, forKey:.SHOWCASE_EXPLORETAB_FEATUREDVIDEO_COUNT)
    }
    @objc class func incrementShowcaseAttemptCountForExploreFeaturedVideo() {
        var exploreTabShowcasedCountInt:Int = 0
        let exploreTabShowcasedCount:NSNumber! = AppPreferences.getShowCasedCountForExploreFeaturedVideo()
        if exploreTabShowcasedCount != nil {
            exploreTabShowcasedCountInt = exploreTabShowcasedCount.intValue
        }
        exploreTabShowcasedCountInt = exploreTabShowcasedCountInt + 1
        let incrementedCount:NSNumber! = NSNumber(value: Int32(exploreTabShowcasedCountInt))
        AppPreferences.setShowCasedCountForExploreFeaturedVideo(incrementedCount)
    }

    // ===================== FeaturedVideo -- End=================================

    // ===================== Featured Articles -- Start============================
    @objc class func setFeaturedArticlesShowCaseShownStatus(_ value:Bool) {
        AppPreferences.save(value: value, forKey:.SHOWCASE_FEATUREDARTICLES_SHOWN)
    }
    @objc class func getFeaturedArticlesShowCaseShownStatus() -> Bool {
        return AppPreferences.getBoolvalue(forKey:.SHOWCASE_FEATUREDARTICLES_SHOWN)
    }
    @objc class func getShowCasedCountForExploreFeaturedArticles() -> NSNumber! {
        let exploreTabShowcasedCount:NSNumber = AppPreferences.getObjectvalue(forKey:.SHOWCASE_EXPLORETAB_FEATUREDARTICLES_COUNT) as? NSNumber ?? 0
        return exploreTabShowcasedCount
    }
    @objc class func setShowCasedCountForExploreFeaturedArticles(_ aCount:NSNumber!) {
        AppPreferences.save(value: aCount, forKey:.SHOWCASE_EXPLORETAB_FEATUREDARTICLES_COUNT)
    }
    @objc class func incrementShowcaseAttemptCountForExploreFeaturedArticles() {
        var exploreTabShowcasedCountInt:Int = 0
        let exploreTabShowcasedCount:NSNumber! = AppPreferences.getShowCasedCountForExploreFeaturedArticles()
        if exploreTabShowcasedCount != nil {
            exploreTabShowcasedCountInt = exploreTabShowcasedCount.intValue
        }
        exploreTabShowcasedCountInt = exploreTabShowcasedCountInt + 1
        let incrementedCount:NSNumber = NSNumber(value: Int32(exploreTabShowcasedCountInt))
        AppPreferences.setShowCasedCountForExploreFeaturedArticles(incrementedCount)
    }
    // ===================== Featured Articles -- End============================

    // ===================== Blogs -- Start============================
    @objc class func setBlogsShowCaseShownStatus(_ value:Bool) {
        AppPreferences.save(value: value, forKey:.SHOWCASE_BLOG_SHOWN)
    }
    @objc class func getBlogsShowCaseShownStatus() -> Bool {
        return AppPreferences.getBoolvalue(forKey: .SHOWCASE_BLOG_SHOWN)
    }
    @objc class func getShowCasedCountForExploreBlogs() -> NSNumber! {
        let exploreTabShowcasedCount:NSNumber = AppPreferences.getIntvalue(forKey:.SHOWCASE_EXPLORETAB_BLOG_COUNT) as NSNumber
        return exploreTabShowcasedCount
    }
    @objc class func setShowCasedCountForExploreBlogs(_ aCount:NSNumber!) {
        AppPreferences.save(value: aCount!,forKey: .SHOWCASE_EXPLORETAB_BLOG_COUNT)
    }
    @objc class func incrementShowcaseAttemptCountForExploreBlogs() {
        var exploreTabShowcasedCountInt:Int = 0
        let exploreTabShowcasedCount:NSNumber! = AppPreferences.getShowCasedCountForExploreBlogs()
        if exploreTabShowcasedCount != nil {
            exploreTabShowcasedCountInt = exploreTabShowcasedCount.intValue
        }
        exploreTabShowcasedCountInt = exploreTabShowcasedCountInt + 1
        let incrementedCount:NSNumber! = NSNumber(value: Int32(exploreTabShowcasedCountInt))
        AppPreferences.setShowCasedCountForExploreBlogs(incrementedCount)
    }
    // ===================== Blogs -- End============================
}


