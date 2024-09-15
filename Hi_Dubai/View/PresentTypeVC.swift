//
//  PresentTypeVC.swift
//  Hi_Dubai
//
//  Created by Asif Khan on 22/06/2023.
//

import UIKit

class PresentTypeVC: UIViewController {

    @IBOutlet weak var navBarr: UINavigationBar!
    @IBOutlet weak var gradientView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navBarr.items?.first?.title = "Youtube Music"
        let imageRef = UIImage.fit(with:  UIView(frame: CGRect(x: 0, y: 0, width: navigationController?.navigationBar.frame.size.width ?? view.frame.size.width, height:navigationController?.navigationBar.frame.size.height ?? 44)), imageName: "gradient_vertical")
        navBarr.backgroundColor = UIColor(patternImage:imageRef!)
        navBarr.barTintColor = UIColor(patternImage:imageRef!)
    }
    
    @IBAction func doneBtnAction(_ sender: UIBarButtonItem) {
        let vc = PresentTypeVC.instantiate(fromAppStoryboard: .Main)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func cancelBtnAction(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true)
    }

}
