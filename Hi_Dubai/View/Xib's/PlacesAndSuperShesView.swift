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

//MARK:- Enums-
enum CurrentlyUsingFor {
    case places,supershes,searchMovie, categories
}

class PlacesAndSuperShesView: UIView {
    
    var searchValue: String = ""
    lazy var viewModel = {
        NewsListViewModel()
    }()
    
    //MARK:- Variables
    //MARK:===========
    var hiddenSections = Set<Int>()
    private var tableCellIndexArr: [IndexPath] = []
    var animals: [Animal] = Bundle.main.decode("animals.json")
    var lastContentOffset: CGFloat = 0.0
    internal var screenUsingFor: CurrentlyUsingFor = .categories
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
//            self.dataTableView.sectionHeaderHeight          = 0.0//CGFloat.zero
//            self.dataTableView.sectionFooterHeight          = 0.0//CGFloat.zero
//            self.dataTableView.estimatedSectionHeaderHeight = 0.0//CGFloat.zero
//            self.dataTableView.estimatedSectionFooterHeight = 0.0//CGFloat.zero
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
        self.dataTableView.registerCell(with: TitleTableViewCell.self)
        self.dataTableView.registerCell(with: PlacesAndSuperShesViewTableViewCell.self)
        self.dataTableView.registerHeaderFooter(with: CategoriesSectionView.self)
        self.dataTableView.delegate = self
        self.dataTableView.dataSource = self
        if screenUsingFor != .categories {
            self.footerSetup()
            self.viewModel.delegate = self
        }else{
            if #available(iOS 15.0, *) {
                self.dataTableView.sectionHeaderTopPadding = 10.0
            }
        }
    }
    
    public func hitApi(_ search: String = ""){
        switch screenUsingFor{
        case .places:
            self.viewModel.getPumpkinListing(page: 1)
        case .supershes:
            self.viewModel.getPumpkinListing(page: 1)
        case .searchMovie:
            self.viewModel.getMovieListing(page: 1, search: searchValue)
        case .categories:
            print("Categories")
            self.dataTableView.reloadData()
        }
    }
}

