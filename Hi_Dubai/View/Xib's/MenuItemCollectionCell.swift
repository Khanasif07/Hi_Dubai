//
//  MenuItemCollectionCell.swift
//  Hi_Dubai
//
//  Created by Asif Khan on 05/05/2023.
//

import UIKit
import Parchment
struct MenuItem : PagingItem ,Hashable, Comparable {
    static func < (lhs: MenuItem, rhs: MenuItem) -> Bool {
         return lhs.index < rhs.index
    }
    
    static func ==(lhs: MenuItem, rhs: MenuItem) -> Bool {
        return lhs.title == rhs.title &&
            lhs.index == rhs.index
    }
    
    var title: String
    var index: Int
    var attributedTitle: NSAttributedString?
    var isSelected: Bool = true
    
    init(title: String,index: Int,isSelected: Bool = true, attributedTitle: NSAttributedString? = nil){
        self.attributedTitle = attributedTitle
        self.title = title
        self.index = index
        self.isSelected = isSelected
    }
    
    var hashValue: Int {
      return title.hashValue
    }
}

class MenuItemCollectionCell: PagingCell {
    
    @IBOutlet weak var dataView: UIView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var dotView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.dotView.layer.cornerRadius = 2.0
        self.dotView.backgroundColor = AppColors.green
        //superyouhome
        self.dataView.layer.cornerRadius = self.dataView.frame.height / 2.0
        self.dataView.setCircleBorder(weight: 0.75, color: .black)
        //        self.dataView.setCircleBorder(weight: 0.75, color: .white)
        self.title.font =  AppFonts.BlackItalic.withSize(15.0)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            contentView.leftAnchor.constraint(equalTo: leftAnchor),
            contentView.rightAnchor.constraint(equalTo: rightAnchor),
            contentView.topAnchor.constraint(equalTo: topAnchor),
            contentView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
//    override var isSelected: Bool {
//        didSet {
//            UIView.animate(withDuration: 0.3, delay: 0.0, options: .curveEaseOut, animations: {
////                self.layer.zPosition = self.isSelected ? 1 : -1
//                self.dataView.transform = self.isSelected ? CGAffineTransform(scaleX: 1.5, y: 1.5) : CGAffineTransform.identity
//            }, completion: nil)
//        }
//    }
    
    open override func setPagingItem(_ pagingItem: PagingItem, selected: Bool, options: PagingOptions) {
         if let item = pagingItem as? MenuItem {
            if let attTitle = item.attributedTitle {
                self.title.attributedText = attTitle
            } else {
                self.title.text = item.title
            }
            self.dotView.isHidden = item.isSelected
            self.title.font = selected ? AppFonts.BlackItalic.withSize(16.0) : AppFonts.BlackItalic.withSize(15.0)
        }
     }
    
    func populateCell(model: Record?, index: Int){
        self.title.textColor = AppColors.white
        self.title.text = (model?.primaryTag ?? "")
        self.dotView.isHidden = true
    }
    
    func populateCells(model: Animal?, index: Int){
//        self.title.textColor = AppColors.white
        self.title.textColor = AppColors.black
        self.title.text = (model?.name ?? "") + (" \(index)")
        self.dotView.isHidden = true
        self.dataView.backgroundColor = .white
    }
    
    func populateSectionCell(model: Record?, index: Int){
        self.dotView.isHidden = true
        self.title.textColor = (model?.isSelected ?? false) ? AppColors.white :  AppColors.black
        self.title.text = (model?.primaryTag ?? "")
        self.dataView.backgroundColor = (model?.isSelected ?? false) ? .black : .lightGray
        self.title.font = (model?.isSelected ?? false) ? AppFonts.BlackItalic.withSize(18.0) : AppFonts.BlackItalic.withSize(15.0)
    }
    
//    override func sizeThatFits(_ size: CGSize) -> CGSize {
//        super.sizeThatFits(size)
//
//        let cardData =  title.text
//        let dataSource = cardData
//        let textSize = "\(String(describing: dataSource))".sizeCount(withFont: AppFonts.BoldItalic.withSize(12.0), boundingSize: CGSize(width: 10000.0, height: 40.0))
//        return CGSize(width: textSize.width + 50.0, height: 40.0)
//        //        return CGSize(width: 50.0, height: 40.0)
//        //        guard let text = self.title. else { return .zero } // You might not need this
//
//        //        let superHeight = super.sizeThatFits(size).height
//        //        let verticalPadding = padding * 2
//        //
//        //        descriptionLabel.text = title.text
//        //        descriptionLabel.font = UIFont.rpx.regular14
//
//        //        let labelHeight = title.text?.boundingRect(
//        //            with: CGSize(width: size.width, height: size.height),
//        //            options: .usesLineFragmentOrigin,
//        //            context: nil
//        //        ).size.height ?? size.height
//
//    }
    
//    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
//        super.preferredLayoutAttributesFitting(layoutAttributes)
//        let targetSize = CGSize(width: layoutAttributes.frame.width, height: 0)
//        layoutAttributes.frame.size = contentView.systemLayoutSizeFitting(targetSize, withHorizontalFittingPriority: .required, verticalFittingPriority: .fittingSizeLevel)
//        return layoutAttributes
//    }
}
