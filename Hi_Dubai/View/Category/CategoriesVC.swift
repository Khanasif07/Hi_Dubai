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
    
    @IBOutlet weak var searchTxtFld: NewSearchTextField!
    @IBOutlet weak var containerView: UIView!
    //

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        searchTxtFld.delegate = self
        searchTxtFld.setPlaceholder(placeholder: "Find Malls, Shops, Hotels...")
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


// MARK: - WalifSearchTextFieldDelegate
extension CategoriesVC: WalifSearchTextFieldDelegate{
    func walifSearchTextFieldBeginEditing(sender: UITextField!) {
        closeSearchingArea(false)
    }
    
    func walifSearchTextFieldEndEditing(sender: UITextField!) {
        closeSearchingArea(false)
    }
    
    func walifSearchTextFieldChanged(sender: UITextField!) {
        let searchValue = sender.text ?? ""
        self.searchTask?.cancel()
//        let task = DispatchWorkItem { [weak self] in
//            guard let `self` = self else { return }
//            if let recentSearchVC = self.children.first as? RecentSearchVC{
//                recentSearchVC.placesView?.searchValue = searchValue
//                recentSearchVC.placesView?.hitApi()
//            }
//        }
//        self.searchTask = task
//        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.75, execute: task)
    }
    
    func walifSearchTextFieldIconPressed(sender: UITextField!) {
        closeSearchingArea(true)
        self.searchTask?.cancel()
//        let task = DispatchWorkItem { [weak self] in
//            guard let `self` = self else { return }
//            if let recentSearchVC = self.children.first as? RecentSearchVC{
//                recentSearchVC.placesView?.searchValue = ""
//                recentSearchVC.placesView?.hitApi()
//            }
//        }
//        self.searchTask = task
//        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.75, execute: task)
    }
    
    func closeSearchingArea(_ isTrue: Bool) {
        UIView.animate(withDuration: 0.4, delay: 0.1,options: .curveEaseInOut) {
            self.searchTxtFld.crossBtnWidthConstant.constant = isTrue ? 0.0 : 50.0
            self.view.layoutIfNeeded()
        } completion: { value in
            self.searchTxtFld.cancelBtn.isHidden = isTrue
            self.view.layoutIfNeeded()
        }
    }
    
}
