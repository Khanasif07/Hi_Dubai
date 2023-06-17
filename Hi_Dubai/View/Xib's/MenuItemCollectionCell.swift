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
        self.dataView.setCircleBorder(weight: 0.75, color: .white)
        self.title.font =  AppFonts.BlackItalic.withSize(15.0)
    }
    
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
    
    func populateSectionCell(model: Record?, index: Int){
        self.dotView.isHidden = true
        self.title.textColor = (model?.isSelected ?? false) ? AppColors.white :  AppColors.black
        self.title.text = (model?.primaryTag ?? "")
        self.dataView.backgroundColor = (model?.isSelected ?? false) ? .black : .lightGray
        self.title.font = (model?.isSelected ?? false) ? AppFonts.BlackItalic.withSize(16.0) : AppFonts.BlackItalic.withSize(15.0)
    }
}
