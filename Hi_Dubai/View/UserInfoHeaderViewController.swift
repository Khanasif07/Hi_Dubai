//
//  UserInfoHeaderViewController.swift
//  Hi_Dubai
//
//  Created by Asif Khan on 12/05/2023.
//

import UIKit
import Foundation
@objc class UserInfoHeaderViewController: UIViewController {

var snapURL: String?
//    @objc var userObj: WALIFUserProfileDetailedResource?
//    @IBOutlet var facebook: UIView?
//    @IBOutlet var snapchat: UIView?
//    @IBOutlet var twitter: UIView?
//    @IBOutlet var instagram: UIView?
//
//    @IBOutlet var lblLivingIn: UILabel?
//    @IBOutlet var lblCountry: UILabel?
//    @IBOutlet var lblInDubaiSince: UILabel?
//    @IBOutlet var lblLivingInDesc: UILabel?
//    @IBOutlet var lblCountryDesc: UILabel?
//    @IBOutlet var lblInDubaiSinceDesc: UILabel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        initUI()
    }

    @objc func refreshData() {
//        initUI()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

//    func initUI() {
//
//        // Labels Setup
//        if userObj?.livingIn != nil {
//            if let Neighborhood = appDelegate.getNeighborhoodById(userObj!.livingIn?._id) {
//                lblLivingIn?.text = WalifUtils.localize(Neighborhood.formatted)
//            }
//
//        } else {
//            lblLivingIn?.isHidden = true
//            lblLivingInDesc?.isHidden = true
//        }
//
//        if userObj?.country?.label != nil && (WalifUtils.localize(userObj!.country!.label) != "") {
//            lblCountry?.text = WalifUtils.localize(userObj!.country!.label)
//        } else {
//            lblCountry?.isHidden = true
//            lblCountryDesc?.isHidden = true
//        }
//
//        if userObj?.inDubaiSince != nil && (userObj!.inDubaiSince != "") {
//            lblInDubaiSince?.text = WalifUtils.getYearOfDate(userObj!.inDubaiSince)
//        } else {
//            lblInDubaiSince?.isHidden = true
//            lblInDubaiSinceDesc?.isHidden = true
//        }
//
//        let hideFb = userObj?.facebookUri == nil || (userObj!.facebookUri == "")
//        let hideTw = userObj?.twitterUri == nil || (userObj!.twitterUri == "")
//        let hideInst = userObj?.instagramUri == nil || (userObj!.instagramUri == "")
//        let hideSc = userObj?.snapchatUri == nil || (userObj!.snapchatUri == "")
//
//        facebook?.isHidden = hideFb
//        twitter?.isHidden = hideTw
//        instagram?.isHidden = hideInst
//        snapchat?.isHidden = hideSc
//    }
    
//    @IBAction func openSocial(byId sender: Any) {
//
//        let pressedButton = sender as? UIButton
//        let tagRef = pressedButton?.tag ?? 0
//
//        switch tagRef {
//        case 0 /* FACEBOOK */:
//            if let url = URL(string: "https://www.facebook.com/\(userObj?.facebookUri ?? "")") {
//                UIApplication.shared.open(url, options: [:])
//            }
//        case 1 /* TWITTER */:
//            if let url = URL(string: "https://www.twitter.com/\(userObj?.twitterUri ?? "")") {
//                UIApplication.shared.open(url, options: [:])
//            }
//        case 2 /* INSTAGRAM */:
//            if let url = URL(string: "https://www.instagram.com/\(userObj?.instagramUri ?? "")") {
//                UIApplication.shared.open(url, options: [:])
//            }
//        case 3 /* SNAPCHAT */:
//            if let url = URL(string: "snapchat:") {
//                if UIApplication.shared.canOpenURL(url) {
//                    snapURL = "snapchat://add/\(userObj?.snapchatUri ?? "")"
//                } else {
//                    snapURL = "https://www.snapchat.com/add/\(userObj?.snapchatUri ?? "")"
//                }
//            }
//            if snapURL != nil , let url = URL(string: snapURL!) {
//                UIApplication.shared.open(url, options: [:])
//            }
//        default:
//            break
//        }
//    }
    
}


