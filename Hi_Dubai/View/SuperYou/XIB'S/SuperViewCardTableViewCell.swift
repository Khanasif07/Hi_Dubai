//
//  SuperViewCardTableViewCell.swift
//  Hi_Dubai
//
//  Created by Asif Khan on 17/05/2023.
//

import UIKit
class SuperViewCardTableViewCell: UITableViewCell {
    
    enum CellContents {
        case cardCell , upcomingCell, liveClassesCell, favoritesCell, mostLovedClassesCell, newSuperSheCell, featuredCell,categories, pastLive , music
    }
    
    //MARK:- Variables
    // Velocity is measured in points per millisecond.
    private var snapToMostVisibleColumnVelocityThreshold: CGFloat { return 0.3 }
    var cardData: SuperYouCardData? = SuperYouCardData()
    var currentCell: CellContents = .cardCell
    var superYouData: SuperYouHomeModel?
    var shimmerStatus: ShimmerState = .applied
    private var itemWidth: CGFloat = 0.0
    private var currentItem: Int = 0
    
    //MARK:- IBOutlets
    @IBOutlet weak var emptyView: EmptyView!
    @IBOutlet weak var cardCollectionView: UICollectionView!
    @IBOutlet weak var cardCollectionViewTopCons: NSLayoutConstraint!
    @IBOutlet weak var cardCollectionViewBottomCons: NSLayoutConstraint!
    @IBOutlet weak var pageControl: UIPageControl! {
        didSet {
            self.pageControl.isUserInteractionEnabled = false
            self.pageControl.pageIndicatorTintColor = .yellow
            self.pageControl.currentPageIndicatorTintColor = .red
        }
    }
    
