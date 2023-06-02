//
//  PresentationHeaderViewController.swift
//  Hi_Dubai
//
//  Created by Asif Khan on 12/05/2023.
//

import UIKit

@objc class PresentationHeaderViewController: UIViewController {

    @objc var pagerVC: ProfileHeaderPagerViewController?
    
//    @IBOutlet weak var verticalAlignmentConstraint: NSLayoutConstraint?
//    @IBOutlet weak var tagLabel: UserTagLabel?
//    @IBOutlet var photo: RoundedImageView?
//    @IBOutlet var jobsLabel: UILabel?
//    @IBOutlet weak var fullNameLabel: UILabel?
//    @IBOutlet weak var buttonsView: UIView?
//    @IBOutlet weak var followBtn: RoundedButtonImage?
//    @IBOutlet weak var followingBtn: RoundedButtonImage?
//    @IBOutlet weak var feedBtn: RoundedButtonImage?
    
    
//    var _userObj: WALIFUserProfileDetailedResource?
    
//    @objc var userObj: WALIFUserProfileDetailedResource? {
//
//        set {
//            _userObj = newValue
//            refreshData()
//            applyDefaultLayout()
//
//        }
//        get {
//            return _userObj
//        }
//    }
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
//    @objc func refreshData() {
//        var t: String?
//        if userObj == nil || (userObj != nil && (userObj!._id == (appDelegate.user?._id ?? ""))) {
//            fullNameLabel?.text = appDelegate.user?.fullName ?? ""
//            jobsLabel?.text = appDelegate.user?.jobDescription ?? ""
//            t = appDelegate.user?.thumbnailUrl
//        }else {
//            fullNameLabel?.text = userObj?.fullName ?? ""
//            jobsLabel?.text = userObj?.jobDescription ?? ""
//            t = userObj?.thumbnailUrl
//        }
//        refreshPhoto(t ?? "")
//    }
    /*-(void) viewDidAppear:(BOOL)animated{
        [super viewDidAppear:animated];
        if(APPDEL.token != nil && ![APPDEL.token isEqualToString:@""] && ![AppPreferences getPromptWasClosed]) {
            [WalifUtils showMobilePrompt:self];
            [AppPreferences setMobilePromptType:@""];
            //[AppPreferences setPromptWasClosed:TRUE];
        }
    }*/
    
    
//    func refreshPhoto(_ url: String?) {
//        if url != nil {
//            let manager = SDWebImageManager.shared
//
//            manager.loadImage(
//                with: URL(string: url!),
//                options: .retryFailed,
//                progress: { receivedSize, expectedSize, targetURL in
//                    // progression tracking code
//                },
//                completed: { [self] image, data, error, cacheType, finished, imageURL in
//                    DispatchQueue.main.async(execute: { [self] in
//
//                        self.photo?.image = image
//
//                    })
//                })
//        }
//    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//
//        if appDelegate.authFromDeepLink {
//
//            completePostLoginActions()
//
//            appDelegate.authFromDeepLink = false
//        }
        
        //    if(APPDEL.token==nil || [APPDEL.token isEqualToString:@""]){
        //        [self.buttonsView setHidden:NO];
        //        [self.followBtn setHidden:NO];
        //        [self.feedBtn setHidden:YES];
        //        [self.followingBtn setHidden:YES];
        //    }
        //
            //[self refreshPhoto:APPDEL.user.thumbnailUrl];
    }
        
    
}
