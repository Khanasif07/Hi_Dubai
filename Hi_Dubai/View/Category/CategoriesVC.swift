//
//  CategoriesVC.swift
//  Hi_Dubai
//
//  Created by Asif Khan on 26/06/2023.
//

import UIKit
class CategoriesVC: UIViewController {
    
    //
    var searchTask: DispatchWorkItem?
    internal var placesView: PlacesAndSuperShesView?
    @IBOutlet weak var containerView: UIView!
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Categories"
        initUI()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.placesView?.frame = CGRect(x: 0.0, y: 0.0, width: screen_width, height: containerView.height)
    }
    
    
    @IBAction func backBtnAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    
}

extension CategoriesVC: UIGestureRecognizerDelegate{
    func initUI(){
        self.view.backgroundColor = .black
        self.containerView.backgroundColor = .lightGray
        self.placesView = PlacesAndSuperShesView(frame: CGRect(x: 0.0, y: 0.0, width: screen_width, height: containerView.height))
        self.placesView?.isScrollEnabled = true
        self.placesView?.screenUsingFor = .categories
        if let placeView = self.placesView {
            self.containerView.addSubview(placeView)
        }
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
}
