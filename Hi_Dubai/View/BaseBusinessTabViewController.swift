//
//  BaseBusinessTabViewController.swift
//  Hi_Dubai
//
//  Created by Asif Khan on 09/05/2023.
//

import UIKit
import CarbonKit
var tabVC1: NewsListVC?
var tabVC2: NewsListVC?
var tabVC3: NewsListVC?
var tabVC4: NewsListVC?

class BaseBusinessTabViewController: UIViewController,CarbonTabSwipeNavigationDelegate {
    @IBOutlet private weak var toolBar: UIToolbar!
    @IBOutlet private weak var targetView: UIView!
    var tabs = [String]()
    private var tabSwipe: CarbonTabSwipeNavigation = CarbonTabSwipeNavigation()
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
        // Do any additional setup after loading the view.
    }
    
    func initUI(){
        tabs = [
            "INFO",
            "REVIEWS",
            "DEALS",
            "CONTACTS"
        ]
        tabVC1 = NewsListVC.instantiate(fromAppStoryboard: .Main)
        tabVC2 = NewsListVC.instantiate(fromAppStoryboard: .Main)
        tabVC3 = NewsListVC.instantiate(fromAppStoryboard: .Main)
        tabVC4 = NewsListVC.instantiate(fromAppStoryboard: .Main)
        tabSwipe = CarbonTabSwipeNavigation(items: tabs, toolBar: toolBar, delegate: self)
        tabSwipe.toolbar.isTranslucent = false
        tabSwipe.setTabExtraWidth(30)
        tabSwipe.setIndicatorHeight(5)
        tabSwipe.delegate = self
        tabSwipe.insert(intoRootViewController: self,andTargetView: targetView)
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.barTintColor = UIColor.blue
        navigationController?.navigationBar.barStyle = .blackTranslucent
        
        DispatchQueue.main.asyncAfter(deadline:  .now() + 1, execute: {
            [weak self] in
            let parent = self?.parent as? MainDetailsTableViewController
            parent?.childScrollView = (self?.tabSwipe.viewControllers[0] as? NewsListVC)?.newsTableView
        })
    }
    
    func carbonTabSwipeNavigation(_ carbonTabSwipeNavigation: CarbonTabSwipeNavigation, viewControllerAt index: UInt) -> UIViewController {
        switch index {
        case 0:
            return tabVC1 ?? UIViewController();
        case 1:
            return tabVC2 ?? UIViewController();
        case 2:
            return tabVC3 ?? UIViewController();
        case 3:
            return tabVC4 ?? UIViewController();
        default:
            break
        }
        
        return UIViewController()
    }
    
    func carbonTabSwipeNavigation(_ carbonTabSwipeNavigation: CarbonTabSwipeNavigation, didMoveAt index: UInt) {
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
        default:
            break
        }
        //
    }



}
