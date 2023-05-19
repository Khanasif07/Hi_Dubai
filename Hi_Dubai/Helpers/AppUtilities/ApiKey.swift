//
//  ApiKey.swift
//  Hi_Dubai
//
//  Created by Asif Khan on 17/05/2023.
//
import Foundation

// MARK:- Api Keys -
enum ApiKey {
    
    // MARK:- Headers -
    static var Authorization: String { return "Authorization" }
    static var auth : String { return "authorization" }

    // MARK:- Common Keys -
    static var statusCode: String { return "statusCode" }
    static var message: String { return "message" }
    static var data: String { return "data" }
    static var page: String { return "page" }
    static var nextPageStatus: String { return "nextPageStatus" }
    static var token: String { return "token" }
    static var deviceDetails: String { return "deviceDetails" }
    static var id: String { return "id" }
    static var accessToken: String { return "authToken" }
    static var voip: String { return "voip" }
    static var userId: String { return "userId" }
    static var otp : String {return "otp"}
    static var isLogin: String { return "isLogin"}
    static var delete : String {return "delete"}
    static var lastMessageDelete : String {return "lastMessageDelete"}
    static var date : String {return "date"}
    static var shareUrl : String {return "shareUrl"}
    
    static var emailForOnlineDB : String {return "emailForOnlineDB"}
    
    static var groupArchive : String { return "groupArchive"  }
    
    static var bannerType : String {return "bannerType"}
    
    static var removedAt : String { return "removedAt" }
    
    static var groupMessage : String {  return  "groupMessage" }
    

    // MARK:- QBUSER OPPONENTS MODEL -
    static var ID: String {  return  "ID" }
    static var CreatedAt: String {  return  "Created At" }
    static var UpdatedAt: String {  return  "Updated At" }
    static var externalUserID: String {  return  "externalUserID" }
    static var blobID: String {  return  "blobID" }
    static var facebookID: String {  return  "facebookID" }
    static var twitterID: String {  return  "twitterID" }
    static var full_name: String {  return  "full name" }
    static var login: String {  return  "login" }
    static var phone: String {  return  "phone" }
    static var tags: String {  return  "tags" }
    static var customData: String {  return  "customData" }
    static var website: String {  return  "website" }
    static var lastRequestAt: String {  return  "lastRequestAt" }
//    static var quickBloxId: String {  return  "quickBloxId" }
    static var quickBloxLogin: String {  return  "quickBloxLogin" }
    static var quickBloxPassword: String {  return  "quickBloxPassword" }
    static var blockedBy : String {return "blockedBy"}
    static var blockedUsers : String {return "blockedUsers"}
    
    // MARK:- Super Talks -
    static var welcomeContent: String { return "welcomeContent" }
    static var latest: String { return "latest" }
    static var mostPopular: String { return "mostPopular" }
    static var topicsForUser: String { return "topicsForUser" }
    static var moodImage: String { return "moodImage" }
    static var featured: String { return "featured" }
    
    
    // MARK:- Talk Model -
    static var _id: String { return "_id" }
    
    static var postData: String { return "postData" }
    static var post: String { return "POST" }
    static var classes: String { return "CLASS" }


    
    static var superPowers : String { return "superPowers" }
    static var classData   : String { return "classData" }
    
    static var userData: String { return "userData" }
    static var likedByUser: String { return "likedByUser" }
    static var savedByUser: String { return "savedByUser" }
    static var likeCount: String { return "likeCount" }
    static var shareCount: String { return "shareCount" }
    static var seenCount: String { return "seenCount" }
    static var caption: String { return "caption" }

    static var commentCount: String { return "commentCount" }
    static var mood: String { return "mood" }
    static var categoryData: String { return "categoryData" }
    static var subTitle: String { return "subTitle" }
    static var exploreTopics: String { return "exploreTopics" }
    static var isFeatured: String { return "isFeatured" }
    
    static var isStory : String { return "isStory" }

    // MARK:- PostData Model -
    static var title: String { return "title" }
    static var media: String { return "media" }
    static var moodType: String { return "moodType" }
    static var postedBy: String { return "postedBy" }

    // MARK:- Media Model -
    static var original: String { return "original" }
    static var thumbnail: String { return "thumbnail" }
    static var aspectRatio: String { return "aspectRatio" }

    static var type: String { return "type" }
    
    // MARK:- User Model -
    static var profilePicture: String { return "profilePicture" }
    static var fullName: String { return "fullName" }
    static var selectedImage: String { return "selectedImage" }
    static var profileStep : String { return "profileStep" }
    static var emailVerified : String { return "emailVerified" }
    static var followedByUser : String { return "followedByUser" }
    
    static var followUser : String { return "followUser" }


    // MARK:- Topics Model -
    static var name: String { return "name" }
    static var image: String { return "image" }
    static var __v: String { return "__v" }
    
