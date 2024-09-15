//
//  NewsDiscoverVC.swift
//  Hi_Dubai
//
//  Created by Asif Khan on 17/06/2023.
//
import UIKit

class NewsDiscoverVC: UIViewController {
    //MARK:- IBoutlets
    
    @IBOutlet weak var statusBarHC: NSLayoutConstraint!
    @IBOutlet weak var statusBar: UIView!
    @IBOutlet weak var sectionCollView: UICollectionView!
    @IBOutlet weak var sectionHeaderView: UIView!
    @IBOutlet var businessHeader: UIView!
    @IBOutlet weak var newsTableView: UITableView!
    //MARK:- IBProperties
    var isScrollingTrue: Bool = true
    lazy var viewModel = {
        NewsListViewModel()
    }()
    var emptyView: EmptyStateView? = EmptyStateView.instanciateFromNib()
    var emptyViewPersonal: EmptyView?
    var loadingView: LoadingView?
    var isHitApiInProgress: Bool = true
   
    internal var selectedCell: NewsTableViewCell?
    internal var selectedCellImageViewSnapshot: UIView?
    internal var animator: Animator?
    private var indexPath: IndexPath?
    internal var currentShimmerStatus: ShimmerState = .toBeApply
    var error: Error?
    
    //
//    var stopScroll = 80.0
    internal var containerViewMinY: Float = 0.0
    var lastContentOffset: CGFloat = 0.0
    internal var headerTitle: String = "POPULAR BUSINESS"
    //MARK:- ViewLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initialSetup()
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        newsTableView.isScrollEnabled = true
        //
        if #available(iOS 15.0, *) {
            newsTableView.sectionHeaderTopPadding = 0.0
        }
        if #available(iOS 12.0, *) {
            if traitCollection.userInterfaceStyle == .light {
                businessHeader.layer.shadowColor = UIColor(white: 0.0, alpha: 0.3).cgColor
                businessHeader.layer.shadowOffset = CGSize(width: 0.0, height: 3.0)
                businessHeader.layer.shadowOpacity = 1.0
                businessHeader.layer.shadowRadius = 3.0
            } else {
                businessHeader.layer.shadowColor = UIColor(white: 1.0, alpha: 0.3).cgColor
                businessHeader.layer.shadowOffset = CGSize(width: 0.0, height: 3.0)
                businessHeader.layer.shadowOpacity = 1.0
                businessHeader.layer.shadowRadius = 3.0
            }
        }else {
            businessHeader.layer.shadowColor = UIColor(white: 0.0, alpha: 0.3).cgColor
            businessHeader.layer.shadowOffset = CGSize(width: 0.0, height: 3.0)
            businessHeader.layer.shadowOpacity = 1.0
            businessHeader.layer.shadowRadius = 3.0
        }
        businessHeader.backgroundColor = UIColor(named: "lightWhiteBlack")
        statusBar.backgroundColor = UIColor(named: "lightWhiteBlack")
        //
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .darkContent
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
        if let indexPath = indexPath{
            self.newsTableView.reloadRows(at: [indexPath], with: .automatic)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        newsTableView.isScrollEnabled = isScrollingTrue
    }
    
    private func  initialSetup(){
        self.statusBarHC.constant = statusBarHeight
        self.setUpTableView()
        self.configureUI()
        //
        loadingView = LoadingView(frame: view.frame, inView: view)
        loadingView?.show()
        //
        self.viewModel.delegate = self
        self.emptyViewPersonal?.delegate = self
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5, execute: {
            self.fetchAPIData()
        })
    }
    private func setUpTableView(){
        self.newsTableView.delegate = self
        self.newsTableView.dataSource = self
        self.newsTableView.separatorColor = .clear
        self.newsTableView.separatorStyle = .none
        self.newsTableView.registerCell(with: NewsTableViewCell.self)
        self.newsTableView.registerCell(with: ShimmerCell.self)
        self.headerSetup()
    }
    
    private func headerSetup(){
        let parallexHeaderHeight = 88.0
        self.businessHeader.frame = CGRect(x: 0, y: 0, width: Int(screen_width), height: Int(parallexHeaderHeight))
        self.businessHeader.isUserInteractionEnabled = true
        self.newsTableView.tableHeaderView = self.businessHeader
    }
    
    private func fetchAPIData(){
        self.isHitApiInProgress = true
        self.emptyView?.hide()
        self.currentShimmerStatus = .toBeApply
        self.newsTableView.reloadData()
        self.viewModel.getNewsListing()
    }
}

