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
    
    //MARK:- Variables
    //MARK:===========
    internal var screenUsingFor: CurrentlyUsingFor = .places
    internal weak var deleagte: PlacesAndSuperShesViewDelegate?
    
    internal var lists: [Record]?{
        didSet{
            self.dataTableView.reloadData()
        }
    }
    
//    var lastPage = -1
    private var placesArray: [String] = []
    
    private var lat: String?
    private var long: String?
    private var addressDetails: String?
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
        }
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
        self.dataTableView.registerCell(with: PlacesAndSuperShesViewTableViewCell.self)
        self.dataTableView.delegate = self
        self.dataTableView.dataSource = self
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
                return lists?.count ?? 0
            case .none:
                return 15
            }
        }
        return lists?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch self.screenUsingFor {
        case .places:
            let cell = tableView.dequeueCell(with: PlacesAndSuperShesViewTableViewCell.self, indexPath: indexPath)
            cell.populateCell(self.lists?[indexPath.item])
            return cell
        case .supershes:
            let cell = tableView.dequeueCell(with: PlacesAndSuperShesViewTableViewCell.self, indexPath: indexPath)
            cell.populateCell(self.lists?[indexPath.item])
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if lists?[indexPath.item].isSelected ==  true {
            lists?[indexPath.item].isSelected = false
        }else{
            lists?[indexPath.item].isSelected = true
        }
//        self.dataTableView.reloadTableView()
    }

    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44.5
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}