//MARK:- Extensions- UITableView Delegate and DataSource
extension PlacesAndSuperShesView: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        switch self.screenUsingFor {
        case .supershes,.places:
            return 1
        case .searchMovie:
            return 1
        default:
            return animals.count
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch self.screenUsingFor {
        case .supershes,.places:
            return self.viewModel.pumkinsData.count + (self.viewModel.showPaginationLoader ?  1 : 0)
        case .searchMovie:
            return (self.viewModel.moviesResponse?.results.count ?? 0) + (self.viewModel.showPaginationLoader ?  1 : 0)
        default:
            if !self.hiddenSections.contains(section) {
                return 0
            }
            return  animals[section].gallery.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch self.screenUsingFor {
        case .places:
            if indexPath.row == (viewModel.pumkinsData.endIndex) {
                let cell = tableView.dequeueCell(with: LoaderCell.self)
                return cell
            }else {
                let cell = tableView.dequeueCell(with: PlacesAndSuperShesViewTableViewCell.self, indexPath: indexPath)
                cell.buttonTapped = { [weak self] (btn) in
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
        case .searchMovie:
            if indexPath.row == (self.viewModel.moviesResponse?.results.endIndex ?? 0) {
                let cell = tableView.dequeueCell(with: LoaderCell.self)
                return cell
            }else{
                let cell = tableView.dequeueCell(with: PlacesAndSuperShesViewTableViewCell.self, indexPath: indexPath)
                cell.buttonTapped = { [weak self] (btn)  in
                    guard let `self` = self else { return }
                    if self.viewModel.moviesResponse?.results[indexPath.item].isSelected ==  true {
                        self.viewModel.moviesResponse?.results[indexPath.item].isSelected = false
                        self.dataTableView.reloadRows(at: [indexPath], with: .automatic)
                    }else{
                        self.viewModel.moviesResponse?.results[indexPath.item].isSelected = true
                        self.dataTableView.reloadRows(at: [indexPath], with: .automatic)
                    }
                }
                cell.populateMovieCell(self.viewModel.moviesResponse?.results[indexPath.item])
                return cell
            }
        case .categories:
            let cell = tableView.dequeueCell(with: TitleTableViewCell.self, indexPath: indexPath)
            cell.isLastRow = ((animals[indexPath.section].gallery.count - 1) == indexPath.row)
            cell.titleLbl.text = animals[indexPath.section].gallery[indexPath.row]
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch screenUsingFor{
        case .supershes,.places:
            if self.viewModel.pumkinsData[indexPath.item].isSelected ==  true {
                self.viewModel.pumkinsData[indexPath.item].isSelected = false
                self.dataTableView.reloadRows(at: [indexPath], with: .automatic)
            }else{
                self.viewModel.pumkinsData[indexPath.item].isSelected = true
                self.dataTableView.reloadRows(at: [indexPath], with: .automatic)
            }
        case .searchMovie:
            if let id = self.viewModel.moviesResponse?.results[indexPath.item].id{
                self.viewModel.getMovieDetail(path: String(id))
            }
        case .categories:
            print("Categories")
        }
    }
    
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return screenUsingFor != .categories ? 85 : 35.0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return screenUsingFor != .categories ? 85 : 35.0
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "CategoriesSectionView") as? CategoriesSectionView {
            headerView.isRowShow    = !self.hiddenSections.contains(section)
            headerView.buttonTapped = { [weak self] (btn) in
                guard let `self` = self else { return }
                self.hideSection(sender: btn,section: section)
            }
            headerView.titleLbl.text = animals[section].name
            return headerView
        }
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat.leastNonzeroMagnitude
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForFooterInSection section: Int) -> CGFloat {
        return CGFloat.leastNonzeroMagnitude
    }
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 54.0
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat.leastNonzeroMagnitude
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        switch screenUsingFor{
        case .supershes,.places:
            if cell as? LoaderCell != nil {
                if screenUsingFor == .supershes {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.5, execute: {
                        self.viewModel.getPumpkinListing(page: self.viewModel.currentPage,loader: false,pagination: true)
                    })
                    
                }else {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.5, execute: {
                        self.viewModel.getPumpkinListing(page: self.viewModel.currentPage,loader: false,pagination: true)
                    })
                }
            }
        case .searchMovie:
            if cell as? LoaderCell != nil {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.5, execute: {
                    self.viewModel.getMovieListing(page: self.viewModel.currentPage,loader: false,pagination: true,search: self.searchValue)
                })
            }
        case .categories:
            print("Categories")
        }
    }
    
    private func hideSection(sender: UIButton,section: Int) {
        if self.hiddenSections.contains(section) {
            self.hiddenSections.remove(section)
            self.dataTableView.reloadSections([section], with: .automatic)
        } else {
            self.hiddenSections.insert(section)
            self.dataTableView.reloadSections([section], with: .automatic)
        }
    }
}
    


//MARK:- enableGlobalScrolling
extension PlacesAndSuperShesView{
    func enableGlobalScrolling(_ offset: CGFloat,_ isSearchHidden: Bool = true) {
//        (self.parentViewController?.parent as? NavigationTypeVC)?.enableScrolling(offset,isSearchHidden)
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
    
    func movieDataSuccess() {
        DispatchQueue.main.async {
            self.dataTableView.reloadData()
        }
    }
    
    func movieDataFailure(error: Error) {
        DispatchQueue.main.async {
            self.dataTableView.reloadData()
        }
    }
    
    func movieDetailSuccess() {
        let secondVC = NewsDetailVC.instantiate(fromAppStoryboard: .Main)
        secondVC.isBackBtnShow = true
        DispatchQueue.main.async {
            secondVC.modalPresentationStyle = .overCurrentContext
            secondVC.viewModel.movie = self.viewModel.moviesDetail
            (self.parentViewController?.parent as? NavigationTypeVC)?.present(secondVC, animated: true)
            (self.parentViewController?.parent as? SuperYouHomeVC)?.present(secondVC, animated: true)
        }
    }
    
    func movieDetailFailure(error: Error) {
        DispatchQueue.main.async {
            self.dataTableView.reloadData()
        }
    }
}
