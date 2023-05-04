//
//  ExploreVC.swift
//  Hi_Dubai
//
//  Created by Asif Khan on 02/05/2023.
//

import UIKit
class ExploreVC: BaseVC {

    @IBOutlet var realTabBar2: UIView!
    @IBOutlet weak var fakeTabBar2: UIView!
    @IBOutlet var realTabBar1: UIView!
    @IBOutlet weak var fakeTabBar1: UIView!
    @IBOutlet weak var mainScrollView: UIScrollView!
    override func viewDidLoad() {
        super.viewDidLoad()
        mainScrollView.delegate = self
        realTabBar1.frame = CGRect(x: 0, y: fakeTabBar1.frame.origin.y + mainScrollView.frame.origin.y, width: view.frame.size.width, height: fakeTabBar1.frame.size.height)

        let yValue = (self.fakeTabBar2.frame.origin.y) + (self.mainScrollView.frame.origin.y) + 44.0
        realTabBar2.frame = CGRect(x: 0.0, y: yValue, width: fakeTabBar2.frame.size.width, height: fakeTabBar2.frame.size.height)

        print("realTabBar1 frame =\(fakeTabBar1.frame)")
        view.addSubview(realTabBar1)

        // Do any additional setup after loading the view.
    }

}

