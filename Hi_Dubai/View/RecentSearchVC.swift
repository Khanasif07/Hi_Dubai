//
//  RecentSearchVC.swift
//  Hi_Dubai
//
//  Created by Asif Khan on 16/06/2023.
//

import UIKit

class RecentSearchVC: UIViewController {
    
    internal var placesView: PlacesAndSuperShesView?
    lazy var viewModel = {
        NewsListViewModel()
    }()
    var lastContentOffset: CGFloat = 0.0

    override func viewDidLoad() {
        super.viewDidLoad()
        //
        self.view.backgroundColor = .black
        //
        self.placesView = PlacesAndSuperShesView(frame: CGRect(x: 0.0, y: 0.0, width: screen_width, height: screen_height))
        self.placesView?.isScrollEnabled = true
        if let placeView = self.placesView {
            placeView.screenUsingFor = .supershes
            self.view.addSubview(placeView)
        }

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        placesView?.dataTableView.reloadData()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.placesView?.frame = CGRect(x: 0.0, y: 0.0, width: screen_width, height: screen_height)
    }

}


////MARK:- Extension NewsListViewModelDelegate
//extension RecentSearchVC: NewsListViewModelDelegate{
//    func pumpkinDataSuccess() {
//        DispatchQueue.main.async {
//            self.placesView?.punmkinLists = self.viewModel.pumkinsData
//            self.placesView?.dataTableView.reloadData()
//        }
//    }
//    
//    func pumpkinDataFailure(error: Error) {
//        DispatchQueue.main.async {
//            self.placesView?.dataTableView.reloadData()
//        }
//    }
//}
