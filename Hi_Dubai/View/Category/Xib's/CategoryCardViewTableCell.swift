//
//  CategoryCardViewTableCell.swift
//  Hi_Dubai
//
//  Created by Asif Khan on 25/07/2023.
//

import UIKit
enum CellContents {
    case section1 , section2, section3, section4, section5, section6
}
class CategoryCardViewTableCell: UITableViewCell {
    var currentCell: CellContents = .section2{
        didSet{
            configureCell()
        }
    }
    var categoryData: CategoryDetailModel?
    
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
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    //MARK:- Functions
    
    /// Call to configure ui
    private func configureUI() {
        self.cardCollectionView.registerCell(with: MenuItemCollectionCell.self)
        self.cardCollectionView.registerCell(with: StuffCollCell.self)
        self.cardCollectionView.delegate = self
        self.cardCollectionView.dataSource = self
        self.emptyView.isHidden = true
        self.flowLayoutSetup()
        configureCell()
    }
    
    
    ///Call to populates data
    func configureCell() {
        self.cardCollectionView.isHidden = false
        switch self.currentCell {
        case .section1:
            self.pageControl.isHidden = true
            self.cardCollectionView.isPagingEnabled = false
        case .section2:
            self.pageControl.isHidden = true
            self.cardCollectionView.isPagingEnabled = false
        case .section3:
            self.pageControl.isHidden = true
            self.cardCollectionView.isPagingEnabled = false
        case .section4:
            self.pageControl.isHidden = true
            self.cardCollectionView.isPagingEnabled = false
        case .section5:
            self.pageControl.isHidden = true
            self.cardCollectionView.isPagingEnabled = false
        case .section6:
            self.pageControl.isHidden = true
            self.cardCollectionView.isPagingEnabled = false
        }
        self.cardCollectionView.reloadData()
    }
    ///Get UpcomingCell
    private func getUpcomingCell(_ collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueCell(with: StuffCollCell.self, indexPath: indexPath)
        cell.outerView.backgroundColor = UIColor(hue: CGFloat(indexPath.item) / 20.0, saturation: 0.8, brightness: 0.9, alpha: 1)
        return cell
    }
    
    ///Get LiveNow cell
    private func getSection1Cell(_ collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueCell(with: StuffCollCell.self, indexPath: indexPath)
        cell.outerView.backgroundColor = UIColor(hue: CGFloat(indexPath.item) / 20.0, saturation: 0.8, brightness: 0.9, alpha: 1)
        cell.populateCell(model: categoryData?.section1Data[indexPath.row])
        return cell
    }
    
    ///Get Talks cell
    private func getSection2Cell(_ collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueCell(with: StuffCollCell.self, indexPath: indexPath)
        cell.outerView.backgroundColor = UIColor(hue: CGFloat(indexPath.item) / 20.0, saturation: 0.8, brightness: 0.9, alpha: 1)
        cell.populateCell(model: categoryData?.section2Data[indexPath.row])
        return cell
    }
    
    ///Get LiveNow cell
    private func getSection3Cell(_ collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueCell(with: StuffCollCell.self, indexPath: indexPath)
        cell.outerView.backgroundColor = UIColor(hue: CGFloat(indexPath.item) / 20.0, saturation: 0.8, brightness: 0.9, alpha: 1)
        cell.populateCell(model: categoryData?.section3Data[indexPath.row])
        return cell
    }
    
    ///Get Classes cell
    private func getSection4Cell(_ collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueCell(with: StuffCollCell.self, indexPath: indexPath)
        cell.outerView.backgroundColor = UIColor(hue: CGFloat(indexPath.item) / 20.0, saturation: 0.8, brightness: 0.9, alpha: 1)
        cell.populateCell(model: categoryData?.section4Data[indexPath.row])
        return cell
    }
    
    private func getSection5Cell(_ collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueCell(with: StuffCollCell.self, indexPath: indexPath)
        cell.outerView.backgroundColor = UIColor(hue: CGFloat(indexPath.item) / 20.0, saturation: 0.8, brightness: 0.9, alpha: 1)
        cell.populateCell(model:  categoryData?.section5Data[indexPath.row])
        return cell
    }
    
    private func getSection6Cell(_ collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueCell(with: StuffCollCell.self, indexPath: indexPath)
        cell.outerView.backgroundColor = UIColor(hue: CGFloat(indexPath.item) / 20.0, saturation: 0.8, brightness: 0.9, alpha: 1)
        return cell
    }
}

