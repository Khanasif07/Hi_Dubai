//
//  PlacesAndSuperShesView.swift
//  Hi_Dubai
//
//  Created by Asif Khan on 17/05/2023.
//

import UIKit
import Foundation
protocol PlacesAndSuperShesViewDelegate: NSObject {
    func closeTextFieldAnimation()
}

protocol LocateOnTheMap: NSObject {
    func locateWithLatLong(lon: String, andLatitude lat: String, andAddress address: String)
}

class PlacesAndSuperShesView: UIView {
    
    //MARK:- Enums-
    enum CurrentlyUsingFor {
        case places,supershes
    }
    lazy var viewModel = {
        NewsListViewModel()
    }()
    
    //MARK:- Variables
    //MARK:===========
    var lastContentOffset: CGFloat = 0.0
    internal var screenUsingFor: CurrentlyUsingFor = .places
    internal weak var deleagte: PlacesAndSuperShesViewDelegate?
    
    internal var isScrollEnabled: Bool = false{
        didSet{
            self.dataTableView.isScrollEnabled = isScrollEnabled
        }
    }
    private var lat: String?
    private var long: String?
    internal weak var locationDelegate: LocateOnTheMap?
    internal var currentShimmerStatus: ShimmerState = .applied
    
    //MARK:- IBOutlets
    //MARK:===========
    @IBOutlet weak var dataTableView: UITableView! {
        didSet {
            self.dataTableView.sectionHeaderHeight          = 0.0//CGFloat.zero
            self.dataTableView.sectionFooterHeight          = 0.0//CGFloat.zero
            self.dataTableView.estimatedSectionHeaderHeight = 0.0//CGFloat.zero
            self.dataTableView.estimatedSectionFooterHeight = 0.0//CGFloat.zero
            //
            self.dataTableView.isScrollEnabled = isScrollEnabled
        }
    }
    
    private func footerSetup(){
        let footerView = UIView()
        footerView.frame = CGRect(x: 0, y: 0, width: Int(screen_width), height: Int(90.0))
        footerView.backgroundColor = .clear
        dataTableView.tableFooterView = footerView
    }
    
    
    //MARK:- LifeCycle
    //MARK:===========
    //MARK:- LifeCycle -
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setUpView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setUpView()
    }
    
    //MARK:- Functions
    //MARK:===========
    
    private func setUpView() {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "PlacesAndSuperShesView", bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        view.frame = bounds
        view.backgroundColor = .clear
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.addSubview(view)
        self.configUI()
    }
    
    private func configUI() {
        self.dataTableView.registerCell(with: LoaderCell.self)
        self.dataTableView.registerCell(with: PlacesAndSuperShesViewTableViewCell.self)
        self.dataTableView.delegate = self
        self.dataTableView.dataSource = self
        self.footerSetup()
        //
        self.viewModel.delegate = self
        self.viewModel.getPumpkinListing(page: self.viewModel.currentPage)
    }
}

//MARK:- Extensions- UITableView Delegate and DataSource
extension PlacesAndSuperShesView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.screenUsingFor == .supershes {
            switch self.currentShimmerStatus {
            case .toBeApply:
                return 15
            case .applied:
                return self.viewModel.pumkinsData.count + (self.viewModel.showPaginationLoader ?  1: 0)
            case .none:
                return 15
            }
        }
        return self.viewModel.pumkinsData.count + (self.viewModel.showPaginationLoader ?  1: 0)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch self.screenUsingFor {
        case .places:
            let cell = tableView.dequeueCell(with: PlacesAndSuperShesViewTableViewCell.self, indexPath: indexPath)
            cell.buttonTapped = { [weak self] (btn) in
                guard let `self` = self else { return }
                if self.viewModel.newsData[indexPath.item].isSelected ==  true {
                    self.viewModel.newsData[indexPath.item].isSelected = false
                    self.dataTableView.reloadRows(at: [indexPath], with: .automatic)
                }else{
                    self.viewModel.newsData[indexPath.item].isSelected = true
                    self.dataTableView.reloadRows(at: [indexPath], with: .automatic)
                }
            }
            cell.populateCell(self.viewModel.newsData[indexPath.item])
            return cell
        case .supershes:
            if indexPath.row == (viewModel.pumkinsData.endIndex) {
                let cell = tableView.dequeueCell(with: LoaderCell.self)
                return cell
            }else{
                let cell = tableView.dequeueCell(with: PlacesAndSuperShesViewTableViewCell.self, indexPath: indexPath)
                cell.buttonTapped = { [weak self] (btn)  in
                    guard let `self` = self else { return }
                    if self.viewModel.pumkinsData[indexPath.item].isSelected ==  true {
                        self.viewModel.pumkinsData[indexPath.item].isSelected = false
                        self.dataTableView.reloadRows(at: [indexPath], with: .automatic)
                    }else{
                        self.viewModel.pumkinsData[indexPath.item].isSelected = true
                        self.dataTableView.reloadRows(at: [indexPath], with: .automatic)
                    }
                }
                cell.populatePumpkinCell(self.viewModel.pumkinsData[indexPath.item])
                return cell
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if self.viewModel.pumkinsData[indexPath.item].isSelected ==  true {
            self.viewModel.pumkinsData[indexPath.item].isSelected = false
            self.dataTableView.reloadRows(at: [indexPath], with: .automatic)
        }else{
            self.viewModel.pumkinsData[indexPath.item].isSelected = true
            self.dataTableView.reloadRows(at: [indexPath], with: .automatic)
        }
    }

    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45.0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if cell as? LoaderCell != nil {
            if screenUsingFor == .supershes {
                self.viewModel.getPumpkinListing(page: self.viewModel.currentPage,loader: false,pagination: true)
            }else {
                self.viewModel.getPumpkinListing(page: self.viewModel.currentPage,loader: false,pagination: true)
            }
        }
    }
    
}

//MARK:- enableGlobalScrolling
extension PlacesAndSuperShesView{
    func enableGlobalScrolling(_ offset: CGFloat,_ isSearchHidden: Bool = true) {
        (self.parentViewController?.parent as? NavigationTypeVC)?.enableScrolling(offset,isSearchHidden)
    }
    
    func scrollViewDidScroll(_ scroll: UIScrollView) {
        var scrollDirection: ScrollDirection
        let stopScroll = 50.0
        if lastContentOffset > scroll.contentOffset.y {
            scrollDirection = .down
        } else {
            scrollDirection = .up
        }
        
        let offsetY = scroll.contentOffset.y
    
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


//MARK:- Extension NewsListViewModelDelegate
extension PlacesAndSuperShesView: NewsListViewModelDelegate{
    func pumpkinDataSuccess() {
        DispatchQueue.main.async {
            self.dataTableView.reloadData()
        }
    }
    
    func pumpkinDataFailure(error: Error) {
        DispatchQueue.main.async {
            self.dataTableView.reloadData()
        }
    }
}
