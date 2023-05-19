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
    
//    internal var viewModel = PlacesAndSuperShesVM()
    
//    var lastPage = -1
    private var placesArray: [String] = []
    
    private var lat: String?
    private var long: String?
    private var addressDetails: String?
    internal var placeIDArray = [String]()
    internal var resultsArray = [String]()
    internal var primaryAddressArray = [String]()
    internal var searchResults = [String]()
    internal var searhPlacesName = [String]()
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
//        self.viewModel.delegate = self
        self.dataTableView.registerCell(with: PlacesAndSuperShesViewTableViewCell.self)
//        self.dataTableView.registerCell(with: PlacesTableViewCell.self)
        self.dataTableView.delegate = self
        self.dataTableView.dataSource = self
    }
    
//    internal func hitApi(text: String, page: Int? = nil) {
////        if self.currentShimmerStatus == .toBeApply {
////            self.viewModel.dataModel.data = []
////            self.shimmerSetUp()
////        }
//
////        if !self.viewModel.didTapCluster {
////            self.viewModel.clusterLat = 0.0
////            self.viewModel.clusterLong = 0.0
////            self.viewModel.didTapCluster = false
////        }
//
//        if self.currentShimmerStatus == .toBeApply {
////            delay(delay: 0.25) { [weak self] in
////                self?.getData(text: text, page: 0)
////            }
//        }
//        else {
////            if self.viewModel.lastPage == -1 {
////                self.getData(text: text, page: 0)
////            } else {
////                self.getData(text: text, page: page)
////            }
//        }
//    }
    
//    public func getData(text: String, page: Int?) {
//        self.viewModel.getSuperShesUsers(text: text, page: page)
//    }
    
//    private func shimmerSetUp() {
//        self.dataTableView.reloadData()
//        self.dataTableView.addShimmerOnTableViewWithTotalCells()
//    }
    
    
//    internal func emptyStateForPlaces() {
//        if self.screenUsingFor == .places, self.resultsArray.count == 0 {
//            self.layoutIfNeeded()
//            self.dataTableView.setEmptyMessage("", heading: "Search Places".uppercased(), image: #imageLiteral(resourceName: "group16"), textColor: AppColors.superWhite, headingColor:  AppColors.superWhite, imageWidth: 127.0, imageHeight:  100.0, isScreenSpecific: true)
//        }
//    }
    
    //function for autocomplete
//    internal func placeAutocompleteApi(placeName: String) {
//        let filter = GMSAutocompleteFilter()
//        let placesClient = GMSPlacesClient()
//        filter.type = .establishment
//
//        placesClient.autocompleteQuery(placeName, bounds: nil, filter: filter) { [weak self] (results, error) -> Void in
//            guard let sSelf = self else { return }
//            sSelf.placeIDArray.removeAll() //array that stores the place ID
//            sSelf.resultsArray.removeAll() // array that stores the results obtained
//            sSelf.primaryAddressArray.removeAll() //array storing the primary address of the place.
//            if let error = error {
//                sSelf.emptyStateForPlaces()
//                printDebug("Autocomplete error \(error)")
//                return
//            }
//            if let results = results {
//                for result in results {
//                    sSelf.primaryAddressArray.append(result.attributedPrimaryText.string)
//                    sSelf.resultsArray.append(result.attributedFullText.string)
//                    sSelf.primaryAddressArray.append(result.attributedPrimaryText.string)
//                    sSelf.placeIDArray.append(result.placeID)
//                }
//            }
//            if sSelf.screenUsingFor == .places {
//                sSelf.dataTableView.restore()
//            }
//            printDebug("\(sSelf.resultsArray)\n\(sSelf.primaryAddressArray)\n\(sSelf.placeIDArray)")
//            sSelf.searchResults = sSelf.resultsArray
//            sSelf.searhPlacesName = sSelf.primaryAddressArray
//            if sSelf.searhPlacesName.count == 0 {
//                sSelf.emptyStateForPlaces()
//            }else {
//                sSelf.dataTableView.restore()
//            }
//            sSelf.dataTableView.reloadData()
//        }
//    }
    
    /// call to clear all place view data
