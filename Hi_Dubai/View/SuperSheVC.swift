//
//  SuperSheVC.swift
//  Hi_Dubai
//
//  Created by Asif Khan on 17/05/2023.
//

import UIKit
//import GoogleMaps
//import CoreLocation
//import Alamofire

fileprivate var currentSliderWidth: CGFloat = 0.0

class SuperSheVC: BaseVC ,VCConfigurator{
    

    enum ComingFromProfile {
        case otherUserProfile, userProfile
    }
    
    enum AvailableViews {
        case places,supershes
    }
    
    //MARK:- Variables-
//    typealias RequiredParams = (UserModel)
    var comingFrom: ComingFromProfile = .userProfile
    internal var isBottomSheetOpen: Bool = false
    private var placesView: PlacesAndSuperShesView?
    private var supershesView: PlacesAndSuperShesView?
    private var initialTouchPoint: CGPoint = CGPoint(x: 0,y: 0)
    private var lastContentOffsetX: CGFloat = 0.0
    internal var applySearch: Bool = false
//    private var clusterManager: GMUClusterManager!
    //    fileprivate var distance = [Int]()
    private var isStatusBarBlack = false
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return self.isStatusBarBlack ? .default : .lightContent
    }
    private var tabBarHeight: CGFloat {
        return self.tabBarController?.tabBar.frame.size.height ?? 0.0
    }
    private var maxAlpha: CGFloat {
        return 1.0
    }
    private var minAlpha: CGFloat {
        return 0.75
    }
    private var diffAlpha: CGFloat {
        return self.maxAlpha - self.minAlpha
    }
    internal var activeScreen: AvailableViews = .places
    //    private var isTabBarHidden: Bool = false
    
    //Map
    var comeBackFromOtherUserProfile : Bool = false
    //MARK:- IBOutlets-
    @IBOutlet weak var searchTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var backBtnOutlet: UIButton!
    @IBOutlet weak var placesAndSuperShesView: UIView!
    @IBOutlet weak var placesAndSuperShesViewBottomCons: NSLayoutConstraint!
    @IBOutlet weak var searchBarContainerTopCons: NSLayoutConstraint!
    @IBOutlet weak var buttonsContainerHeighttCons: NSLayoutConstraint!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var crossBtnOutlet: UIButton!
    @IBOutlet weak var buttonsScrollView: UIScrollView!
    @IBOutlet weak var mainScrollView: UIScrollView!
    @IBOutlet weak var openBottomSheetButtonOutlet: UIButton!
    @IBOutlet weak var placeButtonOutlet: UIButton!
    @IBOutlet weak var superSheButtonOutlet: UIButton!
    @IBOutlet weak var textFieldCancelButton: UIButton!
    @IBOutlet weak var sliderView: UIView!
    @IBOutlet weak var sliderViewWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var sliderViewLeadingConstraint: NSLayoutConstraint!
    //Map
    @IBOutlet weak var behindBlurView: UIView!
    @IBOutlet weak var behindBlurViewHeigthCons: NSLayoutConstraint!
    @IBOutlet weak var behindBlurViewTopCons: NSLayoutConstraint!
