//
//  StatsVC.swift
//  Hi_Dubai
//
//  Created by Asif Khan on 01/05/2023.
//

import UIKit

class StatsVC: UIViewController, EmptyStateViewDelegate {
    func loginAction() {
        self.viewModel.getNewsListing()
    }
    
    func learnHowAction() {
        self.viewModel.getNewsListing()
    }
    
    
    //MARK: - IBOUTLETS
    //==================
    @IBOutlet weak var mainTableView: UITableView!
    internal var containerViewMinY: Float = 0.0
    var lastContentOffset: CGFloat = 0.0
    var emptyViewPersonal: EmptyView?
     var artistSymbol: String = "ARIG"
    lazy var viewModel = {
        NewsListViewModel()
    }()
    
    //MARK: - VIEW LIFE CYCLE
    //==================
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initialSetUp()
    }
    
    
    //MARK: - PRIVATE FUNCTIONS
    //==================
    
    private func initialSetUp() {
        self.tableViewSetUp()
        self.footerViewSetUp()
        self.registerXib()
        self.fetchAPIData()
    }
    
    private func fetchAPIData(){
        self.viewModel.delegate = self
//        self.viewModel.getNewsListing()
    }
    
    private func tableViewSetUp() {
        self.mainTableView.delegate    = self
        self.mainTableView.dataSource  = self
        self.mainTableView.rowHeight = UITableView.automaticDimension
        self.mainTableView.estimatedRowHeight = 300
    }
    
    private func footerViewSetUp() {
//        let footerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: self.view.frame.width, height: 181.0))
//        self.mainTableView.tableFooterView?.height = 181.0
//        self.mainTableView.tableFooterView = footerView
    }
    
    private func registerXib(){
        self.mainTableView.registerCell(with: NewsTableViewCell.self)
    }
    
    
}
//MARK:- TABLEVIEW DELEGATE AND DATA SOURCE
//==================

extension StatsVC : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.newsData.isEmpty ? self.setEmptyMessage(self.viewModel.error?.localizedDescription ?? "") : self.restore()
        return self.viewModel.newsData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        self.tableViewCellForStats(tableView, cellForRowAt: indexPath)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.tableViewHeightForStats(tableView, heightForRowAt: indexPath)
    }
    
    //Internal functions
    internal  func tableViewCellForStats(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueCell(with: NewsTableViewCell.self)
        let cellVM = viewModel.getCellViewModel(at: indexPath)
        cell.cellViewModel = cellVM
        return cell
    }
    
    internal func tableViewHeightForStats(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
           return UITableView.automaticDimension
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        let touch = touches.first!
        let location = touch.location(in: self.view)
       // self.yPos = location.y
    }
    
}

//MARK:- Extension NewsListViewModelDelegate
extension StatsVC: NewsListViewModelDelegate{
    func newsListingSuccess() {
        DispatchQueue.main.async {
            self.mainTableView.reloadData()
        }
    }
    
    func newsListingFailure(error: Error) {
        DispatchQueue.main.async {
            self.mainTableView.reloadData()
        }
    }
}

extension StatsVC{
    func setEmptyMessage(_ message: String,isTimeOutError: Bool = true) {
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
        if emptyViewPersonal != nil {
        } else{
            emptyViewPersonal = nil
            emptyViewPersonal = EmptyView(frame: CGRect(x: 0, y: fakenavHeightRef + offset, width: self.view.frame.width, height: self.view.frame.height -  fakenavHeightRef - offset - bottomOffset), inView: self.view, centered: true, icon: UIImage(named: ""), message: "")
            emptyViewPersonal?.delegate = self
            emptyViewPersonal?.show()
        }
        
    }
    
    @objc func retryBtnTapped(){
        print("retry btn tapped.")
        self.fetchAPIData()
    }
    
    func restore() {
        mainTableView.backgroundView = nil
        emptyViewPersonal?.hide()
    }
}


extension StatsVC{
    func enableGlobalScrolling(_ offset: CGFloat,_ isSearchHidden: Bool = true) {
        (self.parent as? HomeViewController)?.enableScrolling(offset,isSearchHidden)
        (self.parent?.parent?.parent as? HomeViewController)?.enableScrolling(offset,isSearchHidden)
        
    }
    
    func scrollViewDidScroll(_ scroll: UIScrollView) {
        var scrollDirection: ScrollDirection
        
        if lastContentOffset > scroll.contentOffset.y {
            scrollDirection = .down
        } else {
            scrollDirection = .up
        }
        
        let offsetY = scroll.contentOffset.y
        var stopScroll: CGFloat = 235.0
        
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
    }
}

