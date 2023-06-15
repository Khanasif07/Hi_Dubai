//
//  BaseMyProfileTabsViewController.swift
//  Hi_Dubai
//
//  Created by Asif Khan on 12/05/2023.
//


import Foundation
import UIKit
import CarbonKit
class BaseMyProfileTabsViewController: LightStatusBarViewController,CarbonTabSwipeNavigationDelegate {
    
    @IBOutlet weak var targetView: UIView!
    @IBOutlet weak var toolBar: UIToolbar!
    //
    private var carbonTabSwipeNavigation: CarbonTabSwipeNavigation? =   CarbonTabSwipeNavigation()
    private var tabs: [String]?
    //
    public var listVC: NewsListVC?
    public var savedListVC: NewsListVC?
    public var viewController: NewsListVC?
    public var tipsVC: NewsListVC?
    public var pointsVC: NewsListVC?
    public var rewardsVC: NewsListVC?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    func initUI() {
        tabs = [
            "INFO",
            "REVIEWS",
            "DEALS",
            "CONTACTS",
            "EXPLORE",
            "HOME"
        ]
        listVC = NewsListVC.instantiate(fromAppStoryboard: .Main)
        savedListVC = NewsListVC.instantiate(fromAppStoryboard: .Main)
        viewController = NewsListVC.instantiate(fromAppStoryboard: .Main)
        tipsVC = NewsListVC.instantiate(fromAppStoryboard: .Main)
        pointsVC = NewsListVC.instantiate(fromAppStoryboard: .Main)
        rewardsVC = NewsListVC.instantiate(fromAppStoryboard: .Main)
        
        carbonTabSwipeNavigation = CarbonTabSwipeNavigation(items: tabs, toolBar: toolBar,delegate: self)
        carbonTabSwipeNavigation?.insert(intoRootViewController: self, andTargetView: targetView)
        carbonTabSwipeNavigation?.delegate = self

        let color = UIColor.midnightBlue
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.tintColor = .clear
        navigationController?.navigationBar.barTintColor = color
        navigationController?.navigationBar.barStyle = .blackTranslucent
        
        carbonTabSwipeNavigation?.toolbar.isTranslucent = false
            carbonTabSwipeNavigation?.setIndicatorColor(color)
            // Custimize segmented control
        
        if true /*IS_IPHONE_5_OR_LESS*/ {
            carbonTabSwipeNavigation?.setSelectedColor(color, font: UIFont.boldSystemFont(ofSize: 12))
            carbonTabSwipeNavigation?.setNormalColor(.lightGray, font: UIFont.systemFont(ofSize: 12))
        }else {
            carbonTabSwipeNavigation?.setNormalColor(.lightGray, font: UIFont.systemFont(ofSize: 13))
            carbonTabSwipeNavigation?.setSelectedColor(color, font: UIFont.boldSystemFont(ofSize: 13))
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + Double(0.5 * Double(1)) / Double(1), execute: { [self] in
            let parent = self.parent as? MainDetailsTableViewController
            parent?.childScrollView = (carbonTabSwipeNavigation?.viewControllers[0] as? NewsListVC)?.newsTableView
            //        [self.carbonTabSwipeNavigation.pagesScrollView setContentOffset:CGPointMake(0, 0)];
        })
        
    //
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

    }

    
     func carbonTabSwipeNavigation(_ carbonTabSwipeNavigation: CarbonTabSwipeNavigation, viewControllerAt index: UInt) -> UIViewController {
        switch index {
        case 0:
            // MY LISTS
            return listVC!
        case 1:
            // SAVED LISTS
            return savedListVC!
        case 2:
            // BUSINESS
            return viewController!
        case 3:
            // TIPS
            return tipsVC!
        case 4:
            // POINTS
            return pointsVC!
        case 5:
            // REWARDS
            return rewardsVC!
        default:
            break
        }
        
        return UIViewController()
    }
    
     func carbonTabSwipeNavigation(_ carbonTabSwipeNavigation: CarbonTabSwipeNavigation, didMoveAt index: UInt) {
        
        print("I'm on index \(Int(index))")
        let parent = self.parent as? MainDetailsTableViewController
        
        switch index {
        case 0:
            parent?.childScrollView = (carbonTabSwipeNavigation.viewControllers[0] as? NewsListVC)?.newsTableView
        case 1:
            parent?.childScrollView = (carbonTabSwipeNavigation.viewControllers[1] as? NewsListVC)?.newsTableView
        case 2:
            parent?.childScrollView = (carbonTabSwipeNavigation.viewControllers[2] as? NewsListVC)?.newsTableView
        case 3:
            parent?.childScrollView = (carbonTabSwipeNavigation.viewControllers[3] as? NewsListVC)?.newsTableView
        case 4:
            parent?.childScrollView = (carbonTabSwipeNavigation.viewControllers[4] as? NewsListVC)?.newsTableView
        case 5:
            parent?.childScrollView = (carbonTabSwipeNavigation.viewControllers[5] as? NewsListVC)?.newsTableView
        default:
            break
        }
        //
    }

    
    func carbonTabSwipeNavigation(_ carbonTabSwipeNavigation: CarbonTabSwipeNavigation, willMoveAt index: UInt) {
        
        print("I'm on index \(index)")
    }
}
