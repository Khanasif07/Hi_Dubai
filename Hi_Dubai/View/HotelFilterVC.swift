//
//  HotelFilterVC.swift
//  Hi_Dubai
//
//  Created by Asif Khan on 05/05/2023.
//

import UIKit
import Parchment
class HotelFilterVC: BaseVC {
    
    let allTabsStr: [String] = ["Sort", "Distance", "Price", "Ratings", "Amenities","Room"]
    var lastSelectedIndex = 0
    var selectedIndex = 0
    
    @IBOutlet weak var isFilterAppliedBtn: UIButton!
    @IBOutlet weak var clearAllButton: UIButton!
    @IBOutlet weak var navigationTitleLabel: UILabel!
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var dataContainerView: UIView!
    @IBOutlet weak var mainContainerViewTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var mainContainerView: UIView!
    @IBOutlet weak var navigationView: UIView!
    @IBOutlet weak var navigationViewTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var mainBackView: UIView!
    @IBOutlet weak var blurBackGroundView: UIView!

    fileprivate var parchmentView : PagingViewController?
    
    
    
    // MARK: - Variables
    var filtersTabs =  [MenuItem]()
//    var selectedIndex: Int = HotelFilterVM.shared.lastSelectedIndex
    var isFilterApplied:Bool = false
    
    // Only for analytics
    var didTapFilter = false
    
    var allChildVCs: [UIViewController] = [UIViewController]()
//    weak var delegate : HotelFilteVCDelegate?
    
    // MARK: - View Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.layoutIfNeeded()
        self.dataContainerView.layoutIfNeeded()
        self.initialSetups()
    }
    
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        self.parchmentView?.view.frame = self.dataContainerView.bounds
        self.parchmentView?.loadViewIfNeeded()
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.parchmentView?.view.frame = self.dataContainerView.bounds
        self.parchmentView?.loadViewIfNeeded()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        delay(seconds: 0.1) { [weak self] in
            self?.show(animated: true)
        }