//MARK:- Extension TableView Delegate and DataSource
extension NewsDiscoverVC: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.newsData.isEmpty ? self.setEmptyMessage(self.viewModel.error?.localizedDescription ?? "",isTimeOutError: error?.errorCode == CustomError.timeOut.rawValue) : self.restore()
        switch self.currentShimmerStatus {
        case .toBeApply:
            return 0
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

    func tableView(_ tableView: UITableView, didHighlightRowAt indexPath: IndexPath){
        let cell = tableView.cellForRow(at: indexPath)
        UIView.animate(withDuration: 0.25) {
            cell?.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        }
    }

    func tableView(_ tableView: UITableView, didUnhighlightRowAt indexPath: IndexPath){
        let cell = tableView.cellForRow(at: indexPath)
        UIView.animate(withDuration: 0.25) {
            cell?.transform = .identity
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return sectionHeaderView.frame.size.height
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return sectionHeaderView
    }
}

//MARK:- Extension NewsListViewModelDelegate
extension NewsDiscoverVC: NewsListViewModelDelegate{
    func newsListingSuccess() {
        self.isHitApiInProgress = false
        DispatchQueue.main.async {
            self.loadingView?.hide()
            self.loadingView?.removeFromSuperview()
            self.currentShimmerStatus = .applied
            self.newsTableView.reloadData()
            self.sectionCollView.reloadData()
        }
    }
    
    func newsListingFailure(error: Error) {
        self.isHitApiInProgress = false
        self.error = error
        DispatchQueue.main.async {
            self.currentShimmerStatus = .none
            self.newsTableView.reloadData()
        }
    }
}


extension NewsDiscoverVC{
    func setEmptyMessage(_ message: String = "",isTimeOutError: Bool = false) {
        // Custom way to add view
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
        if emptyViewPersonal == nil && !isHitApiInProgress{
            emptyViewPersonal?.removeFromSuperview()
            emptyViewPersonal = EmptyView(frame: CGRect(x: 0, y: fakenavHeightRef + offset, width: self.view.frame.width, height: self.view.frame.height -  fakenavHeightRef - offset - bottomOffset), inView: self.view, centered: true, icon: UIImage(named: ""), message: "")
            emptyViewPersonal?.delegate = self
            emptyViewPersonal?.show()
        }
    }
    
    func restore() {
        newsTableView.backgroundView = nil
        emptyViewPersonal?.hide()
        emptyViewPersonal?.removeFromSuperview()
        
    }
}


extension NewsDiscoverVC{
    func enableGlobalScrolling(_ offset: CGFloat,_ isSearchHidden: Bool = true) {
        (self.parent as? SearchVC)?.enableScrolling(offset,isSearchHidden)
//        (self.parent?.parent?.parent?.parent as? HomeVCC)?.enableScrolling(offset,isSearchHidden)
    }
    
    func scrollViewDidScroll(_ scroll: UIScrollView) {
        var scrollDirection: ScrollDirection
        var stopScroll = 80.0
        if lastContentOffset > scroll.contentOffset.y {
            scrollDirection = .down
        } else {
            scrollDirection = .up
        }
        
        let offsetY = scroll.contentOffset.y
        
        if UIDevice.current.hasNotch{
            stopScroll += 10.0
        }
        lastContentOffset = scroll.contentOffset.y
        
        if scrollDirection == .up {
            if offsetY < stopScroll {
                enableGlobalScrolling(offsetY)
            } else {
                enableGlobalScrolling(stopScroll,false)
            }
        } else if (scrollDirection == .down) && (offsetY < stopScroll) {
            enableGlobalScrolling(offsetY)
        }
        
        //        if !isShowingLatest {
        //            let currentOffset = Int(scroll.contentOffset.y)
        //            let maximumOffset = Int(scroll.contentSize.height - scroll.frame.size.height)
        //            if Double(maximumOffset - currentOffset) <= 80.0 && ((pageToDownload?.intValue ?? 0) + 1) * Int(ITEMS_PER_PAGE) == (searchResults?.count ?? 0) {
        //                pageToDownload = NSNumber(value: (pageToDownload?.intValue ?? 0) + 1)
        //                getData()
        //            }
        //        }
    }
}

extension NewsDiscoverVC: EmptyStateViewDelegate{
    func loginAction() {
        self.setEmptyMessage()
        self.fetchAPIData()
    }
    
    func learnHowAction() {
        self.setEmptyMessage()
        self.fetchAPIData()
    }
    
    //Grouped BY:-
}


extension NewsDiscoverVC: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    private func configureUI() {
        self.sectionCollView.registerCell(with: MenuItemCollectionCell.self)
        self.sectionCollView.delegate = self
        self.sectionCollView.dataSource = self
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        self.sectionCollView.collectionViewLayout = layout
    }
    
    private func getCategoriesCell(_ collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueCell(with: MenuItemCollectionCell.self, indexPath: indexPath)
        cell.populateSectionCell(model: self.viewModel.newsData[indexPath.row],index: indexPath.row)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewModel.newsData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //
        let cell = collectionView.cellForItem(at: indexPath)
        //
        UIView.animate(withDuration: 0.3, delay: 0.1, options: .curveEaseOut, animations: {
            cell?.layer.zPosition = 1
            cell?.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
        }, completion: {_ in
            cell?.layer.zPosition = -1
            cell?.transform =  CGAffineTransform.identity
        })
        //
        if let indexx = self.viewModel.newsData.firstIndex(where: {$0.isSelected ?? false}){
            self.viewModel.newsData[indexx].isSelected = false
            self.sectionCollView.reloadItems(at: [IndexPath(item: indexx, section: 0)])
        }
        self.viewModel.newsData[indexPath.item].isSelected = true
        self.sectionCollView.reloadItems(at: [indexPath])
    }
    
    func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
//        let cell = collectionView.cellForItem(at: indexPath)
//        UIView.animate(withDuration: 0.3) {
//            cell?.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
//        }
    }

    func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
