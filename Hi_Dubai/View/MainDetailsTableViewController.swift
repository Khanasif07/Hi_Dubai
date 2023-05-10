//
//  MainDetailsTableViewController.swift
//  Hi_Dubai
//
//  Created by Asif Khan on 09/05/2023.
//

import UIKit
import Foundation
class MainDetailsTableViewController: BaseNestedScrollViewController {
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var tabContainer: UIView!
    @IBOutlet weak var tabContainerHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var tagsCollectionView: UICollectionView!
    @IBOutlet weak var  fakeNavBar: UIImageView!
    @IBOutlet weak var fakeNavBarHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var navBarTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var navBar: UINavigationBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var topPaddingRef: CGFloat = 20.0
        if #available(iOS 13.0, *) {
            let window = UIApplication.shared.windows.first
            if let topPadding = window?.safeAreaInsets.top{
                topPaddingRef = topPadding + 0.0
                navBarTopConstraint.constant = topPaddingRef
                fakeNavBarHeightConstraint.constant = topPaddingRef + 44.0 //44 is nav bar height
                fakeNavBar.layoutIfNeeded()
                
                navBar.layoutIfNeeded()

                super.navbar = navBar

            }
        }
        setUIObjectsScrollView(scrollView: scrollView, tabContainer: tabContainer, heightConstraint: tabContainerHeightConstraint, fakeNavBar: fakeNavBar, titleLabel: titleLabel)
        scrollView.isScrollEnabled = false

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        scrollView.isScrollEnabled = true
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}



