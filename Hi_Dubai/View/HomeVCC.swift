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
        setNavigationBarHidden = true
        // Do any additional setup after loading the view.
        
        let childView = UIHostingController(rootView: VideoListView())
        addChild(childView)
        childView.view.frame = containerView.bounds
        containerView.addSubview(childView.view)
        childView.didMove(toParent: self)
    }
    
    
}