//        self.statusBarColor = AppColors.clear
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
//        self.statusBarColor = AppColors.clear
    }
    
    // MARK: - Overrider methods
    
    override func setupTexts() {
        self.clearAllButton.setTitle("Clear All", for: .normal)
        self.doneButton.setTitle("Done", for: .normal)
//        self.setNavigationTitle()
    }
    
    override func setupFonts() {
        self.clearAllButton.titleLabel?.font = AppFonts.Regular.withSize(18.0)
        self.doneButton.titleLabel?.font = AppFonts.SemiBold.withSize(18.0)
        self.navigationTitleLabel.font = AppFonts.Regular.withSize(16.0)
    }
    
    override func setupColors() {
        self.clearAllButton.setTitleColor(AppColors.green, for: .normal)
        self.doneButton.setTitleColor(AppColors.green, for: .normal)
        self.navigationTitleLabel.textColor = AppColors.lightGray
    }
    
    
    private func initialSetups() {
        self.edgesForExtendedLayout = UIRectEdge.init(rawValue: 0)
        let height = UIApplication.shared.statusBarFrame.height
        self.navigationViewTopConstraint.constant = CGFloat(height)
        self.setupPagerView()
        self.hide(animated: false)
        delay(seconds: 0.01) { [weak self] in
            self?.mainContainerView.roundCorners([.bottomLeft, .bottomRight], radius: 10.0)
        }
        blurBackGroundView.backgroundColor = AppColors.white
    }
    
    private func initiateFilterTabs() {
        filtersTabs.removeAll()
        for i in 0..<(allTabsStr.count){
            let obj = MenuItem(title: allTabsStr[i], index: i, isSelected: true)
            filtersTabs.append(obj)
        }
    }
    
    private func show(animated: Bool) {
        UIView.animate(withDuration: animated ? 0.7 : 0.0, animations: {
            self.mainContainerViewTopConstraint.constant = 0.0
            self.mainBackView.alpha = 1.0
            self.view.layoutIfNeeded()
        })
    }
    
    private func hide(animated: Bool, shouldRemove: Bool = false) {
        UIView.animate(withDuration: animated ? 0.7 : 0.0, animations: {
            self.mainContainerViewTopConstraint.constant = -(self.mainContainerView.height)
            self.mainBackView.alpha = 0.0
            self.view.layoutIfNeeded()
        }, completion: { _ in
            if shouldRemove {
                self.removeFromParentVC
            }
        })
    }
    
    
    private func setupPagerView() {
        self.allChildVCs.removeAll()
        //        self.selectedIndex = HotelFilterVM.shared.lastSelectedIndex
        
        for i in 0..<allTabsStr.count{
            if i == 1 {
                let vc = NewsListVC.instantiate(fromAppStoryboard: .Main)
                self.allChildVCs.append(vc)
            } else if i == 2 {
                let vc = NewsListVC.instantiate(fromAppStoryboard: .Main)
                self.allChildVCs.append(vc)
            } else if i == 3 {
                let vc = NewsListVC.instantiate(fromAppStoryboard: .Main)
                self.allChildVCs.append(vc)
            } else if i == 4 {
                let vc = NewsListVC.instantiate(fromAppStoryboard: .Main)
                self.allChildVCs.append(vc)
            } else if i == 5 {
                let vc = NewsListVC.instantiate(fromAppStoryboard: .Main)
                self.allChildVCs.append(vc)
            } else {
                let vc = NewsListVC.instantiate(fromAppStoryboard: .Main)
                self.allChildVCs.append(vc)
            }
        }
        //self.view.layoutIfNeeded()
        if let _ = self.parchmentView{
            self.parchmentView?.view.removeFromSuperview()
            self.parchmentView = nil
        }
        initiateFilterTabs()
        setupParchmentPageController()
        
    }
    
    // Added to replace the existing page controller, added Hitesh Soni, 28-29Jan'2020
    private func setupParchmentPageController(){
        
        self.parchmentView = PagingViewController()
        parchmentView?.view.backgroundColor = AppColors.white
        self.parchmentView?.menuItemSpacing = 7.5
        self.parchmentView?.menuInsets = UIEdgeInsets(top: 0.0, left: 11.0, bottom: 0.0, right: 11.0)
        self.parchmentView?.menuItemSize = .sizeToFit(minWidth: 150, height: 45)
        self.parchmentView?.indicatorOptions = PagingIndicatorOptions.visible(height: 2, zIndex: Int.max, spacing: UIEdgeInsets(top: 0, left: 11.5, bottom: 0, right: 11.5), insets: UIEdgeInsets(top: 0, left: 0.0, bottom: 0, right: 0.0))
        self.parchmentView?.borderOptions = PagingBorderOptions.visible(
            height: 0.5,
            zIndex: Int.max - 1,
            insets: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
        let nib = UINib(nibName: "MenuItemCollectionCell", bundle: nil)
        self.parchmentView?.register(nib, for: MenuItem.self)
        self.parchmentView?.font = AppFonts.Regular.withSize(16.0)
        self.parchmentView?.selectedFont = AppFonts.SemiBold.withSize(16.0)
        self.parchmentView?.indicatorColor = AppColors.green
        self.parchmentView?.selectedTextColor = AppColors.black
        self.parchmentView?.borderColor = .clear//AppColors.divider.color
        self.dataContainerView.addSubview(self.parchmentView!.view)
        self.parchmentView?.dataSource = self
        self.parchmentView?.delegate = self
        self.parchmentView?.sizeDelegate = self
        self.parchmentView?.select(index: selectedIndex)
        self.parchmentView?.reloadData()
        self.parchmentView?.reloadMenu()
        self.parchmentView?.menuBackgroundColor = UIColor.clear
        self.parchmentView?.collectionView.backgroundColor = UIColor.clear
    }
    
    // MARK: - IB Action
    
    @IBAction func clearAllButtonTapped(_ sender: Any) {
         self.hide(animated: true, shouldRemove: true)
//        delegate?.clearAllButtonTapped()
//        reloadMenu()
//        self.allChildVCs.forEach { (viewController) in
//            if let vc = viewController as? PriceVC {
//                vc.setFilterValues()
//            }
//            else if let vc = viewController as? RangeVC {
//                vc.setFilterValues()
//            }
//            else if let vc = viewController as? RatingVC {
//                vc.setFilterValues()
//            }
//            else if let vc = viewController as? AmenitiesVC {
//                vc.setFilterValues()
//            }
//            else if let vc = viewController as? RoomVC {
//                vc.setFilterValues()
//            }else if let vc = viewController as? SortVC {
//                vc.setFilterValues()
//            }
//        }
//        FirebaseEventLogs.shared.logHotelNavigationEvents(with: .ClearAllHotelFilters)
    }
    
    @IBAction func doneButtonTapped(_ sender: Any) {
//        saveAndApplyFilter()
        self.hide(animated: true, shouldRemove: true)
    }
    

}


