//
//  MainDetailsTableViewController.swift
//  Hi_Dubai
//
//  Created by Asif Khan on 09/05/2023.
//

import UIKit
import Foundation
@objc class MainDetailsTableViewController: BaseNestedScrollViewController{
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var mainImgView: UIImageView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var tabContainer: UIView!
    @IBOutlet weak var tabContainerHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var  fakeNavBar: UIImageView!
    @IBOutlet weak var navBar: UINavigationBar!
    @IBOutlet weak var titleLabel: UILabel!
    
    var newsModel: Record?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        super.navbar = navBar
        self.navigationItem.hidesBackButton = false
        UINavigationBar.appearance().tintColor = UIColor.white
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        mainImgView.setImageFromUrl(ImageURL: self.newsModel?.postImageURL ?? "")
        view.layoutIfNeeded()
        setUIObjectsScrollView(scrollView: scrollView, tabContainer: tabContainer, heightConstraint: tabContainerHeightConstraint, fakeNavBar: fakeNavBar, titleLabel: titleLabel)
        scrollView.isScrollEnabled = false
    }
    
    @IBAction func backBtnAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        scrollView.isScrollEnabled = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
    }
}



