//
//  RecentSearchVC.swift
//  Hi_Dubai
//
//  Created by Asif Khan on 16/06/2023.
//

import UIKit

class RecentSearchVC: UIViewController {
    
    private var placesView: PlacesAndSuperShesView?
    lazy var viewModel = {
        NewsListViewModel()
    }()
    var lastContentOffset: CGFloat = 0.0

    override func viewDidLoad() {
        super.viewDidLoad()
        //
        self.viewModel.delegate = self
        self.viewModel.getNewsListing()
        //
        self.placesView = PlacesAndSuperShesView(frame: CGRect(x: 0.0, y: 0.0, width: screen_width, height: screen_height))
        
        if let placeView = self.placesView {
            placeView.screenUsingFor = .places
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


//MARK:- Extension NewsListViewModelDelegate
extension RecentSearchVC: NewsListViewModelDelegate{
    func newsListingSuccess() {
        DispatchQueue.main.async {
            self.placesView?.lists = self.viewModel.newsData
            self.placesView?.dataTableView.reloadData()
        }
    }
    
    func newsListingFailure(error: Error) {
        DispatchQueue.main.async {
            self.placesView?.lists = self.viewModel.newsData
            self.placesView?.dataTableView.reloadData()
        }
    }
}