    //MARK:- LifeCycle
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.emptyView.isHidden = true
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.configureUI()
    }
    
    //MARK:- Functions
    
    /// Call to configure ui
    private func configureUI() {
        self.cardCollectionView.registerCell(with: MusicCollCell.self)
        self.cardCollectionView.registerCell(with: PartnerCollectionCell.self)
        self.cardCollectionView.registerCell(with: MenuItemCollectionCell.self)
        self.cardCollectionView.delegate = self
        self.cardCollectionView.dataSource = self
        self.emptyView.isHidden = true
        self.emptyView.delegate = self
        self.flowLayoutSetup()
    }
    //MARK: - Two column only collectionViewFlowLayout
    func createLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                              heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .absolute(44))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 3)
        let spacing = CGFloat(10)
        group.interItemSpacing = .fixed(spacing)
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = spacing
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10)
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
    
    ///Call to populates data
    func configureCell() {
        self.cardCollectionViewTopCons.constant = 0.0
        self.cardCollectionViewBottomCons.constant = 0.0
        self.cardCollectionView.isHidden = false
        switch self.currentCell {
        case .music:
            self.pageControl.isHidden = true
            self.cardCollectionView.isPagingEnabled = false
            let layout = UICollectionViewFlowLayout()
            layout.scrollDirection = .horizontal
            self.cardCollectionView.collectionViewLayout = layout
        case .cardCell:
            self.pageControl.isHidden = true
            self.cardCollectionView.isPagingEnabled = false
            let layout = UICollectionViewFlowLayout()
            layout.scrollDirection = .horizontal
            self.cardCollectionView.collectionViewLayout = layout
        case .featuredCell:
            self.cardCollectionView.isPagingEnabled = true
            self.pageControl.isHidden = false
            self.pageControl.numberOfPages = (self.currentCell == .featuredCell) ? (self.superYouData?.featuredDataArr.count ?? 0) : 0
            self.pageControl.isHidden = (self.currentCell == .featuredCell) ? (self.superYouData?.featuredDataArr.count ?? 0) < 2 : true
            let layout = UICollectionViewFlowLayout()
            layout.scrollDirection = .horizontal
            self.cardCollectionView.collectionViewLayout = layout
        case .categories:
            self.pageControl.isHidden = true
            self.cardCollectionView.isPagingEnabled = false
//            self.cardCollectionView.collectionViewLayout = createLayout()
        case .upcomingCell:
            self.pageControl.isHidden = true
            self.cardCollectionView.isPagingEnabled = false
            let layout = UICollectionViewFlowLayout()
            layout.scrollDirection = .horizontal
            self.cardCollectionView.collectionViewLayout = layout
        default:
            self.pageControl.isHidden = true
            self.cardCollectionView.isPagingEnabled = false
            let layout = UICollectionViewFlowLayout()
            layout.scrollDirection = .horizontal
            self.cardCollectionView.collectionViewLayout = layout
        }
        self.cardCollectionView.reloadData()
    }
    

    ///Get Music Cell
    private func getMusicCell(_ collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueCell(with: MusicCollCell.self, indexPath: indexPath)
        cell.titleLabel.text = "Awesome App #\(indexPath.item)"
        return cell
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
        cell.populateCell(model: superYouData?.mostLovedArr[indexPath.row])
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
        case .applied:
            switch self.currentCell {
            case .cardCell:
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
            case .music:
                return self.superYouData?.musicData.count ?? 0
            }
        case .none:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch self.currentCell {
        case .music:
            return self.getMusicCell(collectionView, indexPath: indexPath)
            
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
    
    func collectionView(_ collectionView: UICollectionView, contextMenuConfigurationForItemAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        
        let config = UIContextMenuConfiguration(
            identifier: nil,
            previewProvider: nil) {[weak self] _ in
                let downloadAction = UIAction(title: "Download", subtitle: nil, image: nil, identifier: nil, discoverabilityTitle: nil, state: .off) { _ in
//                    self?.downloadTitleAt(indexPath: indexPath)
                }
                return UIMenu(title: "", image: nil, identifier: nil, options: .displayInline, children: [downloadAction])
            }
        
        return config
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch self.currentCell {
        case .music:
            return CGSize(width: 250.0, height: 55.0)
        case .cardCell:
            return CGSize(width: ClassInitalLayoutConstants.collUpcomingCellWidth, height: collectionView.bounds.height)
        case .upcomingCell:
            return CGSize(width: ClassInitalLayoutConstants.collUpcomingCellWidth, height: 215.0)

        case .liveClassesCell, .pastLive:
            return CGSize(width: ClassInitalLayoutConstants.collLiveCellWidth, height: collectionView.bounds.height)
            
        case .favoritesCell, .newSuperSheCell:
            return CGSize(width: ClassInitalLayoutConstants.collUpcomingCellWidth, height: collectionView.bounds.height)
            
        case .mostLovedClassesCell:
            return CGSize(width: ClassInitalLayoutConstants.mostLovedHomeCollCellWidth, height: collectionView.bounds.height)
            
        case .featuredCell:
            return CGSize(width: collectionView.bounds.width - 10, height: collectionView.bounds.height)
        case .categories:
            return cardSizeForCategoriesItemAt(collectionView, layout: collectionViewLayout, indexPath: indexPath)
        }
    }
    
    private func cardSizeForCategoriesItemAt(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, indexPath: IndexPath) -> CGSize {
        if let cardData =  superYouData?.categories, self.shimmerStatus == .applied {
            let dataSource = cardData[indexPath.item].primaryTag
            let textSize = "\(dataSource)".sizeCount(withFont: AppFonts.BoldItalic.withSize(12.0), boundingSize: CGSize(width: 10000.0, height: 40.0))
            return CGSize(width: textSize.width + 50.0, height: 40.0)
        }
        return CGSize(width: 50.0, height: 40.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        switch self.currentCell {
        case .upcomingCell :
            return 9.0
        case .featuredCell:
            return 0.0
        default : // .cardCell, .liveClassesCell, .mostLovedClassesCell, .newSuperSheCell, .whatsNewCell, .yourClassesCell, .savedClassesCell
            return 9.0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        switch self.currentCell {
        case .featuredCell:
            return 10.0
        case .cardCell:
            return 0.0
        default:
            return 10.0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        var paddingInset: CGFloat = 0.0
        
        switch self.currentCell {
            
        case .mostLovedClassesCell:
            paddingInset = 9.0
            
        case .featuredCell:
            paddingInset = 5.0
            
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
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        guard self.currentCell == .music else { return }
        
        let layout = collectionViewLayout as! UICollectionViewFlowLayout
        let bounds = scrollView.bounds
        let xTarget = targetContentOffset.pointee.x
        
        // This is the max contentOffset.x to allow. With this as contentOffset.x, the right edge of the last column of cells is at the right edge of the collection view's frame.
        let xMax = scrollView.contentSize.width - scrollView.bounds.width
        
        if abs(velocity.x) <= snapToMostVisibleColumnVelocityThreshold {
            let xCenter = scrollView.bounds.midX
            let poses = layout.layoutAttributesForElements(in: bounds) ?? []
            // Find the column whose center is closest to the collection view's visible rect's center.
            let x = poses.min(by: { abs($0.center.x - xCenter) < abs($1.center.x - xCenter) })?.frame.origin.x ?? 0
            targetContentOffset.pointee.x = x
        } else if velocity.x > 0 {
            let poses = layout.layoutAttributesForElements(in: CGRect(x: xTarget, y: 0, width: bounds.size.width, height: bounds.size.height)) ?? []
            // Find the leftmost column beyond the current position.
            let xCurrent = scrollView.contentOffset.x
            let x = poses.filter({ $0.frame.origin.x > xCurrent}).min(by: { $0.center.x < $1.center.x })?.frame.origin.x ?? xMax
            targetContentOffset.pointee.x = min(x, xMax)
        } else {
            let poses = layout.layoutAttributesForElements(in: CGRect(x: xTarget - bounds.size.width, y: 0, width: bounds.size.width, height: bounds.size.height)) ?? []
            // Find the rightmost column.
            let x = poses.max(by: { $0.center.x < $1.center.x })?.frame.origin.x ?? 0
            targetContentOffset.pointee.x = max(x, 0)
        }
    }
    
    func flowLayoutSetup() {
//        if self.currentCell == .categories {
//            let layout: UICollectionViewFlowLayout = LeftAlignedCollectionViewFlowLayout()
////            itemWidth = UIScreen.main.bounds.width - 36
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


// MARK: - UICollectionViewFlowLayout
//===========================
public class LeftAlignedCollectionViewFlowLayout: UICollectionViewFlowLayout {
    
    public override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        let attributes = super.layoutAttributesForElements(in: rect)
        
        var leftMargin = sectionInset.left
        var maxY: CGFloat = -1.0
        attributes?.forEach { layoutAttribute in
            if layoutAttribute.frame.origin.y >= maxY {
                leftMargin = sectionInset.left
            }
            layoutAttribute.frame.origin.x = leftMargin
            leftMargin += layoutAttribute.frame.width + minimumInteritemSpacing
            maxY = max(layoutAttribute.frame.maxY , maxY)
        }
        
        return attributes
    }
}


class DynamicHeightCollectionView: UICollectionView {
    override func layoutSubviews() {
        super.layoutSubviews()
        if bounds.size != intrinsicContentSize {
            self.invalidateIntrinsicContentSize()
        }
    }
    override var intrinsicContentSize: CGSize {
        return collectionViewLayout.collectionViewContentSize
    }
}


protocol PinterestLayoutDelegate {
   func collectionView(collectionView: UICollectionView, heightForPhotoAt indexPath: IndexPath, with width: CGFloat) -> CGFloat
}

class PinterestLayout: UICollectionViewLayout {

   var delegate: PinterestLayoutDelegate?

   var controller: SuperYouHomeVC?
   var numberOfColumns: CGFloat = 2
   var cellPadding: CGFloat = 5.0

   private var contentHeight: CGFloat = 0.0
   private var contentWidth: CGFloat {
      let insets = collectionView!.contentInset
      return (collectionView!.bounds.width - (insets.left + insets.right))
   }

   private var attributesCache = [PinterestLayoutAttributes]()

   override func prepare() {
      if attributesCache.isEmpty {
         let columnWidth = contentWidth / numberOfColumns
         var xOffsets = [CGFloat]()
         for column in 0 ..< Int(numberOfColumns) {
            xOffsets.append(CGFloat(column) * columnWidth)
         }

         var column = 0
         var yOffsets = [CGFloat](repeating: 0, count: Int(numberOfColumns))

         for item in 0 ..< collectionView!.numberOfItems(inSection: 0) {
            let indexPath = IndexPath(item: item, section: 0)

             let width = columnWidth - cellPadding * 2

            // Calculate the frame
             let photoHeight: CGFloat = Double.random(in: 220...400)
//             (delegate?.collectionView(collectionView: collectionView!, heightForPhotoAt: indexPath, with: width))!


            let height = cellPadding + photoHeight + cellPadding
            let frame = CGRect(x: xOffsets[column], y: yOffsets[column], width: columnWidth, height: height)
            let insetFrame = frame.insetBy(dx: cellPadding, dy: cellPadding)

            // Create layout attributes
            let attributes = PinterestLayoutAttributes(forCellWith: indexPath)
            attributes.photoHeight = photoHeight
            attributes.frame = insetFrame
            attributesCache.append(attributes)

            // Update column, yOffest
            contentHeight = max(contentHeight, frame.maxY)
            yOffsets[column] = yOffsets[column] + height

            if column >= Int(numberOfColumns - 1) {
               column = 0
            } else {
               column += 1
            }
         }
      }
   }

   override var collectionViewContentSize: CGSize {
      return CGSize(width: contentWidth, height: contentHeight)
   }

   override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
      var layoutAttributes = [UICollectionViewLayoutAttributes]()

      for attributes in attributesCache {
         if attributes.frame.intersects(rect) {
            layoutAttributes.append(attributes)
         }
      }

      return layoutAttributes
   }

}

class PinterestLayoutAttributes : UICollectionViewLayoutAttributes {
   var photoHeight: CGFloat = 0.0

   override func copy(with zone: NSZone? = nil) -> Any {
      let copy = super.copy(with: zone) as! PinterestLayoutAttributes
      copy.photoHeight = photoHeight
      return copy
   }

   override func isEqual(_ object: Any?) -> Bool {
      if let attributes = object as? PinterestLayoutAttributes {
         if attributes.photoHeight == photoHeight {
            return super.isEqual(object)
         }
      }

      return false
   }
}


extension SuperViewCardTableViewCell: EmptyStateViewDelegate{
    func loginAction(){
        (self.parentViewController as? SuperYouHomeVC)?.viewModel.superYouData?.getNewsListing()
    }
    func learnHowAction(){
        (self.parentViewController as? SuperYouHomeVC)?.viewModel.superYouData?.getNewsListing()
    }
}
