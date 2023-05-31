//
//  HotelResultVC.swift
//  Hi_Dubai
//
//  Created by Asif Khan on 13/05/2023.
//

import UIKit

class HotelResultVC: BaseVC {
    @IBOutlet weak var statusBarViewContainer: UIView!
    @IBOutlet weak var headerContainerView: UIView!
    @IBOutlet weak var navContainerView: UIView!
    @IBOutlet weak var tableViewVertical: UITableView!{
        didSet {
            self.tableViewVertical.registerCell(with: ShimmerCell.self)
            self.tableViewVertical.registerCell(with: NewsTableViewCell.self)
            self.tableViewVertical.delegate = self
            self.tableViewVertical.dataSource = self
            self.tableViewVertical.separatorStyle = .none
            self.tableViewVertical.showsVerticalScrollIndicator = true
            self.tableViewVertical.showsHorizontalScrollIndicator = false
            self.tableViewVertical.contentInset = UIEdgeInsets(top: topContentSpace, left: 0, bottom: 0, right: 0)
        }
    }
    
    @IBOutlet weak var backContainerView: UIView!
    @IBOutlet weak var headerContainerViewTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var headerContatinerViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var blurViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var headerBlurView: UIView!
    
    lazy var viewModel = {
        NewsListViewModel()
    }()
    var emptyView: EmptyStateView? = EmptyStateView.instanciateFromNib()
    var emptyViewPersonal: EmptyView?
//    let topContentSpace: CGFloat = 96
    let topContentSpace: CGFloat = 0
    // header container height
    internal var selectedCell: NewsTableViewCell?
    private var indexPath: IndexPath?
    internal var currentShimmerStatus: ShimmerState = .toBeApply
    var error: Error?
    var hideSection = 0
    var footeSection = 1
    let defaultDuration: CGFloat = 1.2
    let defaultDamping: CGFloat = 0.70
    let defaultVelocity: CGFloat = 15.0
    var applyButtonTapped: Bool = false
    var isViewDidAppear = false
    var visualEffectViewHeight : CGFloat {
        return statusBarHeight + 96
    }
    var statusBarHeight : CGFloat {
        return UIApplication.shared.windows.first?.safeAreaInsets.top ?? 0
    }
    var scrollviewInitialYOffset = CGFloat(0.0)
    
    //used for making collection view centerlized
    var indexOfCellBeforeDragging = 0
    
