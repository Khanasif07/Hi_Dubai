//
//  ProfileHeaderPagerViewController.swift
//  Hi_Dubai
//
//  Created by Asif Khan on 02/06/2023.
//

import Foundation
import UIKit

@objc class ProfileHeaderPagerViewController: UIPageViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate{
    
    //    @objc var tabVC: BaseGeneralProfileTabViewController?
    //    @objc var gPVC: GeneralProfileViewController?
    //
    private var pages: [UIViewController]?
    private var page1: PresentationHeaderViewController?
    private var page2: UserInfoHeaderViewController?
    private var entered = false
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if pages == nil {
            pages = [UIViewController]()
        } else {
            return
        }
        page1 = PresentationHeaderViewController.instantiate(fromAppStoryboard: .Main)
        page2 = UserInfoHeaderViewController.instantiate(fromAppStoryboard: .Main)
        //
        self.delegate = self
        dataSource = self
        
        page1?.pagerVC = self
        
        pages?.append(page1!)
        pages?.append(page2!)
        
        setViewControllers([page1!], direction: .forward, animated: false)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if !entered {
            entered = true
            return
        }
        viewDidLoad()
//        page1!.refreshData()
//        page2!.refreshData()
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        var index = pages?.firstIndex(of: viewController) ?? NSNotFound
        
        if index == 0 {
            return nil
        }
        
        // Decrease the index by 1 to return
        index -= 1
        
        return pages?[index]
        
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        var index = pages?.firstIndex(of: viewController) ?? NSNotFound
        
        index += 1
        
        if index == 2 {
            return nil
        }
        
        return pages?[index]
    }
    
    func pageViewController(
        _ pageViewController: UIPageViewController,
        willTransitionTo pendingViewControllers: [UIViewController]
    ) {
        
        let pageContentView = pendingViewControllers[0]
        
        if let vc = pages?.firstIndex(of: pageContentView) {
            (parent as? MainDetailsTableViewController)?.pageControl.currentPage = vc
        }
        
        
    }
}
