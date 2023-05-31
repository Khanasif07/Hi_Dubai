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
    private var newLocation: String?
    private var currentLocation: String?
//    private var userModel: UserModel?
    private var dataLoadedFromCluster: Bool = false
    var comingFrom: ComingFromProfile = .userProfile
    private var isMaptap: Bool = true
    private var isZoomLevelMax: Bool = false
    private var userCount:Int? = 0

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

    private var isSettingNewLoc: Bool = false
    var clearMap: Bool = true
    private var isDistanceFromFlg: Bool = false
    private var deviceLocationDetail: String = ""
    var comeBackFromOtherUserProfile : Bool = false
    var isCameFromSearchPlace: Bool = true
    
    
    
    //MARK:- IBOutlets-
    
    @IBOutlet weak var setNewLocBtnBtmCons: NSLayoutConstraint!
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
    @IBOutlet weak var setNewLocationBtnOutlet: AppButton!
    @IBOutlet weak var setNewLocationBtnWidthCons: NSLayoutConstraint!
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
        self.newLocationBtnSetUp()
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(self.panGestureRecognizerHandler(_:)))
        self.placesAndSuperShesView.addGestureRecognizer(panGesture)
        self.view.layoutIfNeeded()
//        self.mapView.settings.myLocationButton = true
//        self.mapView.isMyLocationEnabled = true
//        self.mapView.delegate = self
        
        
        if self.comingFrom == .otherUserProfile {
            self.dataLoadedFromCluster = true
            self.isZoomLevelMax = true
            if self.userCount == 0 {self.userCount = -1}
//            self.kCameraLatitude = userModel?.lat ?? 0.0
//            self.kCameraLongitude = userModel?.lng ?? 0.0
            self.backBtnOutlet.isHidden = false
            self.mapViewBottomCons.constant =  (68 +  UIDevice.bottomSafeArea)
//            let markerView = MarkerIcon(frame: CGRect(x: 0, y: 0, width: 125, height: 125))
//            markerView.mainImgView.setImage(imageString: self.userModel?.profilePicture ?? "", localUri: "", placeHolderImage: nil, imageQuality: .low, isLambdaEnable : false, backgroundColor: UIColor.darkGray)
//            markerView.mainImgView.contentMode = .scaleAspectFill
//            markerView.mainImgView.layer.backgroundColor = UIColor.clear.cgColor
//            markerView.makeCircular(borderWidth: 0, borderColor: .white)
//            markerView.mainImgView.makeCircular(borderWidth: 2, borderColor: .white)
//            self.behindBlurView.addGradient(colors: AppColors.lightGray)
            let bkgView = UIView.init(frame: CGRect(x: 0, y: 0, width: 125, height: 125))
            bkgView.backgroundColor = .clear
//            markerView.insertSubview(bkgView, at: 0)
//            let pulse1 = LFTPulseAnimation(repeatCount: Float.infinity, radius:125, position: markerView.center)
//            bkgView.layer.insertSublayer(pulse1, below: markerView.layer)
//            let gmssMarker = GMSMarker(position: CLLocationCoordinate2D(latitude: kCameraLatitude, longitude: kCameraLongitude))
//            self.beforeUpdatingLocationData = (kCameraLatitude,kCameraLongitude)
//            DispatchQueue.main.async {
//                gmssMarker.map = self.mapView
//            }
//            gmssMarker.iconView = markerView
//            gmssMarker.tracksViewChanges = true
//            gmssMarker.tracksInfoWindowChanges = true
//            self.mapView.camera = GMSCameraPosition.camera(withLatitude: kCameraLatitude, longitude: kCameraLongitude, zoom: 15)
//            self.setNewLocationAnimation(isLoading: false)
//            self.AppearSetNewLocationButton()
        } else {
            self.backBtnOutlet.isHidden = false
            self.mapViewBottomCons.constant =  (68 + UIDevice.bottomSafeArea)// + self.tabBarHeight)
            self.placesAndSuperShesViewBottomCons.constant = -(screen_height - 62.0) + 68.0 + (UIDevice.bottomSafeArea)
//            self.mapView.camera = GMSCameraPosition.camera(withLatitude: kCameraLatitude, longitude: kCameraLongitude, zoom: 10)
        }
//        NotificationCenter.default.addObserver(self, selector: #selector(onOtherUserProficeBack), name: .onOtherUserBack, object: nil)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.placesAndSuperShesView.roundCorners([.topLeft,.topRight], radius: 15.0)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
//        self.userNewPostion = nil
//        self.gmsMarker?.map = nil
//        self.gmsMarkerforUser?.map = nil
        self.isDistanceFromFlg = false
        
