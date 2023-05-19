//
//  SuperViewCardTableViewCell.swift
//  Hi_Dubai
//
//  Created by Asif Khan on 17/05/2023.
//

import UIKit
class SuperViewCardTableViewCell: UITableViewCell {
    
    enum CellContents {
        case cardCell , upcomingCell, liveClassesCell, favoritesCell, mostLovedClassesCell, newSuperSheCell, featuredCell,categories, pastLive
    }
    
    //MARK:- Variables
    var cardData: SuperYouCardData? = SuperYouCardData()
    var currentCell: CellContents = .cardCell
    var superYouData: SuperYouHomeModel?
    var myProfileData: MyProfileModel?
    private var inviteImgArray: [UIImage] = [#imageLiteral(resourceName: "filter"),#imageLiteral(resourceName: "filter"),#imageLiteral(resourceName: "filter")]
    var shimmerStatus: ShimmerState = .applied
    private var itemWidth: CGFloat = 0.0
    private var currentItem: Int = 0
    
    //MARK:- IBOutlets
    @IBOutlet weak var cardCollectionView: UICollectionView!
    @IBOutlet weak var cardCollectionViewTopCons: NSLayoutConstraint!
    @IBOutlet weak var cardCollectionViewBottomCons: NSLayoutConstraint!
    @IBOutlet weak var pageControl: UIPageControl! {
        didSet {
            self.pageControl.isUserInteractionEnabled = false
            self.pageControl.pageIndicatorTintColor = .white
            self.pageControl.currentPageIndicatorTintColor = .red
        }
    }
    
    //MARK:- LifeCycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.configureUI()
    }
    
    //MARK:- Functions
    
    /// Call to configure ui
    private func configureUI() {
        self.cardCollectionView.registerCell(with: PartnerCollectionCell.self)
        self.cardCollectionView.registerCell(with: MenuItemCollectionCell.self)
        self.cardCollectionView.delegate = self
        self.cardCollectionView.dataSource = self
        self.flowLayoutSetup()
    }
    
    ///Call to populates data
    func configureCell() {
        self.cardCollectionViewTopCons.constant = 0.0
        self.cardCollectionViewBottomCons.constant = 0.0
        
        switch self.currentCell {
        case .cardCell:
            self.pageControl.isHidden = true
            self.cardCollectionView.isPagingEnabled = false
        case .featuredCell:
            self.cardCollectionView.isPagingEnabled = true
            self.pageControl.numberOfPages = (self.currentCell == .featuredCell) ? (self.superYouData?.featuredDataArr.count ?? 0) : self.inviteImgArray.count
            self.pageControl.isHidden = (self.currentCell == .featuredCell) ? (self.superYouData?.featuredDataArr.count ?? 0) < 2 : self.inviteImgArray.count < 2
        case .categories:
            self.pageControl.isHidden = true
            
        default:
            self.pageControl.isHidden = true
            self.cardCollectionView.isPagingEnabled = false
        }
        self.cardCollectionView.reloadData()
    }
    
    ///Get Card Cell
    private func getCardCell(_ collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueCell(with: PartnerCollectionCell.self, indexPath: indexPath)
        cell.bgView1StackBtmCost.constant = 12.0
        return cell
    }
    
    ///Get UpcomingCell
    private func getUpcomingCell(_ collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueCell(with: PartnerCollectionCell.self, indexPath: indexPath)
        cell.populateCell(model: superYouData?.upcomingDataArr[indexPath.row])
        cell.bgView1StackBtmCost.constant = 12.0
        return cell
    }
    
    ///Get LiveNow cell
    private func getLiveNowCell(_ collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueCell(with: PartnerCollectionCell.self, indexPath: indexPath)
        cell.populateCell(model: superYouData?.liveNowDataArr[indexPath.row])
        cell.bgView1StackBtmCost.constant = 12.0
        return cell
    }
    
    ///Get Talks cell
    private func getTalksCell(_ collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueCell(with: PartnerCollectionCell.self, indexPath: indexPath)
        cell.populateCell(model: superYouData?.mostDiscussedTalks[indexPath.row])
        cell.bgView1StackBtmCost.constant = 12.0
        return cell
    }
    
    ///Get LiveNow cell
    private func getPastLiveNowCell(_ collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueCell(with: PartnerCollectionCell.self, indexPath: indexPath)
        cell.populateCell(model: superYouData?.pastLiveData[indexPath.row])
        cell.bgView1StackBtmCost.constant = 12.0
        return cell
    }
    