//Parchment
extension HotelFilterVC: PagingViewControllerDataSource {

    func pagingViewController(_: PagingViewController, pagingItemAt index: Int) -> PagingItem {
        
        return MenuItem(title: allTabsStr[index], index: index, isSelected: filtersTabs[index].isSelected )
    }

    func pagingViewController(_ pagingViewController: PagingViewController, viewControllerAt index: Int) -> UIViewController {
      
        return self.allChildVCs[index]
    }
    func numberOfViewControllers(in pagingViewController: PagingViewController) -> Int {
        return allTabsStr.count
    }
}

// To handle the page view object properties, and how they look in the view.
extension HotelFilterVC : PagingViewControllerDelegate, PagingViewControllerSizeDelegate{
    func pagingViewController(_: PagingViewController, widthForPagingItem pagingItem: PagingItem, isSelected: Bool) -> CGFloat {
        // depending onthe text size, give the width of the menu item
        if let pagingIndexItem = pagingItem as? MenuItem {
            let text = pagingIndexItem.title
            
            let font = isSelected ? AppFonts.SemiBold.withSize(16.0) : AppFonts.Regular.withSize(16.0)
            return text.widthOfString(usingFont: font) + 23.0
        }
        
        return 100.0
    }
    
    func pagingViewController(_ pagingViewController: PagingViewController, didScrollToItem pagingItem: PagingItem, startingViewController: UIViewController?, destinationViewController: UIViewController, transitionSuccessful: Bool)  {
        
        if let pagingIndexItem = pagingItem as? MenuItem {
            lastSelectedIndex = pagingIndexItem.index
        }
        
        if didTapFilter {
            didTapFilter = false
            return
        }
//        if let pagingIndexItem = pagingItem as? MenuItemForFilter {
//            logSwipeEvent(filterIndex: pagingIndexItem.index)
//        }
    }
    
    func pagingViewController(_ pagingViewController: PagingViewController, didSelectItem pagingItem: PagingItem) {
        if let pagingIndexItem = pagingItem as? MenuItem {
            if lastSelectedIndex == pagingIndexItem.index {
//                hideFilter(tappedOutside: false)
            }
            didTapFilter = true
//            logTapEvent(filterIndex: pagingIndexItem.index)
        }
    }
}

// MARK: Analytics
extension HotelFilterVC {
//    func logTapEvent(filterIndex: Int) {
//        var selectedEvent: FirebaseEventLogs.EventsTypeName = .FlightSortFilterTapped
//        switch filterIndex {
//        case 0:             selectedEvent = .HotelSortFilterTapped
//        case 1:             selectedEvent = .HotelDistanceFilterTapped
//        case 2:             selectedEvent = .HotelPriceFilterTapped
//        case 3:             selectedEvent = .HotelRatingsFilterTapped
//        case 4:             selectedEvent = .HotelAmenitiesFilterTapped
//        case 5:             selectedEvent = .HotelRoomFilterTapped
//        default: break
//        }
//        FirebaseEventLogs.shared.logHotelNavigationEvents(with: selectedEvent)
//    }
    
//    func logSwipeEvent(filterIndex: Int) {
//        var selectedEvent: FirebaseEventLogs.EventsTypeName = .FlightSortFilterSwiped
//        switch filterIndex {
//        case 0:             selectedEvent = .HotelSortFilterSwiped
//        case 1:             selectedEvent = .HotelDistanceFilterSwiped
//        case 2:             selectedEvent = .HotelPriceFilterSwiped
//        case 3:             selectedEvent = .HotelRatingsFilterSwiped
//        case 4:             selectedEvent = .HotelAmenitiesFilterSwiped
//        case 5:             selectedEvent = .HotelRoomFilterSwiped
//        default: break
//        }
//        FirebaseEventLogs.shared.logHotelNavigationEvents(with: selectedEvent)
//    }
}


extension String {
    func widthOfString(usingFont font: UIFont) -> CGFloat {
        let fontAttributes = [NSAttributedString.Key.font: font]
        let size = self.size(withAttributes: fontAttributes)
        return size.width
    }
}