//        self.kCameraLatitude = AppUserDefaults.value(forKey: .initialLat).double ?? 0.0
//        self.kCameraLongitude = AppUserDefaults.value(forKey: .initialLong).double ?? 0.0
//        showFlagMarkerAndCurrentUserMarker(coordinate: CLLocationCoordinate2D(latitude: self.kCameraLatitude, longitude: self.kCameraLongitude) ,isUserMarker: true)
        self.isStatusBarBlack = true
        self.setNeedsStatusBarAppearanceUpdate()
        if self.comingFrom != .otherUserProfile {
            if comeBackFromOtherUserProfile == false {
//                self.mapView.camera = GMSCameraPosition.camera(withLatitude: kCameraLatitude, longitude: kCameraLongitude, zoom: 10)
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
//        if self.beforeUpdatingLocationData.lat != kCameraLatitude && self.beforeUpdatingLocationData.long != kCameraLongitude {
//            //viewmodel setup
//            self.beforeUpdatingLocationData = (kCameraLatitude,kCameraLongitude)
//            self.viewModel.updateUserId()
//        }
        
//        self.setNewLocationAnimation(isLoading: true)
//        if self.comingFrom == .otherUserProfile {
//            self.setNewLocationAnimation(isLoading: false)
//            if  !self.clearMap  {
//                self.viewModel.getUsersOnMap(longLatArray: [kCameraLongitude, kCameraLatitude], innerRadius: 0, outerRadius: self.mapView.getRadius(), currentClustringMode: .initialLocation, type :"ELASTIC")
//            }
//            printDebug("no need to hit api")
//        } else {
//            self.viewModel.getUsersOnMap(longLatArray: [kCameraLongitude, kCameraLatitude], innerRadius: 0, outerRadius: self.mapView.getRadius(), currentClustringMode: .initialLocation,type :"ELASTIC")
//        }
        
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
        
//        if SharedLocationManager.locationsEnabled {
//            // For use in foreground
//            locationManager.requestWhenInUseAuthorization()
//            if CLLocationManager.locationServicesEnabled() {
//                locationManager.delegate = self
//                locationManager.desiredAccuracy = kCLLocationAccuracyBest
//                locationManager.distanceFilter = 100
//                locationManager.startUpdatingLocation()
//            }
//        }
    }
    
    
    override func setupLayout() {
        super.setupLayout()
        self.placesView?.frame = CGRect(x: 0.0, y: 0.0, width: screen_width, height: self.mainScrollView.height)
        self.supershesView?.frame = CGRect(x: screen_width, y: 0.0, width: screen_width, height: self.mainScrollView.height)
//        if self.isBottomSheetOpen {
//            self.tabBarController?.tabBar.frame.origin.y = screen_height + self.tabBarHeight
//            print("screenHeight + self.tabBarHeight -> \(screen_height + self.tabBarHeight)")
//        }
//        else {
//            self.tabBarController?.tabBar.frame.origin.y = screen_height - self.tabBarHeight
//            print("screenHeight - self.tabBarHeight -> \(screen_height - self.tabBarHeight)")
//        }
    }
    
    //MARK:- Functions-
    
    ///New Location Btn SetUp
    private func newLocationBtnSetUp() {
        self.setNewLocationBtnOutlet.backgroundColor = AppColors.red
        self.setNewLocationBtnOutlet.titleLabel?.font = AppFonts.BoldItalic.withSize(15.0)
        self.setNewLocationBtnOutlet.cornerRadius = 22.0
        self.setNewLocationBtnOutlet.setTitleColor(AppColors.white, for: .normal)
        self.setNewLocationBtnOutlet.setTitleColor(AppColors.white, for: .selected)
        self.setNewLocationBtnOutlet.clipsToBounds = true
        self.setNewLocationBtnOutlet.imageView?.size = CGSize(width: 19.0, height: 18.0)
        self.setNewLocationBtnOutlet.imageEdgeInsets = UIEdgeInsets(top: 0.0, left: -13.0, bottom: 0.0, right: 0.0)
        self.setNewLocationBtnOutlet.titleLabel?.size = CGSize(width: 114.0, height: 44.0)
        self.setNewLocationBtnOutlet.titleEdgeInsets = UIEdgeInsets(top: 0.0, left: -2.0, bottom: 0.0, right: 0.0)
    }
    
    ///Call for cluster setups
//    private func clusterSetUp() {
//        // Set up the cluster manager with the supplied icon generator and renderer.
//        let iconGenerator = GMUDefaultClusterIconGenerator()
//        let algorithm = GMUNonHierarchicalDistanceBasedAlgorithm()
//        let renderer = GMUDefaultClusterRenderer(mapView: mapView, clusterIconGenerator: iconGenerator)
//        renderer.delegate = self
//        self.clusterManager = GMUClusterManager(map: mapView, algorithm: algorithm, renderer: renderer)
//
//        // Generate and add random items to the cluster manager.
//        self.generateClusterItems(mapUserData: self.viewModel.mapUserData)
//
//        self.clusterManager.setDelegate(self, mapDelegate: self)
//        //        self.mapView.my
//        self.mapView.isMyLocationEnabled = true
//    }
    
    /// Randomly generates cluster items within some extent of the camera and adds them to the cluster manager.
//    private func generateClusterItems(mapUserData: [MapUserModel]) {
//
//        for userData in mapUserData { //self.viewModel.mapUserData
//            //TODO
//            if UserModel.main.id != userData.userId {
//                if  self.comingFrom == .otherUserProfile,  userData.userId != self.userModel?.id {
//                    clusterManager.add(POIItem(position: CLLocationCoordinate2DMake( userData.lat, userData.long), name: "", imageUrl: userData.profilePictureUrl))
//                }
//                if self.comingFrom != .otherUserProfile {
//                    clusterManager.add(POIItem(position: CLLocationCoordinate2DMake( userData.lat, userData.long), name: "", imageUrl: userData.profilePictureUrl))
//                }
//            }
//        }
//
//
//        self.clusterManager.cluster()
//    }
    
    ///Main scrollview setups
    private func mainScrollViewSetUp() {
        self.mainScrollView.delegate = self
        self.mainScrollView.contentSize = CGSize(width: (self.mainScrollView.width * 2.0), height: 0.0)
        
        self.placesView = PlacesAndSuperShesView(frame: CGRect(x: 0.0, y: 0.0, width: screen_width, height: self.mainScrollView.bounds.height))
        
        if let placeView = self.placesView {
            placeView.screenUsingFor = .places
            placeView.deleagte = self
//            placeView.locationDelegate = self
            self.mainScrollView.addSubview(placeView)
        }
        
        self.supershesView = PlacesAndSuperShesView(frame: CGRect(x: screen_width, y: 0.0, width: screen_width, height: self.mainScrollView.bounds.height))
        
        if let superSheView = self.supershesView {
            superSheView.screenUsingFor = .supershes
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
//                    sSelf.placesView?.clearPlaceViewData()
                } else {
//                    if !(sSelf.supershesView?.viewModel.didTapCluster ?? true), !(self?.searchTextField.text ?? "").isEmpty {
//                        sSelf.supershesView?.hitApi(text: "", page: 0)
//                        sSelf.supershesView?.dataTableView.reloadData()
//                    }
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
    
    /// call to get coordinates, counrty and city details from gmap
//    private func reverseGeocodeCoordinate(_ coordinate: CLLocationCoordinate2D) {
//        let geocoder = GMSGeocoder()
//        geocoder.reverseGeocodeCoordinate(coordinate) { response, error in
//            if let address = response?.firstResult(), let lines = address.lines {
//                printDebug(address)
//                printDebug(lines)
//                let cityName = lines.first?.components(separatedBy: ",")
//                self.newLocation = cityName?.first ?? ""
//                self.viewModel.setNewLocationApi(lat: coordinate.latitude, long: coordinate.longitude, city: cityName?.first ?? "", country: address.country ?? "")
//            } else {
//                self.setNewLocationAnimation(isLoading: false)
//            }
//        }
//    }
    
    /// Call for SetNewLocation Button Animation
//    private func setNewLocationAnimation(isLoading: Bool,isLoadingForUserData: Bool = false) {
//        if isLoading {
//            //            self.setNewLocationBtnOutlet.isUserInteractionEnabled = false
//
//            UIView.animate(withDuration: 0.25) { [weak self] in
//                guard let sSelf = self else { return }
//                sSelf.isSettingNewLoc = true
//                sSelf.setNewLocationBtnOutlet.imageView?.rotate360Degrees(speed: 5)
//                sSelf.setNewLocationBtnWidthCons.constant = 225.0
//                if (sSelf.userNewPostion != nil && isLoadingForUserData) { sSelf.setNewLocationBtnOutlet.setTitle("Updating new location", for: .normal)
//                } else { sSelf.setNewLocationBtnOutlet.setTitle("Fetching New Supershes", for: .normal) }
//                sSelf.view.layoutIfNeeded()
//            }
//        } else {
//            UIView.animate(withDuration: 0.25, animations: { [weak self] in
//                guard let sSelf = self else { return }
//                sSelf.setNewLocationBtnWidthCons.constant = 170.0
//                sSelf.setNewLocationBtnOutlet.setTitle("Set new location", for: .normal)
//                sSelf.view.layoutIfNeeded()
//            }) { [weak self] (true) in
//                guard let sSelf = self else { return }
//                sSelf.setNewLocationBtnOutlet.imageView?.layer.removeAllAnimations()
//                //                sSelf.setNewLocationBtnOutlet.isUserInteractionEnabled = true
//                sSelf.isSettingNewLoc = false
//            }
//        }
//    }
    
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
    
//    @IBAction func setNewLocationBtnAction(_ sender: AppButton) {
//        guard !self.isSettingNewLoc else { return }
//        var alertMessage = ""
//        if (self.newLocation ?? "").isEmpty && (self.deviceLocationDetail).isEmpty {
//            alertMessage = "Do you want to set new location ?"
//        } else {
//            if self.isDistanceFromFlg {
//                alertMessage = (self.newLocation ?? "").isEmpty ? "Do you want to set new location ?" : "Are you sure want to set \"\(self.newLocation ?? "")\" as a new SuperShe location ?"}
//            else { alertMessage = (self.deviceLocationDetail).isEmpty ? "Do you want to set new location ?" : "Are you sure want to set \"\(self.deviceLocationDetail )\" as a new SuperShe location ?"
//            }
//        }
//        self.showAlertWithMessage(viewController: self, title: "", message: alertMessage, style: .alert, leftButtonTitle: "Cancel", rightButtonTitle: "Ok", leftButtonStyle: .default, rightButtonStyle: .default, leftButtonHandler: {
//
//        }, rightButtonHandler: {
//            self.setNewLocationAnimation(isLoading: true,isLoadingForUserData: true)
//            if self.isDistanceFromFlg {
//                guard let newPosition = self.userNewPostion  else {
//                    self.setNewLocationAnimation(isLoading: false)
//                    return
//                }
//                delay(delay: 0.25) { [weak self] in
//                    guard let sSelf = self else { return }
//                    sSelf.reverseGeocodeCoordinate(newPosition)
//                }
//            } else {
//                guard let newPosition = self.deviceLocation else {
//                    self.setNewLocationAnimation(isLoading: false)
//                    return
//                }
//                delay(delay: 0.25) { [weak self] in
//                    guard let sSelf = self else { return }
//                    sSelf.reverseGeocodeCoordinate(newPosition)
//                }
//            }
//        })
//    }
}

//MARK:- UITextFieldDelegate-
extension SuperSheVC: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = (textField.text as NSString?)?.replacingCharacters(in: range, with: string) else { return false }
        if !text.isEmpty, !self.applySearch  {
            self.textFieldAnimation(applySearch: true)
        }
//        switch self.activeScreen {
//        case .supershes:
////           / self.supershesView?.hitApi(text: text, page: 0)
//        case .places:
////            self.placesView?.placeAutocompleteApi(placeName: text)
//        }
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

//MARK:- GMUClusterRendererDelegate-
//extension SuperSheVC: GMUClusterRendererDelegate, GMUClusterManagerDelegate {
//
//    func clusterManager(_ clusterManager: GMUClusterManager, didTap cluster: GMUCluster) -> Bool {
//
//        if let superSheView = self.supershesView {
//            self.buttonsScrollView.isHidden = false
//            superSheView.viewModel.dataModel.data.removeAll()
//            superSheView.viewModel.clusterLat = cluster.position.latitude
//            superSheView.viewModel.clusterLong = cluster.position.longitude
//            superSheView.viewModel.distance = mapView.getRadius()
//            superSheView.viewModel.didTapCluster = true
//            self.openBottomSheet(openFor: .supershes)
//            return true
//        }
//        return false
//    }
//
//    func clusterManager(_ clusterManager: GMUClusterManager, didTap clusterItem: GMUClusterItem) -> Bool {
//        //        var userId: String = ""
//        //        self.viewModel.mapUserData.forEach {
//        //            if clusterItem.position.latitude == $0.lat && clusterItem.position.longitude == $0.long {
//        //                userId = $0.userId
//        //            }
//        //        }
//
//        let mapModel = self.viewModel.mapUserData.first(where: {($0.lat == clusterItem.position.latitude) && $0.long == clusterItem.position.longitude})
//
//        //        if !userId.isEmpty {
//
//        if let model = mapModel {
//            let userModel = MapUserModel.getUserModelData(model: model)
//            Router.shared.goToUserProfile(userId : userModel.id, placeHolderImage: nil, userModel: userModel)
//            return true
//        }
//
//
//        return false
//
//        //        }
//        //        for user in self.viewModel.mapUserData {
//        //            if clusterItem.position.latitude == user.lat, clusterItem.position.longitude == user.long {
//        //
//        ////                Router.shared.navigate(to: OtherUserProfileVC.self, storyboard: .Chat, action: .push, navigationController: .current) { () -> OtherUserProfileVC.RequiredParams in
//        ////                    return (ChatRoomModel(), user.userId,nil) }
//        //            }
//        //            printDebug(clusterItem)
//        //            return true
//        //        }
//        //        return false
//    }
//
//    func renderer(_ renderer: GMUClusterRenderer, willRenderMarker marker: GMSMarker) {
//
//        //        DispatchQueue.main.async { [weak self] in
//        if let userData = marker.userData as? GMUCluster {
//
//            let height = 50.0
//            let width = height + (height * 0.75 * 2)
//            let clusterMarkerView = ClusterIcon.init(frame: CGRect(x: 0, y: 0, width: width, height: height))
//
//            clusterMarkerView.clusterLabel.text = Double(userData.count - 2).kFormatted
//
//            clusterMarkerView.firstImageView.setImage(imageString: ((marker.userData as? GMUCluster)?.items[0] as? POIItem)?.imageUrl ?? "", localUri: "", placeHolderImage: nil, imageQuality: .low, isLambdaEnable : false, backgroundColor: UIColor.darkGray)
//            clusterMarkerView.secondImageView.setImage(imageString: ((marker.userData as? GMUCluster)?.items[1] as? POIItem)?.imageUrl ?? "", localUri: "", placeHolderImage: nil, imageQuality: .low, isLambdaEnable : false, backgroundColor: UIColor.darkGray)
//            marker.iconView = clusterMarkerView
//
//        }
//
//        //set marker icon
//        //        DispatchQueue.main.async { [weak self] in
//
//        guard let data = marker.userData as? POIItem else { return }
//
//        let markerView = MarkerIcon(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
//        markerView.mainImgView.setImage(imageString: data.imageUrl, localUri: "", placeHolderImage: nil, imageQuality: .low, isLambdaEnable : false, backgroundColor: UIColor.darkGray)
//        markerView.mainImgView.contentMode = .scaleAspectFill
//        markerView.layer.backgroundColor = UIColor.clear.cgColor
//        markerView.makeCircular(borderWidth: 2, borderColor: .white)
//        marker.map = self.mapView
//        marker.iconView = markerView
//        marker.tracksViewChanges = false
//        marker.tracksInfoWindowChanges = false
//
//    }
//}

//MARK:- GMSMapViewDelegate-
//extension SuperSheVC: GMSMapViewDelegate ,CLLocationManagerDelegate{
//    /// MapView
//    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
//        if let poiItem = marker.userData as? POIItem {
//            NSLog("Did tap marker for cluster item \(poiItem.name)")
//        } else {
//            NSLog("Did tap a normal marker")
//        }
//        return false
//    }
//
//    func mapView(_ mapView: GMSMapView, didTapPOIWithPlaceID placeID: String, name: String, location: CLLocationCoordinate2D) {
//        self.didTapLocation(coordinate: location)
//    }
//
//    func didTapMyLocationButton(for mapView: GMSMapView) -> Bool {
//
//        let status = CLLocationManager.authorizationStatus()
//
//        if CLLocationManager.locationServicesEnabled() {
//            if  status == CLAuthorizationStatus.authorizedAlways
//                || status == CLAuthorizationStatus.authorizedWhenInUse {
//
//                guard let lat = self.mapView.myLocation?.coordinate.latitude,
//                    let lng = self.mapView.myLocation?.coordinate.longitude else {
//                        return false }
//
//                let camera = GMSCameraPosition.camera(withLatitude: lat ,longitude: lng , zoom: 10)
//                self.mapView.animate(to: camera)
//
//                let myLocation = CLLocation(latitude: kCameraLatitude, longitude: kCameraLongitude)
//                self.deviceLocation = CLLocationCoordinate2D(latitude: lat, longitude: lng)
//                let deviceLoc = CLLocation(latitude: lat, longitude: lng)
//                let distance = myLocation.distance(from: deviceLoc) / 1000
//                if distance >= 5 {
//                    self.isDistanceFromFlg = false
//                    self.deviceLocation = CLLocationCoordinate2D(latitude: lat, longitude: lng)
//                    self.AppearSetNewLocationButton()
//                    self.setNewLocationAnimation(isLoading: false)
//                } else {
//                    self.setNewLocationAnimation(isLoading: false)
//                    self.disAppearSetNewLocationButton()
//                }
//                self.gmsMarker?.map = nil
//                self.isCameFromSearchPlace = true
//                // -Fetch City and Country-
//                getAddressFromCoordinate(coordinate: self.deviceLocation ?? CLLocationCoordinate2D(),isDeviceLocation: true)
//                return true
//            }
//
//            else {
//                self.locationPermissonPopUp()
//            }
//        }
//        else {
//            self.locationPermissonPopUp()
//        }
//        return false
//    }
//
//    func mapView(_ mapView: GMSMapView, idleAt position: GMSCameraPosition) {
//        //        NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(hitAPI), object: nil)
//        if self.comingFrom == .otherUserProfile ,self.dataLoadedFromCluster {
//            printDebug("no need to load data")
//            self.dataLoadedFromCluster = false
//        }else {
//            guard self.viewModel.totalCount > self.userCount ?? 0 else { return }
//            if isMaptap {
//                //                self.AppearSetNewLocationButton()
//                //                self.setNewLocationAnimation(isLoading: true)
//                self.viewModel.getUsersOnMap(longLatArray: [position.target.longitude, position.target.latitude], innerRadius: 0, outerRadius: mapView.getRadius(), currentClustringMode: .initialLocation,type :"ELASTIC")
//            }
//            self.isMaptap = true
//        }
//        //        self.setNewLocationAnimation(isLoading: true)
//    }
//
//    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
//        self.didTapLocation(coordinate: coordinate)
//    }
//
//    private func didTapLocation(coordinate: CLLocationCoordinate2D) {
//
//        // -Fetch City and Country-
//        self.isCameFromSearchPlace = true
//        getAddressFromCoordinate(coordinate: coordinate, isDeviceLocation: false)
//        let myLocation = CLLocation(latitude: kCameraLatitude, longitude: kCameraLongitude)
//        let tapLocation = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
//        let distance = myLocation.distance(from: tapLocation) / 1000
//        if distance >= 1 {
//            self.gmsMarker?.map = nil
//            self.isDistanceFromFlg = true
//            self.isMaptap = false
//            self.isZoomLevelMax = false
//            self.userNewPostion = coordinate.self
//            showFlagMarkerAndCurrentUserMarker(coordinate: self.userNewPostion ?? CLLocationCoordinate2D())
//            self.AppearSetNewLocationButton()
//            self.setNewLocationAnimation(isLoading: false)
//            UIDevice.MarkerTapVibrate()
//        } else {
//            self.setNewLocationAnimation(isLoading: false)
//            self.disAppearSetNewLocationButton()}
//        printDebug("You tapped at \(coordinate.latitude), \(coordinate.longitude)")
//    }
//
//    func mapView(_ mapView: GMSMapView, didChange position: GMSCameraPosition) {
//        printDebug(position)
//
//    }
//
//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//
//        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
//
//        // -Fetch City and Country-
//        self.deviceLocation = locValue
//        self.isCameFromSearchPlace = true
//        getAddressFromCoordinate(coordinate: self.deviceLocation ?? CLLocationCoordinate2D(),isDeviceLocation: true)
//        // -Distance bw CurrentLocation to DeviceLocation
//        let myLocation = CLLocation(latitude: kCameraLatitude, longitude: kCameraLongitude)
//        let deviceLocation = CLLocation(latitude: locValue.latitude, longitude: locValue.longitude)
//        let distance = myLocation.distance(from: deviceLocation) / 1000
//        if (distance >= 5 && !self.clearMap) || (self.isDistanceFromFlg) {
//            // self.AppearSetNewLocationButton()
//            // self.setNewLocationAnimation(isLoading: false)
//        } else {
//            // self.disAppearSetNewLocationButton()
//        }
//    }
//
//    ///SETUP LOCATIONS
//    func setupLocations() {
//
//        let status = CLLocationManager.authorizationStatus()
//
//        if CLLocationManager.locationServicesEnabled() {
//            if  status == CLAuthorizationStatus.authorizedAlways
//                || status == CLAuthorizationStatus.authorizedWhenInUse {
//                printDebug("All set")
//            }
//            else{
//                self.locationPermissonPopUp()
//            }
//        }
//        else{
//            self.locationPermissonPopUp()
//        }
//    }
//
//
//    private func locationPermissonPopUp() {
//        openSettingApp(message: "We need permission to access this app")
//        self.gmsMarker?.map = nil
//        self.setNewLocationAnimation(isLoading: false)
//        self.disAppearSetNewLocationButton()
//    }
//
//    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
//
//        switch status {
//
//        case .authorizedAlways, .authorizedWhenInUse:
//            self.setNewLocationAnimation(isLoading: false)
//            self.AppearSetNewLocationButton()
//            manager.startUpdatingLocation()
//
//        default:
//            self.setupLocations()
//        }
//
//    }
//}
//MARK:- LocateOnTheMap-
//extension SuperSheVC: LocateOnTheMap {
//
//    func locateWithLatLong(lon: String, andLatitude lat: String, andAddress address: String) {
//        guard let lat = Double(lat), let lng = Double(lon) else { return }
//        // Distance of User from Device
//        let myLocation = CLLocation(latitude: kCameraLatitude, longitude: kCameraLongitude)
//        let deviceLocation = CLLocation(latitude: lat, longitude: lng)
//        let distanceFromFlag = myLocation.distance(from: deviceLocation) / 1000
//        if distanceFromFlag >= 1 {
//            self.gmsMarker?.map = nil
//            self.isZoomLevelMax = false
//            self.isDistanceFromFlg = true
//            self.isCameFromSearchPlace = true
//            self.userNewPostion = CLLocationCoordinate2D(latitude: lat , longitude: lng)
//            // -Fetch City and Country-
//            getAddressFromCoordinate(coordinate: self.userNewPostion ?? CLLocationCoordinate2D(),isDeviceLocation: false)
//            showFlagMarkerAndCurrentUserMarker(coordinate: self.userNewPostion ?? CLLocationCoordinate2D())
//            AppearSetNewLocationButton()
//        }else {
//            self.isDistanceFromFlg = false
//            self.isCameFromSearchPlace = false
//            self.setNewLocationAnimation(isLoading: false)
//            disAppearSetNewLocationButton()
//        }
//        self.closeBottomSheet()
//        // self.mapView.clear()
//        let camera = GMSCameraPosition.camera(withLatitude: lat ,longitude: lng , zoom: 10)
//        self.mapView.animate(to: camera)
//        self.setNewLocationAnimation(isLoading: false)
//        self.viewModel.getUsersOnMap(longLatArray: [lng,lat], innerRadius: 0, outerRadius: self.mapView.getRadius(), currentClustringMode: .customLocation,type :"ELASTIC")
//    }
//
//    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
//        printDebug(error.localizedDescription)
//    }
//}

//MARK:- SuperSheVMDelegate-
//extension SuperSheVC: SuperSheVMDelegate {
//
//    func willHitMapUsesApi() {
//
//    }
//
//    func getUsersOnMapSuccess(successMsg: String, currentClustringMode: ClusteringMode, newData: [MapUserModel]) {
//        printDebug(successMsg)
//        self.userCount = self.viewModel.mapUserData.count
//        let status = CLLocationManager.authorizationStatus()
//
//        if CLLocationManager.locationServicesEnabled() {
//            if  status == CLAuthorizationStatus.authorizedAlways
//                || status == CLAuthorizationStatus.authorizedWhenInUse {
//
//                // Distance of User from Device
//                let myLocation = CLLocation(latitude: kCameraLatitude, longitude: kCameraLongitude)
//                let deviceLocation = CLLocation(latitude: self.deviceLocation?.latitude ?? 0.0, longitude: self.deviceLocation?.longitude ?? 0.0)
//                let distanceFromDevice = myLocation.distance(from: deviceLocation) / 1000
//                if (distanceFromDevice >= 5 || self.isDistanceFromFlg) && (self.isCameFromSearchPlace) {
//                    self.setNewLocationAnimation(isLoading: false)
//                    self.AppearSetNewLocationButton()
//                } else {
//                    self.setNewLocationAnimation(isLoading: false)
//                    self.disAppearSetNewLocationButton()
//                }
//            } else {
//                self.setNewLocationAnimation(isLoading: false)
//                self.disAppearSetNewLocationButton()
//            }
//        }
//
//        self.clearMap = false
//        switch currentClustringMode {
//        case .initialLocation:
//            if self.comingFrom == .otherUserProfile && self.isZoomLevelMax{
//                self.mapView.camera = GMSCameraPosition.camera(withLatitude: self.userModel?.lat ?? 0.0, longitude: self.userModel?.lng ?? 0.0, zoom: 10)
//            }
//            self.clusterSetUp()
//            printDebug(currentClustringMode)
//        case .currentLocation:
//            self.clusterSetUp()
//            //self.generateClusterItems(mapUserData: newData)
//            printDebug(currentClustringMode)
//        case .customLocation:
//            self.clusterSetUp()
//            printDebug(currentClustringMode)
//        }
//
//
//    }
//
//    func getUsersOnMapFailed(failedToGetData: String, currentClustringMode: ClusteringMode) {
//        printDebug(failedToGetData)
//        self.disAppearSetNewLocationButton()
//        self.setNewLocationAnimation(isLoading: false)
//        switch currentClustringMode {
//        case .initialLocation:
//            printDebug(currentClustringMode)
//        case .currentLocation:
//            printDebug(currentClustringMode)
//        case .customLocation:
//            printDebug(currentClustringMode)
//        }
//    }
//
//    func willHitSetNewLocApi() {
//
//    }
//
//    func setNewLocSuccess(successMsg: String, newLat: Double, newLong: Double) {
//
//        //R&D
//        //self.mapView.clear()
//        self.gmsMarker?.map = nil
//        self.kCameraLatitude = newLat
//        self.kCameraLongitude = newLong
//        self.isCameFromSearchPlace = true
//        // Distance of User from Device
//        let myLocation = CLLocation(latitude: self.kCameraLatitude, longitude: self.kCameraLongitude)
//        let deviceLocation = CLLocation(latitude: self.deviceLocation?.latitude ?? 0.0, longitude: self.deviceLocation?.longitude ?? 0.0)
//        let distanceFromDeivce = myLocation.distance(from: deviceLocation) / 1000
//        if distanceFromDeivce >= 5 {
//            self.isDistanceFromFlg = false
//            self.setNewLocationAnimation(isLoading: false)
//            self.AppearSetNewLocationButton()
//        } else {
//            self.setNewLocationAnimation(isLoading: false)
//            self.disAppearSetNewLocationButton()
//        }
//        moveMarker(coordinate: CLLocationCoordinate2D(latitude: self.kCameraLatitude, longitude: self.kCameraLongitude))
////        let camera = GMSCameraPosition.camera(withLatitude: kCameraLatitude ,longitude: kCameraLongitude , zoom: 10)
////        self.mapView.animate(to: camera)
////        self.viewModel.getUsersOnMap(longLatArray: [kCameraLongitude,kCameraLatitude], innerRadius: 0, outerRadius: self.mapView.getRadius(), currentClustringMode: .currentLocation,changingMyLocation: true,type :"ELASTIC")
////        showFlagMarkerAndCurrentUserMarker(coordinate: nil, isUserMarker: true)
//        self.userNewPostion = nil
//    }
//
//    func setNewLocFailed(failedToGetData: String) {
//        showToast(failedToGetData, position: .top)
//        self.setNewLocationAnimation(isLoading: false)
//    }
//}

extension SuperSheVC {
    func AppearSetNewLocationButton() {
        self.view.layoutIfNeeded()
        UIView.animate(withDuration: 0.6, delay: 0.1, options: .curveEaseInOut, animations: {
            self.setNewLocBtnBtmCons.constant = -16
            self.view.layoutIfNeeded()
        }) { (true) in
//            printDebug("Do Nothing")
        }
    }
    func disAppearSetNewLocationButton(){
        self.view.layoutIfNeeded()
        UIView.animate(withDuration: 0.6, delay: 0.1, options: .curveEaseInOut, animations: {
            self.setNewLocBtnBtmCons.constant = 64
            self.view.layoutIfNeeded()
        }) { (true) in
//            printDebug("Do Nothing")
        }
    }
    
//    func getAddressFromCoordinate(coordinate: CLLocationCoordinate2D,isDeviceLocation: Bool = true){
//        //Coordinate to Address============
//        let location = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
//        location.convertToPlaceMark({[weak self] (placeMark) in
//            guard let `self` = self else {
//                return
//            }
//            guard let address = placeMark.addressDictionary as? JSONDictionary else {
//                return
//            }
//            self.locationModel = LocationModel(geoLoc: address)
//            guard let locationModel = self.locationModel else {return}
//            if isDeviceLocation {
//                self.deviceLocationDetail = "\(locationModel.name ) \(locationModel.city) \(locationModel.country ) "} else {
//                self.newLocation = "\(locationModel.name ) \(locationModel.city) \(locationModel.country ) "
//            }
//        })
//    }
    //R&D
//    func moveMarker(coordinate: CLLocationCoordinate2D){
//        CATransaction.begin()
//        CATransaction.setValue(0.33, forKey: kCATransactionAnimationDuration)
//        self.mapView.animate(to: GMSCameraPosition.camera(withLatitude:coordinate.latitude, longitude: coordinate.longitude, zoom: 10))
//        self.gmsMarkerforUser?.position = CLLocationCoordinate2D(latitude: coordinate.latitude, longitude: coordinate.longitude)
//        CATransaction.commit()
//        self.gmsMarkerforUser?.map = self.mapView
//    }
    
//    func openSettingApp(message: String) {
//
//        self.showAlertWithMessage(viewController: self, title: "", message: message, style: .alert, leftButtonTitle: "Setting", rightButtonTitle: "Cancel", leftButtonStyle: .default, rightButtonStyle: .default, leftButtonHandler: {
//            guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
//                return
//            }
//            if UIApplication.shared.canOpenURL(settingsUrl) {
//                UIApplication.shared.open(settingsUrl, options: [:], completionHandler: nil)
//            }
//        }, rightButtonHandler: {
//
//        })
//    }
    
//    func showFlagMarkerAndCurrentUserMarker(coordinate: CLLocationCoordinate2D? ,isUserMarker: Bool = false) {
//        if isUserMarker {
//            self.gmsMarkerforUser = GMSMarker(position: CLLocationCoordinate2D(latitude: kCameraLatitude, longitude: kCameraLongitude))
//            self.userNewLocMarkerView = MarkerIcon(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
//            self.userNewLocMarkerView?.mainImgView.makeCircular(borderWidth: 2, borderColor: .white)
//            self.userNewLocMarkerView?.mainImgView.setImage(imageString: UserModel.main.profilePicture, localUri: "", placeHolderImage:nil , imageQuality: .high, isLambdaEnable : false, backgroundColor: UIColor.darkGray)
//            self.userNewLocMarkerView?.mainImgView.contentMode = isUserMarker ? .scaleAspectFill : .scaleAspectFit
//            self.userNewLocMarkerView?.mainImgView.layer.backgroundColor = UIColor.clear.cgColor
//            self.gmsMarkerforUser?.iconView = userNewLocMarkerView
//        } else {
//            self.gmsMarker = GMSMarker(position: CLLocationCoordinate2D(latitude: coordinate?.latitude ?? 0.0, longitude: coordinate?.longitude ?? 0.0))
//            self.userNewLocMarkerView = MarkerIcon(frame: CGRect(x: 0, y: 0, width: 35.2, height: 44))
//            self.userNewLocMarkerView?.mainImgView.setImage(imageString: "", localUri: "", placeHolderImage: #imageLiteral(resourceName: "flag"), imageQuality: .high, isLambdaEnable : false, backgroundColor: UIColor.darkGray)
//            self.userNewLocMarkerView?.mainImgView.contentMode = isUserMarker ? .scaleAspectFill : .scaleAspectFit
//            self.userNewLocMarkerView?.mainImgView.layer.backgroundColor = UIColor.clear.cgColor
//            self.gmsMarker?.iconView = userNewLocMarkerView
//        }
//        DispatchQueue.main.async  {
//            if isUserMarker { self.gmsMarkerforUser?.map = self.mapView }else { self.gmsMarker?.map = self.mapView}
//        }
//    }
}