    //

    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel.delegate = self
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5, execute: {
            self.fetchAPIData()
        })
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.isViewDidAppear = true
        self.statusBarStyle = .lightContent
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
        self.statusBarStyle = .lightContent
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.blurViewHeightConstraint.constant = self.statusBarHeight
    }
    
    
    private func fetchAPIData(){
        self.emptyView?.hide()
        self.currentShimmerStatus = .toBeApply
        self.tableViewVertical.reloadData()
        self.viewModel.getNewsListing()
    }
    
    fileprivate func hideHeaderBlurView(_ offsetDifference: CGFloat) {
        DispatchQueue.main.async {
            
            var yCordinate : CGFloat
            yCordinate = max (  -self.visualEffectViewHeight ,  -offsetDifference )
            yCordinate = min ( 0,  yCordinate)
            
            
            UIView.animate(withDuration: 0.4, delay: 0.0, options: [.curveEaseOut], animations: {
                
                var rect = self.headerContainerView.frame
                let yCordinateOfView = rect.origin.y
                if ( yCordinateOfView  > yCordinate ) {
                    rect.origin.y = yCordinate
                    //printDebug("hideHeaderBlurView.frame : \(self.headerContainerView.frame )")
                    if self.headerContainerViewTopConstraint.constant != yCordinate {
                        self.headerContainerViewTopConstraint.constant = yCordinate
                        self.headerContainerView.layoutIfNeeded()
                    }
                    var value = self.topContentSpace - abs(yCordinate)
                    //printDebug("hideHeaderBlurView: \(value)")
                    if value < 0 {
                        value = 16
                    } else {
                        value += 16
                    }
                    self.tableViewVertical.contentInset = UIEdgeInsets(top: value, left: 0, bottom: 0, right: 0)
                    
                }
                if self.headerContainerViewTopConstraint.constant == 0 {
//                    self.statusBarViewContainer.isHidden = true
                } else {
//                    self.statusBarViewContainer.isHidden = false
                }
            } ,completion: nil)
        }
    }
    
    func revealBlurredHeaderView(_ invertedOffset: CGFloat) {
        DispatchQueue.main.async {
            
            UIView.animate(withDuration: 0.4, delay: 0.0, options: [.curveEaseInOut], animations: {
                
                var rect = self.headerContainerView.frame
                
                //                var yCordinate = rect.origin.y + invertedOffset
                var yCordinate = invertedOffset - 100.0
                yCordinate = min ( 0,  yCordinate)
                if self.tableViewVertical.contentOffset.y <= 0 || rect.origin.y == 20{
                    yCordinate = 0
                }
                rect.origin.y = yCordinate
                //printDebug("revealBlurredHeaderView.frame : \(self.headerContainerView.frame )")
                if self.headerContainerViewTopConstraint.constant != yCordinate {
                    self.headerContainerViewTopConstraint.constant = yCordinate
                    self.view.layoutIfNeeded()
                }
                var value = self.topContentSpace - abs(yCordinate)
//                printDebug("revealBlurredHeaderView: \(value)")
                if value >= 0 {
                    value = self.topContentSpace + 16
                }
                if self.tableViewVertical.contentOffset.y < 100 {
                    value = self.topContentSpace
                }
                if self.headerContainerViewTopConstraint.constant == 0 {
//                    self.statusBarViewContainer.isHidden = true
                } else {
//                    self.statusBarViewContainer.isHidden = false
                }
                self.tableViewVertical.contentInset = UIEdgeInsets(top: value, left: 0, bottom: 0, right: 0)
                
            } ,completion: nil)
        }
    }
    
    fileprivate func snapToTopOrBottomOnSlowScrollDragging(_ scrollView: UIScrollView) {
        
        var rect = self.headerContainerView.frame
        let yCoordinate = rect.origin.y * ( -1 )
        
        // After dragging if blurEffectView is at top or bottom position , snapping animation is not required
        if yCoordinate == 0 || yCoordinate == ( -visualEffectViewHeight){
            return
        }
        
        // If blurEffectView yCoodinate is close to top of the screen
        if  ( yCoordinate > ( visualEffectViewHeight / 2.0 ) ){
            rect.origin.y = -visualEffectViewHeight
            
            if scrollView.contentOffset.y < 100 {
                let zeroPoint = CGPoint(x: 0, y: self.topContentSpace)
                scrollView.setContentOffset(zeroPoint, animated: true)
            }
        }
        else {  //If blurEffectView yCoodinate is close to fully visible state of blurView
            rect.origin.y = 0
        }
        
        // Animatioon to move the blurEffectView
        UIView.animate(withDuration: 0.4, delay: 0.0, options: [.curveEaseOut], animations: {
            if self.headerContainerViewTopConstraint.constant != rect.origin.y {
                self.headerContainerViewTopConstraint.constant = rect.origin.y
                self.view.layoutIfNeeded()
            }
            var value = self.topContentSpace - abs(rect.origin.y)
            if value >= 0 {
                value = self.topContentSpace + 16
            }
            if value < 0 {
                value = 16
            }
            if self.tableViewVertical.contentOffset.y < 100 {
                value = self.topContentSpace
            }
            if self.headerContainerViewTopConstraint.constant == 0 {
//                self.statusBarViewContainer.isHidden = true
            } else {
//                self.statusBarViewContainer.isHidden = false
            }
            self.tableViewVertical.contentInset = UIEdgeInsets(top: value, left: 0, bottom: 0, right: 0)
            
        } ,completion: nil)
    }
    
    func showBluredHeaderViewCompleted() {
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.4, delay: 0.0, options: [.curveEaseInOut], animations: {
                if self.headerContainerViewTopConstraint.constant != 0 {
                    self.headerContainerViewTopConstraint.constant = 0
                    self.view.layoutIfNeeded()
                }
//                self.statusBarViewContainer.isHidden = true
                //self.tableViewVertical.contentInset = UIEdgeInsets(top: self.topContentSpace, left: 0, bottom: 0, right: 0)
                
            } ,completion: nil)
        }
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        guard scrollView === tableViewVertical, self.isViewDidAppear else {return}
        scrollviewInitialYOffset = scrollView.contentOffset.y
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard scrollView === tableViewVertical, self.isViewDidAppear else {return}
        
        let contentSize = scrollView.contentSize
        let scrollViewHeight = contentSize.height
        let viewHeight = self.view.frame.height
        
        // added second or check as the table was jerking when trying to pull at the end
        if scrollViewHeight < (viewHeight + visualEffectViewHeight) ||
            (tableViewVertical.contentSize.height - tableViewVertical.contentOffset.y) < view.height {
            return
        }
        
        let contentOffset = scrollView.contentOffset
        let offsetDifference = contentOffset.y - scrollviewInitialYOffset
        if offsetDifference > 0 {
            hideHeaderBlurView(offsetDifference)
        }
        else {
            // hotel list scroll down header jerk fix - Rishabh
            let totalHeight = backContainerView.height + statusBarHeight
            if headerBlurView.frame.maxY == totalHeight {
                return
            }
            // hotel list scroll down header jerk fix end
            let invertedOffset = -offsetDifference
            revealBlurredHeaderView(invertedOffset)
        }
    }
    
    func scrollViewDidScrollToTop(_ scrollView: UIScrollView){
        guard scrollView === tableViewVertical, self.isViewDidAppear else {return}
        showBluredHeaderViewCompleted()
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        guard scrollView === tableViewVertical, self.isViewDidAppear else {return}
        snapToTopOrBottomOnSlowScrollDragging(scrollView)
        //        scrollviewInitialYOffset = 0.0
    }

}
//MARK:- Extension TableView Delegate and DataSource
extension HotelResultVC: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.newsData.isEmpty ? self.setEmptyMessage(self.viewModel.error?.localizedDescription ?? "",isTimeOutError: error?.errorCode == CustomError.timeOut.rawValue) : self.restore()
        switch self.currentShimmerStatus {
        case .toBeApply:
            return 5
        case .applied:
            return self.viewModel.newsData.count
        case .none:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch self.currentShimmerStatus {
        case .toBeApply:
            let cell = tableView.dequeueCell(with: ShimmerCell.self)
            return cell
        case .applied:
            let cell = tableView.dequeueCell(with: NewsTableViewCell.self)
            let cellVM = viewModel.getCellViewModel(at: indexPath)
            cell.cellViewModel = cellVM
            return cell
        case .none:
            let cell = UITableViewCell()
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}
//MARK:- Extension NewsListViewModelDelegate
extension HotelResultVC: NewsListViewModelDelegate{
    func newsListingSuccess() {
        DispatchQueue.main.async {
            self.currentShimmerStatus = .applied
            self.tableViewVertical.reloadData()
        }
    }
    
    func newsListingFailure(error: Error) {
        self.error = error
        DispatchQueue.main.async {
            self.currentShimmerStatus = .none
            self.tableViewVertical.reloadData()
        }
    }
}

extension HotelResultVC{
    func setEmptyMessage(_ message: String,isTimeOutError: Bool = false) {
        // Custom way to add view
//        let frame = CGRect(x: 0, y: 0, width: newsTableView.frame.width, height: newsTableView.frame.height)
//        emptyView?.frame = frame
//        emptyView?.show()
//        newsTableView.backgroundView = emptyView
        var offset:CGFloat = 0
        var bottomOffset = 0.0
        var fakenavHeightRef:CGFloat = 0.0
        if #available(iOS 13.0, *) {
            let window:UIWindow! = UIApplication.shared.keyWindow
                fakenavHeightRef =  fakenavHeightRef + window.safeAreaInsets.top
                bottomOffset =  window.safeAreaInsets.bottom
        }else {
            let window:UIWindow! = UIApplication.shared.keyWindow
            fakenavHeightRef = fakenavHeightRef + window.safeAreaInsets.top
            bottomOffset =  window.safeAreaInsets.bottom
        }
        offset = self.navigationController?.navigationBar.height ?? 0.0
        
        // Custom way to add view
        if emptyViewPersonal != nil {
        } else{
            emptyViewPersonal = nil
            emptyViewPersonal = EmptyView(frame: CGRect(x: 0, y: fakenavHeightRef + offset, width: self.view.frame.width, height: self.view.frame.height -  fakenavHeightRef - offset - bottomOffset), inView: self.view, centered: true, icon: UIImage(named: ""), message: "")
//            emptyViewPersonal?.delegate = self
            emptyViewPersonal?.show()
        }
    }
    
    func restore() {
        tableViewVertical.backgroundView = nil
        emptyViewPersonal?.hide()
    }
}