//    internal func clearSuperSheViewData() {
//        self.viewModel.dataModel.data.removeAll()
//
//        self.currentShimmerStatus = .none
//        self.dataTableView.reloadData()
//        self.viewModel.clusterLat = 0.0
//        self.viewModel.clusterLong = 0.0
//        self.viewModel.distance = 0.0
//        self.viewModel.didTapCluster = false
//        self.dataTableView.reloadData()
//    }
    
    /// call to clear all place view data
//    internal func clearPlaceViewData() {
//        self.placeIDArray.removeAll() //array that stores the place ID
//        self.resultsArray.removeAll() // array that stores the results obtained
//        self.primaryAddressArray.removeAll() //array storing the primary address of the place.
//        self.searchResults.removeAll()
//        self.searhPlacesName.removeAll()
//        self.dataTableView.reloadData()
//        self.emptyStateForPlaces()
//    }
    
    
    //MARK:- IBActions
    //MARK:===========
}

//MARK:- Extensions- UITableView Delegate and DataSource
extension PlacesAndSuperShesView: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.screenUsingFor == .supershes {
            
            switch self.currentShimmerStatus {
                
            case .toBeApply:
                return 15
            case .applied:
                return 15
            case .none:
                return 15
            }
        }
        return 15
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch self.screenUsingFor {
        case .places:
            let cell = tableView.dequeueCell(with: PlacesAndSuperShesViewTableViewCell.self, indexPath: indexPath)
//            cell.configureCell(placeName: self.searchResults[indexPath.row])
            return cell
        case .supershes:
//            if indexPath.row == self.viewModel.dataModel.data.count - 1, self.viewModel.lastPage != -1 {
//                self.currentShimmerStatus = .applied
//                self.hitApi(text: "", page: nil)
//            }
            let cell = tableView.dequeueCell(with: PlacesAndSuperShesViewTableViewCell.self, indexPath: indexPath)
//            cell.delegate = self
//            cell.locationName.isHidden = !self.viewModel.didTapCluster
//            if self.viewModel.dataModel.data.count > 0, currentShimmerStatus == .applied {
//                let loc: String = self.viewModel.didTapCluster ? self.viewModel.dataModel.data[indexPath.row].locCity + ", " + self.viewModel.dataModel.data[indexPath.row].locCountry : ""
//                cell.configureCell(model: self.viewModel.dataModel.data[indexPath.row], location: loc)
//            }
            return cell
        }
    }
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//
//        switch self.screenUsingFor {
//        case .places:
//            guard let correctedAddress = self.resultsArray[indexPath.row].addingPercentEncoding(withAllowedCharacters: .symbols) else {
//                return
//            }
//
//            let urlString =  "https://maps.googleapis.com/maps/api/geocode/json?address=\(correctedAddress)&sensor=false&key=\(AppGlobals.shared.googleApiKey)"
//
//            guard let url = URL(string: urlString) else { break }
//
//            Alamofire.request(url, method: .get, headers: nil)
//                .validate()
//                .responseJSON { (response) in
//                    switch response.result {
//                    case.success(let value):
//                        let json = JSON(value)
//                        printDebug(json)
//
//                        let lat = json["results"][0]["geometry"]["location"]["lat"].rawString()
//                        let lng = json["results"][0]["geometry"]["location"]["lng"].rawString()
//                        let formattedAddress = json["results"][0]["formatted_address"].rawString()
//
//                        self.lat = lat
//                        self.long = lng
//                        self.addressDetails = formattedAddress
//
//                        printDebug("\(lat ?? ""),\(lng ?? ""),\(formattedAddress ?? "")")
//                        self.locationDelegate?.locateWithLatLong(lon: self.long ?? "", andLatitude: self.lat ?? "", andAddress: formattedAddress ?? "")
//                    case.failure(let error):
////                        self.emptyStateForPlaces()
//                        printDebug("\(error.localizedDescription)")
//                    }
//            }
//        case .supershes:
//            if let cell = tableView.cellForRow(at: indexPath) as? PlacesAndSuperShesViewTableViewCell {
//                Router.shared.goToUserProfile(userId: self.viewModel.dataModel.data[indexPath.row].id, placeHolderImage: cell.profileImageView?.image, userModel: self.viewModel.dataModel.data[indexPath.row])
//            }
//        }
//    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44.5
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}