//MARK:- UICollectionView Extensions
extension CategoryCardViewTableCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch self.currentCell {
        case .section1:
            return self.categoryData?.section1Data.count ?? 0
        case .section2:
            return self.categoryData?.section2Data.count ?? 0
        case .section3:
            return self.categoryData?.section3Data.count ?? 0
        case .section4:
            return self.categoryData?.section4Data.count ?? 0
        case .section5:
            return  self.categoryData?.section5Data.count ?? 0
        case .section6:
            return  self.categoryData?.section6Data.count ?? 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch self.currentCell {
        case .section1:
            return self.getSection1Cell(collectionView, indexPath: indexPath)
            
        case .section2:
            return self.getSection2Cell(collectionView, indexPath: indexPath)
            
        case .section3:
            return self.getSection3Cell(collectionView, indexPath: indexPath)
            
        case .section4:
            return self.getSection4Cell(collectionView, indexPath: indexPath)
            
        case .section5:
            return self.getSection5Cell(collectionView, indexPath: indexPath)
            
        case .section6:
            return self.getSection6Cell(collectionView, indexPath: indexPath)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch self.currentCell {
        case .section1:
            return CGSize(width: 140.0, height: collectionView.bounds.height - 18)
        case .section2:
            return CGSize(width: ClassInitalLayoutConstants.collUpcomingCellWidth, height: collectionView.bounds.height - 18)
        case .section3:
            return CGSize(width: ClassInitalLayoutConstants.collUpcomingCellWidth, height: collectionView.bounds.height - 18)
        case .section4:
            return CGSize(width: ClassInitalLayoutConstants.collLiveCellWidth, height: collectionView.bounds.height - 18)
        case .section5:
            return CGSize(width: ClassInitalLayoutConstants.collUpcomingCellWidth, height: collectionView.bounds.height - 18)
        case .section6:
            return CGSize(width: ClassInitalLayoutConstants.collLiveCellWidth, height: collectionView.bounds.height - 18)
        }
    }
    
    private func cardSizeForCategoriesItemAt(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, indexPath: IndexPath) -> CGSize {
        if let cardData =  categoryData?.section6Data{
            let dataSource = cardData[indexPath.item].name + " \(indexPath.item)"
            let textSize = "\(dataSource)".sizeCount(withFont: AppFonts.BoldItalic.withSize(12.0), boundingSize: CGSize(width: 10000.0, height: 40.0))
            return CGSize(width: textSize.width + 50.0, height: 40.0)
        }
        return CGSize(width: 50.0, height: 40.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        switch self.currentCell {
        case .section1 :
            return 9.0
        case .section2:
            return 0.0
        case .section3:
            return 9.0
        case .section4,.section5:
            return 9.0
        default :
            return 9.0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        switch self.currentCell {
        case .section1:
            return 10.0
        case .section2:
            return 10.0
        case .section3:
            return 10.0
        case .section4,.section5:
            return 10.0
        default:
            return 10.0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        var paddingInset: CGFloat = 0.0
        switch self.currentCell {
        case .section1:
            paddingInset = 5.0
        case .section2:
            paddingInset = 5.0
        case .section3:
            paddingInset = 5.0
        case .section4:
            paddingInset = 5.0
        case .section5:
            paddingInset = 5.0
        case .section6:
            paddingInset = 5.0
        }
        return UIEdgeInsets(top: 9.0, left: paddingInset, bottom: 9.0, right: paddingInset)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        self.manageScroll(scrollView)
    }
    
//    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
////        self.manageScroll(scrollView)
//        if scrollView === self.cardCollectionView {
//            switch self.currentCell{
////            case .newSuperSheCell:
////                let indexOfMajorCell = indexOfMajorCell(in: layoutt)
////                   setIndexOfCellBeforeStartingDragging(indexOfMajorCell: indexOfMajorCell)
//            case .featuredCell:
//                let offset = scrollView.contentOffset
//                let page = offset.x / self.bounds.width
//                self.pageControl.currentPage = Int(page)
//                self.currentItem = Int(page)
//            default:
//                print("")
//            }
//        }
//    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
//        self.manageScroll(scrollView)
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
//        self.manageScroll(scrollView)
    }

    func flowLayoutSetup() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        self.cardCollectionView.collectionViewLayout = layout
    }
    
}