    ///Get Classes cell
    private func getClassesCell(_ collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueCell(with: PartnerCollectionCell.self, indexPath: indexPath)
        cell.populateCell(model: superYouData?.liveNowDataArr[indexPath.row])
        cell.bgView1StackBtmCost.constant = 12.0
        return cell
    }
    
    private func getFavoritesCell(_ collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueCell(with: PartnerCollectionCell.self, indexPath: indexPath)
        cell.populateCell(model: superYouData?.favouriteDataArr[indexPath.row])
        cell.bgView1StackBtmCost.constant = 12.0
        return cell
    }
    
    private func getNewSuperShesCell(_ collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueCell(with: PartnerCollectionCell.self, indexPath: indexPath)
        cell.populateCell(model: superYouData?.newSuperShesArr[indexPath.row])
        cell.bgView1StackBtmCost.constant = 12.0
        return cell
    }
    
    private func getFeaturedCell(_ collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueCell(with: PartnerCollectionCell.self, indexPath: indexPath)
        cell.populateCell(model: superYouData?.featuredDataArr[indexPath.row])
        cell.bgView1StackBtmCost.constant = 30.0
        return cell
    }
    
    private func getCategoriesCell(_ collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueCell(with: MenuItemCollectionCell.self, indexPath: indexPath)
        cell.populateCell(model: superYouData?.categories[indexPath.row])
        return cell
    }
}

//MARK:- UICollectionView Extensions
extension SuperViewCardTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        switch self.shimmerStatus {
            