    // MARK:- Post View -
    static var postId: String { return "postId" }
    static var recentComments: String { return "recentComments" }
    
    // MARK:- Comments Model -
    static var createdOn: String { return "createdOn" }
    static var createdDate: String { return "createdDate" }
    static var comment: String { return "comment" }
    static var commentId: String { return "commentId" }
    static var replyData: String { return "replyData" }
    static var replyCount: String { return "replyCount" }
    static var dislikedByUser: String { return "dislikedByUser" }
    static var reply: String { return "reply" }
    static var commentData: String { return "commentData" }
    static var tempCommentId: String { return "tempCommentId" }
    static var tempReplyId: String { return "tempReplyId" }
    
    // MARK:- Post Action API -
    static var action: String { return "action" }
    static var parentCommentId: String { return "parentCommentId" }
    static var location: String { return "location" }
    
    static var isSubscriptionExpired: String { return "isSubscriptionExpired" }
    static var subscriptionPlatform: String { return "subscriptionPlatform" }
    
    static var coordinates: String { return "coordinates" }
    
    // MARK:- Create Talk 1 -
    static var content: String { return "content" }
    static var contentImg: String { return "contentImg" }
    static var mainImg: String { return "mainImg" }
    static var imgString: String { return "imgString" }
    static var usersTagged: String { return "usersTagged" }
    static var category: String { return "category" }
    static var duration: String { return "duration" }

    // MARK:- Login -
    static var email: String { return "email" }
    static var password: String { return "password" }
    static var phoneNo: String { return "phoneNo" }
    static var countryCode: String { return "countryCode" }
    static var interests: String { return "interests" }
    static var isReturn: String { return "isReturn" }
    
    // MARK:- Signup -
    static var firstName: String { return "firstName" }
    static var lastName: String { return "lastName" }
    static var gender: String { return "gender" }
    static var confirmPassword: String { return "confirmPassword" }
    static var city: String { return "city" }
    static var isVip: String {return "isVip"}
    static var country: String { return "country" }

    // MARK:- Fire User Data -
    static var fireUserId: String { return "fireUserId" }
    static var fireUserProfilePic: String { return "fireUserProfilePic" }
    static var fireUserFullName: String { return "fireUserFullName" }
    static var isOnline: String { return "isOnline" }
    static var loginTime: String { return "loginTime" }
    static var blockedUserIds: String { return "blockedUserIds" }
    static var reportedUserIds: String { return "reportedUserIds" }
    static var archivedChatIds: String { return "archivedChatIds" }
    static var reportedMsgIds: String { return "reportedMsgIds" }
    static var quickBloxId: String { return "quickBloxId" }
    static var totalCount: String { return "totalCount" }
    
    static var userIds : String {return "userIds"}
    
    static var block : String { return "block" }
    static var isBlocked : String { return "isBlocked"} // in chat by Admin
    static var archive : String { return "archive" }

    // MARK:- Fire Chat Room -
    static var total: String { return "total" }
    static var search: String { return "search" }
    static var isUpdated: String { return "isUpdated" }
    static var roomId: String { return "roomId" }
    static var roomType: String { return "roomType" }
    static var roomOwner: String { return "roomOwner" }
    static var roomOwnerName : String {return "roomOwnerName"}
    static var members: String { return "members" }
    static var roomName: String { return "roomName" }
    static var roomImage: String { return "roomImage" }
    static var lastMessage: String { return "lastMessage" }
    static var unreadCount: String { return "unreadCount" }
    static var createdAt: String { return "createdAt" }
    
    static var reportDescription : String { return "reportDescription" }
    static var reportCount : String { return "reportCount" }
    
    static var groupReported : String { return "groupReported" }


    
    static var isTyping : String {return "typing"}
    static var groupTyping : String {return "groupTyping"}
    
    static var isAdmin : String { return "isAdmin" }

    
    
    
    // MARK:- Fire Chat Room Model -
    static var memberId: String { return "memberId" }
    static var memberName: String { return "memberName" }
    static var memberImage: String { return "memberImage" }
    static var memberAction: String { return "memberAction" }

    // MARK:- Message -
    static var senderId: String { return "senderId" }
    static var senderName: String { return "senderName" }
    static var senderImage: String { return "senderImage" }
    
    static var chatMedia : String { return "chatMedia" }
    static var subType : String { return "subType" }

    static var messageId: String { return "messageId" }
    static var messageRoomId: String { return "messageRoomId" }
    static var messageType: String { return "messageType" }
    static var messageStatus: String { return "messageStatus" }
    static var messageTimestamp: String { return "messageTimestamp" }
    static var messageText: String { return "messageText" }
    static var messageImageLinks: String { return "messageImageLinks" }
    static var messageAudioLink: String { return "messageAudioLink" }
    static var messageVideoLink: String { return "messageVideoLink" }
    static var messageUrlMetaData: String { return "messageUrlMetaData" }
    static var thumbTemp: String { return "thumbTemp" }
    static var videoTemp: String { return "videoTemp" }
    static var videoLink: String { return "videoLink" }
    
