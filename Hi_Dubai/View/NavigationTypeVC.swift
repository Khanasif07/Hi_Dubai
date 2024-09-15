//
//  NavigationTypeVC.swift
//  Hi_Dubai
//
//  Created by Asif Khan on 18/06/2023.
//

import UIKit

class NavigationTypeVC: UIViewController {
    
    //
    @IBOutlet weak var cancelBtn: UIButton!
    @IBOutlet weak var searchTxtFld: NewSearchTextField!
    @IBOutlet weak var containerView: UIView!
    //
    var emptyViewPersonal: EmptyView?
    var searchTask: DispatchWorkItem?

    override func viewDidLoad() {
        super.viewDidLoad()
        searchTxtFld.delegate = self
        searchTxtFld.setPlaceholder(placeholder: "Find Malls, Shops, Hotels...")
        cancelBtn.isHidden = true
        initUI()
        //type1()
        //type2()
        //type3()
        //type4()
        //type5()
        //type6()
    }
    //Change “barTintColor”, “tintColor”
    private func type1(){
        self.navigationItem.title = "Type1"
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.barTintColor = .cyan
        self.navigationController?.navigationBar.tintColor = .brown
    }
    //Set setBackgroundImage, shadowImage
    private func type2(){
        self.navigationItem.title = "Type2"
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(named: "Banner2"), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage(named: "Banner")
    }
    //Set Title and customize title color
    private func type3(){
        self.navigationItem.title = "Type3"
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.red]
        self.navigationController?.navigationBar.titleTextAttributes = textAttributes
    }
    //Set an image as navbar title
    private func type4(){
        self.navigationItem.title = "Type4"
        let logo = UIImage(named: "HiDubai_Logo")
        let imageView = UIImageView(image:logo)
        self.navigationItem.titleView = imageView
    }
    //Clear your navbar background
    private func type5(){
        self.navigationItem.title = "Type5"
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
    }
    //Customize the back button. Remove the title of the back button and set the color.
    private func type6(){
        self.navigationItem.title = "Type6"
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "Type6", style: .plain, target: nil, action: nil)
        self.navigationItem.backBarButtonItem?.tintColor = UIColor.blue
    }
    
    @IBAction func cancelBtnAction(_ sender: UIButton) {
        self.cancelBtn.isHidden = true
        closeSearchingArea(true)
        self.view.endEditing(true)
    }
    
    @IBAction func backBtnAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    
}

extension NavigationTypeVC: UIGestureRecognizerDelegate{
    func initUI(){
        let secondChildVC = RecentSearchVC.instantiate(fromAppStoryboard: .Main)
        secondChildVC.screenUsingFor = .searchMovie
        if children.count == 0 {
            secondChildVC.view.frame = containerView.bounds
            containerView?.addSubview(secondChildVC.view)
            addChild(secondChildVC)
        }
    }
    
    func showEmptyView(){
        // Custom way to add view
        if emptyViewPersonal == nil{
            emptyViewPersonal?.removeFromSuperview()
            emptyViewPersonal = EmptyView(frame: CGRect(x: 0, y: 0, width: self.containerView.frame.width, height: self.containerView.frame.height), inView: self.containerView, centered: true, icon: UIImage(named: ""), message: "")
            emptyViewPersonal?.loginBtn.isHidden = true
            emptyViewPersonal?.learnHow.isHidden = true
            emptyViewPersonal?.text.text = "Sorry, We could not find any results"
            emptyViewPersonal?.whiteContainer.backgroundColor = .clear
            emptyViewPersonal?.show()
        }else{
            emptyViewPersonal?.removeFromSuperview()
            emptyViewPersonal = EmptyView(frame: CGRect(x: 0, y: 0, width: self.containerView.frame.width, height: self.containerView.frame.height), inView: self.containerView, centered: true, icon: UIImage(named: ""), message: "")
            emptyViewPersonal?.loginBtn.isHidden = true
            emptyViewPersonal?.learnHow.isHidden = true
            emptyViewPersonal?.text.text = "Sorry, We could not find any results"
            emptyViewPersonal?.whiteContainer.backgroundColor = .clear
            emptyViewPersonal?.show()
        }
    }
    
    func hideEmptyView(){
        emptyViewPersonal?.hide()
        emptyViewPersonal?.removeFromSuperview()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
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
extension NavigationTypeVC: WalifSearchTextFieldDelegate{
    func walifSearchTextFieldBeginEditing(sender: UITextField!) {
        self.cancelBtn.isHidden = false
        closeSearchingArea(false)
    }
    
    func walifSearchTextFieldEndEditing(sender: UITextField!) {
        closeSearchingArea(false)
    }
    
    func walifSearchTextFieldChanged(sender: UITextField!) {
        let searchValue = sender.text ?? ""
        self.searchTask?.cancel()
        let task = DispatchWorkItem { [weak self] in
            guard let `self` = self else { return }
            if let recentSearchVC = self.children.first as? RecentSearchVC{
                recentSearchVC.placesView?.searchValue = searchValue
                recentSearchVC.placesView?.hitApi()
            }
        }
        self.searchTask = task
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.75, execute: task)
    }
    
    func walifSearchTextFieldIconPressed(sender: UITextField!) {
        closeSearchingArea(true)
        self.searchTask?.cancel()
        let task = DispatchWorkItem { [weak self] in
            guard let `self` = self else { return }
            if let recentSearchVC = self.children.first as? RecentSearchVC{
                recentSearchVC.placesView?.searchValue = ""
                recentSearchVC.placesView?.hitApi()
            }
        }
        self.searchTask = task
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.75, execute: task)
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