//    @IBOutlet weak var mapView: GMSMapView!
    @IBOutlet weak var mapViewBottomCons: NSLayoutConstraint!
    @IBOutlet weak var superSheLogoImageView: UIImageView!
    
    
    //MARK:- LifeCycle-
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
//        locationAccessGranted()
        
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    override func initialSetup() {
        super.initialSetup()
//        self.mapView.clear()
        self.isStatusBarBlack = true
        self.setNeedsStatusBarAppearanceUpdate()
//        self.viewModel.delegate = self
        self.behindBlurView.isHidden = true
        self.behindBlurViewHeigthCons.constant = 46 + UIDevice.topSafeArea
        self.searchTextField.attributedPlaceholder = NSAttributedString(string: "Search for SuperShes, Places...", attributes: [NSAttributedString.Key.font: AppFonts.BoldItalic.withSize(17.0),.foregroundColor: AppColors.black])
        self.searchTextField.font = AppFonts.BoldItalic.withSize(17.0)
        self.searchTextField.textColor = AppColors.black
        self.searchTextField.delegate = self
        self.closeBottomSheet(withAnimation: false)
        self.mainScrollViewSetUp()
        self.sliderViewWidthConstraint.constant = self.buttonTitleWidth(button: self.placeButtonOutlet, btnName: "PLACES")
        self.placeButtonOutlet.alpha = self.maxAlpha
        self.superSheButtonOutlet.alpha = self.minAlpha
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(self.panGestureRecognizerHandler(_:)))
        self.placesAndSuperShesView.addGestureRecognizer(panGesture)
        self.view.layoutIfNeeded()
        if self.comingFrom == .otherUserProfile {
            self.backBtnOutlet.isHidden = false
            self.mapViewBottomCons.constant =  (68 +  UIDevice.bottomSafeArea)

            let bkgView = UIView.init(frame: CGRect(x: 0, y: 0, width: 125, height: 125))
            bkgView.backgroundColor = .clear
        } else {
            self.backBtnOutlet.isHidden = false
            self.mapViewBottomCons.constant =  (68 + UIDevice.bottomSafeArea)// + self.tabBarHeight)
            self.placesAndSuperShesViewBottomCons.constant = -(screen_height - 62.0) + 68.0 + (UIDevice.bottomSafeArea)
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.placesAndSuperShesView.roundCorners([.topLeft,.topRight], radius: 15.0)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
        self.isStatusBarBlack = true
        self.setNeedsStatusBarAppearanceUpdate()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if currentSliderWidth > 0.0 {
            self.sliderViewWidthConstraint.constant = currentSliderWidth
        } else {
            self.sliderViewWidthConstraint.constant = self.buttonTitleWidth(button: self.placeButtonOutlet, btnName:  self.activeScreen == .places ? "PLACES" : "SUPERSHES")
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.view.endEditing(true)
        self.navigationController?.navigationBar.isHidden = false
        //        NotificationCenter.default.removeObserver(self, name: .onOtherUserBack, object: nil)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.sliderViewWidthConstraint.constant = self.buttonTitleWidth(button: self.placeButtonOutlet, btnName:  self.activeScreen == .places ? "PLACES" : "SUPERSHES")
        self.isStatusBarBlack = false
        self.setNeedsStatusBarAppearanceUpdate()
        if self.isBottomSheetOpen {
            //            self.closeBottomSheet(withAnimation: false)
        }
        comeBackFromOtherUserProfile = false
        
    }
    
    
    private func locationAccessGranted() {
    }
    
    
    override func setupLayout() {
        super.setupLayout()
        self.placesView?.frame = CGRect(x: 0.0, y: 0.0, width: screen_width, height: self.mainScrollView.height)
        self.supershesView?.frame = CGRect(x: screen_width, y: 0.0, width: screen_width, height: self.mainScrollView.height)
    }
    
    //MARK:- Functions-
 
    ///Main scrollview setups
    private func mainScrollViewSetUp() {
        self.mainScrollView.delegate = self
        self.mainScrollView.contentSize = CGSize(width: (self.mainScrollView.width * 2.0), height: 0.0)
        
        self.placesView = PlacesAndSuperShesView(frame: CGRect(x: 0.0, y: 0.0, width: screen_width, height: self.mainScrollView.bounds.height))
        
        if let placeView = self.placesView {
            placeView.screenUsingFor = .places
            placeView.isScrollEnabled = true
            placeView.deleagte = self
            self.mainScrollView.addSubview(placeView)
        }
        
        self.supershesView = PlacesAndSuperShesView(frame: CGRect(x: screen_width, y: 0.0, width: screen_width, height: self.mainScrollView.bounds.height))
        
        if let superSheView = self.supershesView {
            superSheView.screenUsingFor = .supershes
            superSheView.isScrollEnabled = true
            superSheView.deleagte = self
            self.mainScrollView.addSubview(superSheView)
        }
    }
    
    ///Call to open Bottom sheet
    internal func openBottomSheet(withAnimation: Bool = true, duration: TimeInterval = 0.5, openFor: AvailableViews = .places, applySearch: Bool = true) {
        
        self.isStatusBarBlack = false
        if openFor == .supershes {
            self.searchTextField.resignFirstResponder()
            self.sliderViewWidthConstraint.constant = self.buttonTitleWidth(button: self.placeButtonOutlet, btnName: "SUPERSHES")
            self.superSheButtonAction(self.superSheButtonOutlet)
        }
        
        if withAnimation {
            UIView.animate(withDuration: duration, animations: { [weak self] in
                self?.buttonsContainerHeighttCons.constant = 44.0
                self?.placesAndSuperShesViewBottomCons.constant = 0.0
//                self?.tabBarController?.tabBar.frame.origin.y = screen_height
                self?.setNeedsStatusBarAppearanceUpdate()
                self?.view.layoutIfNeeded()
            }) { [weak self] (true) in
                guard let sSelf = self else { return }
                sSelf.superSheLogoImageView.isHidden = true
                sSelf.behindBlurView.isHidden = false
                sSelf.textFieldAnimation(applySearch: applySearch, openFor: openFor)
                sSelf.supershesView?.currentShimmerStatus = .toBeApply
//                sSelf.supershesView?.hitApi(text: "", page: 0)
                //                sSelf.isTabBarHidden = true
            }
        } else {
            self.buttonsContainerHeighttCons.constant = 44.0
            self.placesAndSuperShesViewBottomCons.constant = 0.0
//            self.tabBarController?.tabBar.frame.origin.y = screen_height
            self.superSheLogoImageView.isHidden = true
            self.behindBlurView.isHidden = false
            self.textFieldAnimation(applySearch: applySearch, openFor: openFor)
        }
        self.isBottomSheetOpen = true
        self.openBottomSheetButtonOutlet.isHidden = true
        if self.activeScreen == .places {
//            self.placesView?.emptyStateForPlaces()
        }
    }
    
    ///Call to close Bottom sheet
    internal func closeBottomSheet(withAnimation: Bool = true, duration: TimeInterval = 0.5) {
        self.searchTextField.text = ""
        self.searchTextField.resignFirstResponder()
        self.textFieldCancelButton.isHidden = true
        self.isStatusBarBlack = true
        
        if withAnimation {
            UIView.animate(withDuration: duration, animations: { [weak self] in
                self?.buttonsContainerHeighttCons.constant = 0.0
                
                if self?.comingFrom == .otherUserProfile {
                    self?.placesAndSuperShesViewBottomCons.constant = -(screen_height - 62.0) + 68.0 + UIDevice.bottomSafeArea
                } else {
                    self?.placesAndSuperShesViewBottomCons.constant = -(screen_height - 62.0) + 68.0 + (UIDevice.bottomSafeArea)
                }
//                self?.tabBarController?.tabBar.frame.origin.y = screen_height - (self?.tabBarHeight ?? 0.0)
                self?.setNeedsStatusBarAppearanceUpdate()
                self?.view.layoutIfNeeded()
            }) { [weak self] (true) in
                guard let sSelf = self else { return }
                if self?.comingFrom == .otherUserProfile {
                    sSelf.behindBlurView.isHidden = false
                } else {
                    sSelf.behindBlurView.isHidden = true
                }
                
                sSelf.superSheLogoImageView.isHidden = false
//                self?.tabBarController?.tabBar.frame.origin.y = screen_height - (self?.tabBarHeight ?? 0.0)
                //                sSelf.isTabBarHidden = true
                sSelf.view.layoutIfNeeded()
            }
        } else {
            self.buttonsContainerHeighttCons.constant = 0.0
            if self.comingFrom == .otherUserProfile {
                self.placesAndSuperShesViewBottomCons.constant = -(screen_height - 62.0) + 68.0 + UIDevice.bottomSafeArea
            } else {
                self.placesAndSuperShesViewBottomCons.constant = -(screen_height - 62.0 - 44.0) + (68.0) + UIDevice.bottomSafeArea
                
            }
//            self.tabBarController?.tabBar.frame.origin.y = screen_height - self.tabBarHeight
            self.setNeedsStatusBarAppearanceUpdate()
            self.view.layoutIfNeeded()
            if self.comingFrom == .otherUserProfile {
                self.behindBlurView.isHidden = false
            } else {
                self.behindBlurView.isHidden = true
            }
            self.superSheLogoImageView.isHidden = false
        }
        self.isBottomSheetOpen = false
        self.openBottomSheetButtonOutlet.isHidden = false
    }
    
    ///Call to animate Textfield with apply search boolean
    internal func textFieldAnimation(applySearch: Bool = true,openFor : AvailableViews = .places) {
        if !applySearch {
            if openFor == .supershes {
                self.searchTextField.resignFirstResponder()
            }
        }
        
        UIView.animate(withDuration: 0.33, animations: { [weak self] in
            self?.textFieldCancelButton.isHidden = !applySearch
            self?.view.layoutIfNeeded()
            
        }) { [weak self] (true) in
            guard let sSelf = self else { return }
            
            if applySearch {
                if openFor == .supershes {
                    sSelf.searchTextField.resignFirstResponder()
                } else {
                    sSelf.searchTextField.becomeFirstResponder()
                }
                
            }
            else {
                if sSelf.activeScreen == .places {
                } else {
                }
            }
            sSelf.view.layoutIfNeeded()
        }
        self.applySearch = applySearch
    }
    
    ///Call to get any title wdth
    private func buttonWidth(title: String) -> CGFloat{
        return title.sizeCount(withFont: AppFonts.BoldItalic.withSize(17.0), boundingSize: CGSize(width: 10000.0, height: 32.0)).width
    }
    
    ///Call to get button title wdth
    private func buttonTitleWidth(button: UIButton, btnName: String) -> CGFloat {
        if button.titleLabel?.frame.width ?? 0.0 > CGFloat(0.0) {
            return button.titleLabel?.frame.width ?? self.buttonWidth(title: btnName)
        }
        return self.buttonWidth(title: btnName)
    }
    
    ///Call to scroll place view
    private func scrollToPlaceView() {
        self.searchTextField.resignFirstResponder()
        let btnWidth = self.buttonTitleWidth(button: self.placeButtonOutlet, btnName: "PLACES")
        currentSliderWidth = btnWidth
        UIView.animate(withDuration: 0.25, animations: { [weak self] in
            self?.sliderViewWidthConstraint.constant = btnWidth
            self?.sliderViewLeadingConstraint.constant = self?.placeButtonOutlet.frame.origin.x ?? 0.0
            self?.placeButtonOutlet.alpha = self?.maxAlpha ?? 1.0
            self?.superSheButtonOutlet.alpha = self?.minAlpha ?? 0.75
            //            self?.placesView?.dataTableView.reloadData()
            self?.view.layoutIfNeeded()
        }) { [weak self] (true) in
            self?.activeScreen = .places
            self?.placesView?.dataTableView.reloadData()
            if self?.applySearch ?? false {
                self?.textFieldAnimation(applySearch: false,openFor: .places)
            }
        }
    }
    
    ///Call to scroll supershe view
    private func scrollToSuperSheView() {
        self.searchTextField.resignFirstResponder()
        let btnWidth = self.buttonTitleWidth(button: self.superSheButtonOutlet, btnName: "SUPERSHES")//(self.buttonWidth(title: "SUPERSHES") - 8.0)
        currentSliderWidth = btnWidth
        UIView.animate(withDuration: 0.25, animations: { [weak self] in
            self?.sliderViewWidthConstraint.constant = btnWidth
            self?.sliderViewLeadingConstraint.constant = self?.superSheButtonOutlet.frame.origin.x ?? 71.0
            self?.placeButtonOutlet.alpha = self?.minAlpha ?? 0.75
            self?.superSheButtonOutlet.alpha = self?.maxAlpha ?? 1.0
            self?.view.layoutIfNeeded()
        }) { [weak self] (true) in
            self?.activeScreen = .supershes
            self?.supershesView?.dataTableView.reloadData()
            if self?.applySearch ?? false {
                self?.textFieldAnimation(applySearch: false,openFor: .supershes)
            }
        }
    }
    
    ///Call to use Pan Gesture Final Animation
    private func panGestureFinalAnimation(velocity: CGPoint,touchPoint: CGPoint) {
        //Down Direction
        if velocity.y < 0 {
            if velocity.y < -300 {
                self.openBottomSheet(applySearch: false)
            } else {
                if touchPoint.y <= (screen_height - 62.0)/2 {
                    self.openBottomSheet(applySearch: false)
                } else {
                    self.behindBlurView.isHidden = true
                    self.closeBottomSheet()
                }
            }
        }
            //Up Direction
        else {
            if velocity.y > 300 {
                self.behindBlurView.isHidden = true
                self.closeBottomSheet()
            } else {
                if touchPoint.y <= (screen_height - 62.0)/2 {
                    self.openBottomSheet()
                } else {
                    self.closeBottomSheet()
                }
            }
        }
        print(velocity.y)
        return
    }

    @objc func onOtherUserProficeBack() {
        comeBackFromOtherUserProfile = true
    }
    
    //MARK:- IBActions-
    @IBAction func crossButtonAction(_ sender: UIButton) {
        self.view.endEditing(true)
        if self.isBottomSheetOpen {
            self.isBottomSheetOpen = false
            self.searchTextField.resignFirstResponder()
            self.behindBlurView.isHidden = true
            self.closeBottomSheet()
        }
    }
    
    @IBAction func BackBtnTapped(_ sender: UIButton) {
//        Router.shared.navigate(action: .pop)
        self.pop()
    }
    
    @IBAction func openBottomSheetButtonAction(_ sender: UIButton) {
        if !self.isBottomSheetOpen {
            self.buttonsScrollView.isHidden = false
            self.openBottomSheet(openFor: self.activeScreen)
        }
    }
    
    @IBAction func placeButtonAction(_ sender: UIButton) {
        self.searchTextField.text = ""
        self.activeScreen = .places
        self.mainScrollView.contentOffset.x = 0.0
        self.scrollToPlaceView()
    }
    
    @IBAction func superSheButtonAction(_ sender: UIButton) {
        self.searchTextField.text = ""
        self.activeScreen = .supershes
        self.mainScrollView.contentOffset.x = screen_width
        self.scrollToSuperSheView()
    }
    
    @IBAction func textFieldCancelBtnAction(_ sender: UIButton) {
        self.searchTextField.text = ""
        self.textFieldAnimation(applySearch: false)
//        self.supershesView?.clearSuperSheViewData()
//        self.placesView?.clearPlaceViewData()
//        self.supershesView?.getData(text: "", page: 0)
        self.supershesView?.dataTableView.reloadData()
    }
    
    @IBAction func panGestureRecognizerHandler(_ sender: UIPanGestureRecognizer) {
        
        self.searchTextField.resignFirstResponder()
        let touchPoint = sender.location(in: self.placesAndSuperShesView?.window)
        let velocity = sender.velocity(in:  self.placesAndSuperShesView)
        
        switch sender.state {
        case .possible:
            print(sender.state)
        case .began:
            self.initialTouchPoint = touchPoint
        case .changed:
            let touchPointDiffY = initialTouchPoint.y - touchPoint.y
            print(touchPointDiffY)
            if  touchPoint.y > 62.0 {
                if touchPointDiffY > 0, !isBottomSheetOpen {
                    self.placesAndSuperShesViewBottomCons.constant = -(screen_height - 62.0) + (68.0) + (UIDevice.bottomSafeArea) + touchPointDiffY
//                    self.tabBarController?.tabBar.frame.origin.y += touchPointDiffY/10.0
                }
                else if touchPointDiffY < -68.0, isBottomSheetOpen {
                    print("touchPoint.y -> \(touchPoint.y) and (screenHeight - 62.0) + (68.0) -> \((screen_height - 62.0) + (68.0))")
                    if touchPoint.y >= (screen_height - 62.0) - (UIDevice.bottomSafeArea) - (68.0) {
                        print(touchPoint)
                        self.panGestureFinalAnimation(velocity: velocity,touchPoint: touchPoint)
                        sender.state = .ended
                        return
                    }
                    self.behindBlurView.isHidden = true
                    self.placesAndSuperShesViewBottomCons.constant = touchPointDiffY
//                    if touchPoint.y > screen_height - self.tabBarHeight {
//                        self.tabBarController?.tabBar.frame.origin.y -= touchPointDiffY/10.0
//                    }
                }
            }
        case .ended:
            self.panGestureFinalAnimation(velocity: velocity,touchPoint: touchPoint)
        case .cancelled:
            self.panGestureFinalAnimation(velocity: velocity,touchPoint: touchPoint)
        case .failed:
            print(sender.state)
        }
        
    }
    

}