    static var valid: String { return "valid" }
    
    static var isDelete : String { return "isDelete"}
    
    static var isForward : String {return "isForwarded"}
    
    static var linkTitle : String {return "linkTitle"}

    static var linkDescription : String {return "linkDescription"}

    static var linkImage : String {return "linkImage"}

    static var linkCanonical : String {return "linkCanonical"}
    
    static var adminId : String {return "adminId"}
    
    static var receiverName : String { return "receiverName" }
    
    static var groupRead : String {return "groupRead" }
    
    static var deviceType : String {return "deviceType"}

    // MARK:- Shared Media Storage -
    static var temp: String { return "temp" }
    
    static var url: String { return "url" }
    
    static var finalUrl: String { return "finalUrl" }
    
    static var canonicalUrl: String { return "canonicalUrl" }
    
    static var images: String { return "images" }
        
    static var icon: String { return "icon" }
    
    static var video: String { return "video" }
    
    static var price: String { return "price" }
    static var mediaId: String { return "mediaId" }
    static var mediaLink: String { return "mediaLink" }
    static var mediaThumbnailLink: String { return "mediaThumbnailLink" }
    static var mediaType: String { return "mediaType" }
    static var mediaTimestamp: String { return "mediaTimestamp" }
    
    static var timeStamp : String {return "timeStamp"}
    
    // MARK:- Class Model -
    static var description: String { return "description" }
    static var liveNow: String { return "liveNow" }
    static var upcoming: String { return "upcoming" }
    static var scheduledOn: String { return "scheduledOn" }
    static var uploadedBy: String { return "uploadedBy" }
    static var displayCounts: String { return "displayCounts" }
    static var isSubscribed: String { return "isSubscribed" }
    
    //MARK: ------Group Id------------
    static var groupId : String {return "groupId"}
    static var groupTitle : String {return "groupTitle"}
    static var mainGroupImage : String {return "mainGroupImage"}
    
    // MARK:- Subscription Model -
    static var status : String {return "status"}
    static var cancelUpcoming : String {return "cancelUpcoming"}
    static var isDeleted : String {return "isDeleted"}
    static var subscriptionId : String {return "subscriptionId"}
    static var transactionId : String {return "transactionId"}
    static var transId : String {return "transId"}
    
    //MARK:- Map
    static var distance: String { return "distance" }
    static var CURENT_TAB: String { return "CURENT_TAB" }
    static var innerRadius: String { return "innerRadius" }
    static var outerRadius: String { return "outerRadius" }
    static var lat: String { return "lat" }
    static var lng: String  { return "lng" }
    
    
    // MARK:- Location Model -
    static var gCoordinate: String               { return "coordinate" }
    static var gPinCode: String                  { return "postal_code" }
    static var gCountry: String                  { return "country" }
    static var gState: String                    { return "administrative_area_level_1" }
    static var gCity: String                     { return "locality" }
    static var state: String                     { return "State" }
    static var cityK: String                     { return "City" }
    static var countryK: String                  { return "Country" }
    static var formatAddLines: String            { return "FormattedAddressLines" }
    static var zipC: String                      { return "ZIP" }
    static var nameK: String                     { return "Name" }
    static var subLocality: String               { return "SubLocality" }
    
    //MARK: TALK POST
    static var postType: String { return "postType" }
    static var previousState: String { return "previousState" }
    static var like: String { return "LIKE" }
    static var dislike: String { return "DISLIKE" }
    
    //MARK: TALK FILTER
    static var categories: String { return "categories" }
    
    //MARK: TALK Search
    static var criteria: String { return "criteria" }
    
    //MARK: MY CLASSES
    static var myUpcoming: String { return "myUpcoming" }
    static var myLive: String { return "myLive" }
    static var myClasses: String { return "myClasses" }
    
    static var isRemoved : String { return "isRemoved" }
    
    static var pastLive  : String { return "pastLive" }
    
    //MARK: ---------- Live streaming ------------
    static var streamName : String { return "streamName" }
    static var streamID : String { return "streamId" }
    static var streamSave : String { return "saveStream" }

    

//    static var userId : String { return "userId" }
    static var requestType : String { return "requestType" }
    static var secondaryStreamId : String { return "secondaryStreamId" }

    static var secondaryStreamName : String { return "secondaryStreamName" }
    static var dislikeCount : String { return "dislikeCount" }
    static var reportReason : String { return "reportReason" }
    static var reason : String { return "reason" }
    static var otherReason : String { return "otherReason" }
    static var isActive : String { return "reportReason" }
    static var backgroundColour: String { return "backgroundColour" }
    static var streamOwnerId : String { return "streamOwnerId" }
    static var secondaryStreamOwnerId : String { return "secondaryStreamOwnerId" }

