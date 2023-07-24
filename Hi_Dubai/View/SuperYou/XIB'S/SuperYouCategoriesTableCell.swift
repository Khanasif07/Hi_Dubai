//
//  SuperYouCategoriesTableCell.swift
//  Hi_Dubai
//
//  Created by Asif Khan on 19/07/2023.
//

import UIKit
class SuperYouCategoriesTableCell: UITableViewCell {
    
    //MARK:- Variables
    let layoutt = UICollectionViewFlowLayout()
    // Velocity is measured in points per millisecond.
    var superYouData: SuperYouHomeModel? {
        didSet{
            configureUI()
        }
    }
    
    //MARK:- IBOutlets
    @IBOutlet weak var cardScrollView: UIScrollView!
    //    @IBOutlet weak var emptyView: EmptyView!
    //    @IBOutlet weak var cardCollectionView: UICollectionView!
    
    //MARK:- LifeCycle
    
    override func prepareForReuse() {
        super.prepareForReuse()
        //        self.emptyView.isHidden = true
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        cardScrollView.isScrollEnabled = true
        //        self.configureUI()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    //MARK:- Functions
    
    /// Call to configure ui
    private func configureUI() {
        //        let menuView = MenuItemView.instanciateFromNib()
        //        self.cardCollectionView.registerCell(with: MenuItemCollectionCell.self)
        //        self.cardCollectionView.delegate = self
        //        self.cardCollectionView.dataSource = self
        //        self.emptyView.isHidden = true
        
        var previousAnchor = cardScrollView.leadingAnchor
        let totalCount = (self.superYouData?.categories.count ?? 0)
        if totalCount == 0{
            self.cardScrollView.subviews.forEach({$0.removeFromSuperview()})
            return
        }
        for i in 0..<totalCount{
            let menuView = MenuItemView.instanciateFromNib()
            menuView.titlelbl.text = self.superYouData?.categories[i].name ?? ""
            menuView.translatesAutoresizingMaskIntoConstraints = false
            cardScrollView.addSubview(menuView)
            let itemSize = cardSizeForCategoriesItemAt(indexPath: i)
            if i == (totalCount/2){
                previousAnchor = cardScrollView.leadingAnchor
            }
            if i < (totalCount/2){
                NSLayoutConstraint.activate([
                    menuView.leadingAnchor.constraint(equalTo: previousAnchor, constant: 0),
                    menuView.heightAnchor.constraint(equalToConstant: itemSize.height),
                    menuView.widthAnchor.constraint(equalToConstant: itemSize.width),
                    menuView.topAnchor.constraint(equalTo: cardScrollView.topAnchor, constant: 0),
                    menuView.bottomAnchor.constraint(equalTo: cardScrollView.bottomAnchor, constant: -50)
                ])
            }
            else{
                NSLayoutConstraint.activate([
                    menuView.leadingAnchor.constraint(equalTo: previousAnchor, constant: 0),
                    menuView.heightAnchor.constraint(equalToConstant: itemSize.height),
                    menuView.widthAnchor.constraint(equalToConstant: itemSize.width),
                    menuView.topAnchor.constraint(equalTo: cardScrollView.topAnchor, constant: 50.0),
                    menuView.bottomAnchor.constraint(equalTo: cardScrollView.bottomAnchor, constant: 0)
                ])
            }
            previousAnchor = menuView.trailingAnchor
        }
        
        previousAnchor.constraint(equalTo: cardScrollView.trailingAnchor, constant: -10).isActive = true
        //        configureCell()
    }
    
    private func cardSizeForCategoriesItemAt(indexPath: Int) -> CGSize {
        if let cardData =  superYouData?.categories{
            let dataSource = cardData[indexPath].name
            let textSize = "\(dataSource)".sizeCount(withFont: AppFonts.BoldItalic.withSize(12.0), boundingSize: CGSize(width: 10000.0, height: 40.0))
            return CGSize(width: textSize.width + 80.0, height: 40.0)
        }
        return CGSize(width: 50.0, height: 40.0)
    }
    
    
    ///Call to populates data
    //    func configureCell() {
    //        self.cardCollectionView.isPagingEnabled = false
    //        let layout = UICollectionViewFlowLayout()
    //        layout.scrollDirection = .horizontal
    //        self.cardCollectionView.collectionViewLayout = layout
    ////        LeftAlignedHorizontalCollectionViewFlowLayout()
    //        self.cardCollectionView.reloadData()
    //    }
    
    
    ///Get Music Cell
    //    private func getCategoriesCell(_ collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell {
    //        let cell = collectionView.dequeueCell(with: MenuItemCollectionCell.self, indexPath: indexPath)
    //        cell.populateCells(model: superYouData?.categories[indexPath.row],index: indexPath.row)
    //        return cell
    //    }
}

//MARK:- UICollectionView Extensions
//extension SuperYouCategoriesTableCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
//
//    func numberOfSections(in collectionView: UICollectionView) -> Int {
//        return 2
//    }
//
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return self.superYouData?.categories.count ?? 0
//        if section == 0{
//            return 5
//        }else{
//            return 10
//        }
//
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//            return self.getCategoriesCell(collectionView, indexPath: indexPath)
//    }
//
//    func collectionView(_ collectionView: UICollectionView, contextMenuConfigurationForItemAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
//
//        let config = UIContextMenuConfiguration(
//            identifier: nil,
//            previewProvider: nil) { [weak self] _ in
//                let downloadAction = UIAction(title: "Download", subtitle: nil, image: nil, identifier: nil, discoverabilityTitle: nil, state: .off) { _ in
////                    self?.downloadTitleAt(indexPath: indexPath)
//                }
//                return UIMenu(title: "", image: nil, identifier: nil, options: .displayInline, children: [downloadAction])
//            }
//
//        return config
//    }
//
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return cardSizeForCategoriesItemAt(collectionView, layout: collectionViewLayout, indexPath: indexPath)
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
//            return 9.0
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        return 0.0
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//        var paddingInset: CGFloat = 0.0
//        return UIEdgeInsets(top: 0, left: paddingInset, bottom: 0, right: paddingInset)
//    }
//
//    private func cardSizeForCategoriesItemAt(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, indexPath: IndexPath) -> CGSize {
//        if let cardData =  superYouData?.categories{
//            let dataSource = cardData[indexPath.item].name + " \(indexPath.item)"
//            let textSize = "\(dataSource)".sizeCount(withFont: AppFonts.BoldItalic.withSize(12.0), boundingSize: CGSize(width: 10000.0, height: 40.0))
//            return CGSize(width: textSize.width + 50.0, height: 40.0)
//        }
//        return CGSize(width: 50.0, height: 40.0)
//    }
//}

// MARK: - LeftAlignedHorizontalCollectionViewFlowLayout
//class LeftAlignedHorizontalCollectionViewFlowLayout: UICollectionViewFlowLayout {
//
//    required override init() {super.init(); common()}
//    required init?(coder aDecoder: NSCoder) {super.init(coder: aDecoder); common()}
//
//    private func common() {
//        scrollDirection = .horizontal
////        estimatedItemSize = UICollectionViewFlowLayout.automaticSize
////        minimumLineSpacing = 10
////        minimumInteritemSpacing = 9
//    }
//
//    override func layoutAttributesForElements(
//        in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
//
//            guard let att = super.layoutAttributesForElements(in: rect) else {return []}
//
//            let group = att.group(by: {$0.frame.origin.y})
//            print("group:-\(group)")
//            var x: CGFloat = sectionInset.left
//
//            for attr in group {
//                print("attr:-\(attr)")
//                x = sectionInset.left
//                for (_,a) in attr.enumerated() {
//                    if a.representedElementCategory != .cell { continue }
//                    a.frame.origin.x = x
//                    x += a.frame.width + minimumInteritemSpacing
//                }
//            }
//            return att
//        }
//
//    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
//        return true
//    }
//}