//extension PlacesAndSuperShesView: PlacesAndSuperShesVMDelegate {
//
////    func superShesGetData(isFirstPage: Bool) {
////        if self.currentShimmerStatus == .toBeApply {
////            //            isRemoveImgBg = true
////            self.dataTableView.removeShimmerOnTableViewWithTotalCells()
////        }
////        self.currentShimmerStatus = .applied
////        if self.screenUsingFor == .supershes, self.viewModel.dataModel.data.count == 0 {
////            self.dataTableView.setEmptyMessage("", heading: "NO SUPERSHES FOUND!".uppercased(), image: #imageLiteral(resourceName: "group999"), textColor: AppColors.superWhite, headingColor:  AppColors.superWhite, imageWidth: 127.0, imageHeight: 100.0, isScreenSpecific: true)
////        } else {
////            self.dataTableView.restore()
////        }
////        self.screenUsingFor = .supershes
////        self.dataTableView.reloadData()
////    }
//
////    func superShesDidFailedToGetData(_ msg: String,errorType: ErrorType) {
////        if self.currentShimmerStatus == .toBeApply {
////            //            isRemoveImgBg = true
////            self.dataTableView.removeShimmerOnTableViewWithTotalCells()
////            if self.viewModel.lastPage > 1 {
////                self.currentShimmerStatus = .applied
////            } else {
////                self.currentShimmerStatus = .none
////            }
////        }
////        if self.screenUsingFor == .supershes {
////
////            dataTableView.setEmptyMessage(msg, retry: true, retryAction: {[weak self] in
////                if self?.currentShimmerStatus != .toBeApply {
////                   self?.currentShimmerStatus = .toBeApply
////                   self?.shimmerSetUp()
////                }
////
////                }, errorType: errorType)
//////            self.dataTableView.setEmptyMessage("", heading: " There is no internet connection!".uppercased(), image: #imageLiteral(resourceName: "oops"), textColor: AppColors.superWhite, headingColor:  AppColors.superWhite, imageWidth: 127.0, imageHeight: 100.0, isScreenSpecific: true)
////        } else {
////            self.dataTableView.restore()
////        }
////        self.dataTableView.reloadData()
////    }
//}

//extension PlacesAndSuperShesView: PlacesAndSuperShesViewTableViewCellDelegate {
//
////    func chatWithUser(forIndex indexPath: IndexPath) {
////        // open chat conversation Screen
////        guard UserModel.main.id != self.viewModel.dataModel.data[indexPath.row].id else { return }
////        self.parentViewController?.view.endEditing(true)
////
////        let fireUser = FireUserModel.init(qid: self.viewModel.dataModel.data[indexPath.row].qBloxId, fireUserFullName: /self.viewModel.dataModel.data[indexPath.row].fullName, fireUserId: /self.viewModel.dataModel.data[indexPath.row].id, fireUserProfilePic: /self.viewModel.dataModel.data[indexPath.row].profilePicture)
////
////        FireUserModel.main.findOrCreateSingleChatRoom(with: fireUser) { (room) in
////            Router.shared.navigate(to: ChatVC.self, storyboard: .Chat, action: .push, navigationController: .current) { () -> ChatVC.RequiredParams in
////                return (room , .recentSearch, self.viewModel.dataModel.data[indexPath.row].locCity + "," + self.viewModel.dataModel.data[indexPath.row].locCountry )
////            }
////        }
////    }
//
////    func openProfileVC(forIndex indexPath: IndexPath,image: UIImage) {
////        self.parentViewController?.view.endEditing(true)
////
////        if UserModel.main.id == self.viewModel.dataModel.data[indexPath.row].id {
////            Router.shared.navigate(to: MyProfileVC.self, storyboard: .SuperYou, action: .push, navigationController: .current) {() -> MyProfileVC.RequiredParams in
////                return
////            }
////        }
////        else {
////            Router.shared.navigate(to: OtherUserProfileVC.self, storyboard: .Chat, action: .push, navigationController: .current) { () -> OtherUserProfileVC.RequiredParams in
////                return (ChatRoomModel(), /self.viewModel.dataModel.data[indexPath.row].id,nil,image,self.viewModel.dataModel.data[indexPath.row])
////            }
////        }
////    }
//}
