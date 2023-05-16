//
//  MainDetailsTableViewController.swift
//  Hi_Dubai
//
//  Created by Asif Khan on 09/05/2023.
//

import UIKit
import Foundation
@objc class MainDetailsTableViewController: BaseNestedScrollViewController{
    @IBOutlet weak var mainImgView: UIImageView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var tabContainer: UIView!
    @IBOutlet weak var tabContainerHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var  fakeNavBar: UIImageView!
    @IBOutlet weak var fakeNavBarHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var navBarTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var navBar: UINavigationBar!
    @IBOutlet weak var titleLabel: UILabel!
    
    var newsModel: Record?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        super.navbar = navBar
        var bottomoffset: CGFloat = 0
        var topoffset: CGFloat = 0
        var topPaddingRef: CGFloat = 0.0
        if #available(iOS 13.0, *) {
            let window = UIApplication.shared.windows.first
            bottomoffset = window?.safeAreaInsets.bottom ?? 0
            if let topPadding = window?.safeAreaInsets.top{
                topoffset = topPadding
                topPaddingRef = topPadding + 0.0
                navBarTopConstraint.constant = topPaddingRef
                fakeNavBarHeightConstraint.constant = topPaddingRef + self.navBar.height //44 is nav bar height
                fakeNavBar.layoutIfNeeded()
                navBar.layoutIfNeeded()
            }
        }
//        tabContainerHeightConstraint.constant = UIScreen.main.bounds.size.height - 52 - 49 - bottomoffset - topoffset
           view.layoutIfNeeded()
        setUIObjectsScrollView(scrollView: scrollView, tabContainer: tabContainer, heightConstraint: tabContainerHeightConstraint, fakeNavBar: fakeNavBar, titleLabel: titleLabel)
        scrollView.isScrollEnabled = false

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        mainImgView.setImageFromUrl(ImageURL: self.newsModel?.postImageURL ?? "")
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        scrollView.isScrollEnabled = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        //        parent?.navigationController?.isNavigationBarHidden = false
        //        navigationController?.isNavigationBarHidden = false
    }
}