    //MARK:- SuperYouHome
    static var bottom: String { return "bottom" }
    static var top: String { return "top" }

    
    //MARK:- SuperYouPoints
    
    static var rewardData : String {return "rewardData"}
    static var rewardImage: String {return "rewardImage"}
    static var rewardLevels: String {return "rewardLevels"}
    static var acceptedOn : String {return "acceptedOn"}
    static var referralData : String {return "referralData"}
    static var merchandiseData : String {return "merchandiseData"}
    static var userName : String {return "userName"}
    
    //MARK:- BlockVC
    static var blocked : String {return "BLOCKED"}
    static var unBlocked : String {return "UNBLOCK"}
    
    //MARK:- notifications
    static var entityId : String {return "entityId"}
    static var isFollowing : String {return "isFollowing"}
    // Filter Model
    static var classType :String { return "classType"}
    static var filterFrom :String { return "filterFrom"}
    static var filterTo :String { return "filterTo"}

    static var rewards: String { return "rewards" }
    static var colour: String { return "colour" }
    static var currentLevel: String { return "currentLevel" }
    static var totalLevels: String { return "totalLevels" }
    static var welcomeMessage: String { return "welcomeMessage" }
    static var rewardsDetail: String { return "rewardsDetail" }
    static var welcomeVideo: String { return "welcomeVideo" }
    static var creds: String { return "CREDS" }
    static var tier: String { return "TIER" }
    static var live: String { return "live" }
    static var favourites: String { return "favourites" }
    static var newSupershes: String { return "newSupershes" }
    
    static var mostLoved: String { return "mostLoved" }
    static var mostDiscussed: String { return "mostDiscussed" }
    static var width: String { return "width" }
    static var height: String { return "height" }
    static var badgeData: String { return "badgeData" }
    static var preview: String { return "preview" }
    static var scheduleOn: String { return "scheduleOn" }
    
    static var ownNotification: String { return "ownNotification" }
    static var ownClasses: String { return "ownClasses" }
    static var ownTalks: String { return "ownTalks" }
    static var savedClasses: String { return "savedClasses" }
    static var savedtalks: String { return "savedtalks" }
    static var users : String {return "users"}
    
    static var viewCount : String { return "viewCount" }
    static var imageType: String { return "imageType" }
    
    static var deviceToken : String {return "deviceToken"}
    static var deviceTokens : String {return "deviceTokens"}
    
    static var dob: String { return "dob" }
    static var isVerify: String { return "isVerify" }
    static var registeredFrom: String { return "registeredFrom" }
    static var tempEmail: String { return "tempEmail" }

    static var receiverId : String {return "receiverId"}
    
    static var needCompleteDetails : String {return "needCompleteDetails"}
    
    static var byPassTopScreenCheck : String {return "byPassTopScreenCheck"}
    
    // TRACK
    static var allowNotification : String {return "allowNotification"}
    static var referralCode : String {return "referralCode"}
    static var referredCode : String {return "referredCode"}
    static var referralLink: String { return "referralLink" }

   //Calling
    static var showCallingMessage : String {return "showCallingMessage"}
    static var elapsedTimeCalling : String {return "elapsedTimeCalling"}
    static var isVideoAudio : String {return "isVideoAudio"}

    static var refCreatedOn : String {return "refCreatedOn"}
    static var isReedemable: String { return "isReedemable" }
}

// MARK:- Api Code -
enum ApiCode {
    /// Success
    static var success: Int { return 200 }
    /// Unauthorized request
    static var unauthorizedRequest: Int { return 401 }
    /// Unauthorized request
    static var adminBlockedUser: Int { return 403 }
    // Header is missing
    static var headerMissing: Int { return 207 }
    /// Phone number alredy exists
    static var phoneNumberAlreadyExist: Int { return 208 }
    /// Required Parameter Missing or Invalid
    static var requiredParametersMissing: Int { return 418 }
    /// File Upload Failed
    static var fileUploadFailed: Int { return 421 }
    /// Bad Request
    static var badRequest: Int { return 400 }
    /// Email Or Phone Already Exist
    static var emailOrPhoneAlreadyExist: Int { return 499 }
    /// Please try again
    static var pleaseTryAgain: Int { return 500 }
    /// Talk Class Block
    static var talkClassBlock: Int { return 403 }
    
    static var subscriptionExpired: Int { return 410 }
    
    static var appleAccountAlreadyInUse: Int { return 409 }
    
    static var upgradeSubscriptionFailure: Int { return 406 }
    
    static var timeOut: Int { return -1001 }
}
