//
//  HomeVCC.swift
//  Hi_Dubai
//
//  Created by Asif Khan on 29/05/2023.
//

import UIKit
import SwiftUI
class HomeVCC: BaseVC {
    
    @IBOutlet weak var containerView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.prefersLargeTitles = false
        setNavigationBarHidden = true
        // Do any additional setup after loading the view.
        
        let childView = UIHostingController(rootView: VideoListView())
        addChild(childView)
        childView.view.frame = self.view.bounds
        containerView.addSubview(childView.view)
        childView.didMove(toParent: self)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
//        setNavigationBarHidden = false
//        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        setNavigationBarHidden = false
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    
}