//MARK:- UITextFieldDelegate-
extension SuperSheVC: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = (textField.text as NSString?)?.replacingCharacters(in: range, with: string) else { return false }
        if !text.isEmpty, !self.applySearch  {
            self.textFieldAnimation(applySearch: true)
        }
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return self.isBottomSheetOpen
    }
}

//MARK:- UIScrollViewDelegate-
extension SuperSheVC {
    
   override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        guard scrollView === self.mainScrollView else { return }
        if (scrollView.contentOffset.x - lastContentOffsetX) > 0 {
            if lastContentOffsetX > 0.0, lastContentOffsetX < screen_width * 0.75 {
                self.sliderViewLeadingConstraint.constant = (scrollView.contentOffset.x/screen_width)*71
                self.placeButtonOutlet.alpha = self.maxAlpha - (scrollView.contentOffset.x/screen_width)*self.diffAlpha
                self.superSheButtonOutlet.alpha = self.minAlpha + scrollView.contentOffset.x/screen_width*self.diffAlpha
                
            }
            else if lastContentOffsetX > screen_width * 0.75 {
                self.scrollToSuperSheView()
            }
        } else {
            if lastContentOffsetX < screen_width * 0.25 {
                self.scrollToPlaceView()
            } else if lastContentOffsetX < screen_width {
                self.sliderViewLeadingConstraint.constant = (scrollView.contentOffset.x/screen_width)*71
                
                self.superSheButtonOutlet.alpha = self.maxAlpha - ((screen_width-scrollView.contentOffset.x)/screen_width)*self.diffAlpha
                self.placeButtonOutlet.alpha = self.minAlpha + (screen_width-scrollView.contentOffset.x)/screen_width*self.diffAlpha
                
            }
        }
        self.lastContentOffsetX = scrollView.contentOffset.x
        self.view.layoutIfNeeded()
    }
    
}

//MARK:- PlacesAndSuperShesViewDelegate-
extension SuperSheVC: PlacesAndSuperShesViewDelegate {
    func closeTextFieldAnimation() {
        if applySearch {
            self.textFieldAnimation(applySearch: false)
        }
    }
}
