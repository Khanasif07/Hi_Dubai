//
//  LightStatusBarViewController.swift
//  Hi_Dubai
//
//  Created by Asif Khan on 12/05/2023.
//

import Foundation
import UIKit
class LightStatusBarViewController: BaseViewController {
    
    override func viewDidLoad() {
//        dispatch_async(dispatch_get_main_queue(){
            super.viewDidLoad()
            self.setNeedsStatusBarAppearanceUpdate()
//        }
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .lightContent
    }
    
    func viewWillAppear(animated:Bool) {
        super.viewWillAppear(animated)
        self.setupNavBar()
    }
    
    override func setupNavBar() {
        self.navigationController?.navigationBar.barStyle = .blackTranslucent
    }
}