//        let cell = collectionView.cellForItem(at: indexPath)
//        UIView.animate(withDuration: 0.3) {
//            cell?.transform = .identity
//        }
    }
 
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            return self.getCategoriesCell(collectionView, indexPath: indexPath)
    }
    
//    func collectionView(_ collectionView: UICollectionView, contextMenuConfigurationForItemAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        
//        let config = UIContextMenuConfiguration(
//            identifier: nil,
//            previewProvider: nil) { [weak self] _ in
//                let downloadAction = UIAction(title: "Download", subtitle: nil, image: nil, identifier: nil, discoverabilityTitle: nil, state: .off) { _ in
////                    self?.downloadTitleAt(indexPath: indexPath)
//                }
//                return UIMenu(title: "", image: nil, identifier: nil, options: .displayInline, children: [downloadAction])
//            }
//
//        return config
//    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            return cardSizeForCategoriesItemAt(collectionView, layout: collectionViewLayout, indexPath: indexPath)
    }
    
    private func cardSizeForCategoriesItemAt(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, indexPath: IndexPath) -> CGSize {
        let dataSource = self.viewModel.newsData[indexPath.item].primaryTag
        let textSize = "\(dataSource)".sizeCount(withFont: AppFonts.BoldItalic.withSize(12.0), boundingSize: CGSize(width: 10000.0, height: 40.0))
        return CGSize(width: textSize.width + 50.0, height: 40.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
            return 9.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
            return 10.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        var paddingInset: CGFloat = 0.0
        paddingInset = 9.0
        return UIEdgeInsets(top: 0, left: paddingInset, bottom: 0, right: paddingInset)
    }
}