        case .toBeApply:
            switch self.currentCell {
            case .cardCell:
                return 4
            case .upcomingCell:
                return 4
            default:
                return 0
            }
        case .applied:
            switch self.currentCell {
            case .cardCell:
//                if let cardData = self.cardData {
//                    return cardData.cellData.count
//                }
                return 5
            case .upcomingCell:
                return self.superYouData?.upcomingDataArr.count ?? 0
            case .liveClassesCell:
                return self.superYouData?.liveNowDataArr.count ?? 0
            case .favoritesCell:
                return self.superYouData?.favouriteDataArr.count ?? 0
            case .mostLovedClassesCell:
                return  self.superYouData?.mostLovedArr.count ?? 0
            case .newSuperSheCell:
                return  self.superYouData?.newSuperShesArr.count ?? 0
            case .featuredCell:
                return self.superYouData?.featuredDataArr.count ?? 0
            case .categories:
                return self.superYouData?.categories.count ?? 0
            case .pastLive:
                return self.superYouData?.pastLiveData.count ?? 0
            }
        case .none:
            return 0
        }
        //        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch self.currentCell {
            
        case .cardCell:
            return self.getCardCell(collectionView, indexPath: indexPath)
            
        case .upcomingCell:
            return self.getUpcomingCell(collectionView, indexPath: indexPath)
            
        case .liveClassesCell:
            return self.getLiveNowCell(collectionView, indexPath: indexPath)
            
        case .favoritesCell:
            return self.getFavoritesCell(collectionView, indexPath: indexPath)
            
        case .mostLovedClassesCell:
            return self.getClassesCell(collectionView, indexPath: indexPath)
            
        case .newSuperSheCell:
            return self.getNewSuperShesCell(collectionView, indexPath: indexPath)
            
        case .featuredCell:
            return self.getFeaturedCell(collectionView, indexPath: indexPath)
            
        case .categories:
            return self.getCategoriesCell(collectionView, indexPath: indexPath)
            
        case .pastLive:
            return self.getPastLiveNowCell(collectionView, indexPath: indexPath)
        }
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch self.currentCell {
            
        case .cardCell:
            return CGSize(width: ClassInitalLayoutConstants.collUpcomingCellWidth, height: collectionView.bounds.height)
        case .upcomingCell:
            return CGSize(width: ClassInitalLayoutConstants.collUpcomingCellWidth, height: collectionView.bounds.height)
            
        case .liveClassesCell, .pastLive:
            return CGSize(width: ClassInitalLayoutConstants.collLiveCellWidth, height: collectionView.bounds.height)
            
        case .favoritesCell, .newSuperSheCell:
            return CGSize(width: ClassInitalLayoutConstants.collUpcomingCellWidth, height: collectionView.bounds.height)
            
        case .mostLovedClassesCell:
            return CGSize(width: ClassInitalLayoutConstants.mostLovedHomeCollCellWidth, height: collectionView.bounds.height)
            
        case .featuredCell:
            return CGSize(width: collectionView.bounds.width, height: collectionView.bounds.height)
        case .categories:
            return cardSizeForCategoriesItemAt(collectionView, layout: collectionViewLayout, indexPath: indexPath)
        }
    }
    
    private func cardSizeForCategoriesItemAt(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, indexPath: IndexPath) -> CGSize {
        if let cardData =  superYouData?.categories, self.shimmerStatus == .applied {
            let dataSource = cardData[indexPath.item].primaryTag
            let textSize = "\(dataSource)".sizeCount(withFont: AppFonts.BoldItalic.withSize(12.0), boundingSize: CGSize(width: 10000.0, height: 40.0))
            return CGSize(width: textSize.width + 45.0, height: 40.0)
        }
        return CGSize(width: 50.0, height: 44.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        switch self.currentCell {
        case .upcomingCell :
            return 18.0
        case .featuredCell:
            return 0.0
        default : // .cardCell, .liveClassesCell, .mostLovedClassesCell, .newSuperSheCell, .whatsNewCell, .yourClassesCell, .savedClassesCell
            return 9.0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        switch self.currentCell {
        case .featuredCell, .cardCell:
            return 0.0
        default:
            return 10.0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        var paddingInset: CGFloat = 0.0
        
        switch self.currentCell {
            
        case .mostLovedClassesCell:
            paddingInset = 18.0
            
        case .featuredCell:
            paddingInset = 0.0
            
        case .cardCell:
            paddingInset = 9.0
            
        case .favoritesCell, .newSuperSheCell:
            paddingInset = 9.0
            
        case .categories:
            paddingInset = 9.0
        default:
            paddingInset = 0.0
            //whatsNewCell, superPowers, yourClassesCell, newSuperSheCell, savedClassesCell, upcomingCell, favoritesCell, talksCell,
        }
        
        return UIEdgeInsets(top: 0, left: paddingInset, bottom: 0, right: paddingInset)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard self.shimmerStatus == .applied else { return }
        self.manageScroll(scrollView)
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        self.manageScroll(scrollView)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        self.manageScroll(scrollView)
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        self.manageScroll(scrollView)
    }
    
    func manageScroll(_ scrollView: UIScrollView) {
        if scrollView === self.cardCollectionView {
            guard self.currentCell == .featuredCell  else { return }
            let offset = scrollView.contentOffset
            let page = offset.x / self.bounds.width
            self.pageControl.currentPage = Int(page)
            self.currentItem = Int(page)
        }
    }
    
//    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
//
//        guard self.currentCell == .inviteCell else { return }
//
//        let pageWidth = Float(itemWidth + 9)
//        let targetXContentOffset = Float(targetContentOffset.pointee.x)
//        let contentWidth = Float(cardCollectionView.contentSize.width)
//        var newPage : Float = 0
//
//        if velocity.x == 0 {
//            newPage = floor( (targetXContentOffset - Float(pageWidth) / 2) / Float(pageWidth)) + 1.0
//        }
//        else {
//            newPage = Float(velocity.x > 0 ? self.currentItem + 1 : self.currentItem - 1)
//            if newPage < 0 {
//                newPage = 0
//            }
//            if (newPage > contentWidth / pageWidth) {
//                newPage = ceil(contentWidth / pageWidth) - 1.0
//            }
//        }
//
//        self.currentItem = Int(newPage)
//        let point = CGPoint (x: CGFloat(newPage * pageWidth), y: targetContentOffset.pointee.y)
//        targetContentOffset.pointee = point
//
//        if Int(newPage) < 3 {
//            //  lblTier.text =  "TIER \(Int(newPage) + 1)/\(totalLevel)"
//        }
//    }
    
    func flowLayoutSetup() {
//        if self.currentCell == .inviteCell {
//            let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
//            itemWidth = UIScreen.main.bounds.width - 36
//            layout.scrollDirection = .horizontal
//            cardCollectionView.collectionViewLayout = layout
//            cardCollectionView?.decelerationRate = UIScrollView.DecelerationRate.normal
//        }
//        else {
            let layout = UICollectionViewFlowLayout()
            layout.scrollDirection = .horizontal
            self.cardCollectionView.collectionViewLayout = layout
//        }
    }
    
}

