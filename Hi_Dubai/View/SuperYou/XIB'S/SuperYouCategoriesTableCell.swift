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
//            configureUI()
            configureCategoriesWidthUI()
        }
    }
    
    var categoriesData: CategoryDetailModel? {
        didSet{
            configureCategoriesWidthUI()
        }
    }
    
    //MARK:- IBOutlets
    @IBOutlet weak var cardScrollView: UIScrollView!
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
    }
    
    /// Call to configure ui
    private func configureCategoriesUI() {
        var previousAnchor = cardScrollView.leadingAnchor
        let totalCount = (self.categoriesData?.section6Data.count ?? 0)
        if totalCount == 0{
            self.cardScrollView.subviews.forEach({$0.removeFromSuperview()})
            return
        }
        for i in 0..<totalCount{
            let menuView = MenuItemView.instanciateFromNib()
            menuView.configureCell()
            menuView.titlelbl.text = self.categoriesData?.section6Data[i].title ?? ""
            menuView.translatesAutoresizingMaskIntoConstraints = false
            cardScrollView.addSubview(menuView)
            let itemSize = cardSizeForCategoriesItemAtForCategories(indexPath: i)
            if i == (totalCount/2){
                previousAnchor = cardScrollView.leadingAnchor
            }
            if i < (totalCount/2){
                NSLayoutConstraint.activate([
                    menuView.leadingAnchor.constraint(equalTo: previousAnchor, constant: 0),
                    menuView.heightAnchor.constraint(equalToConstant: itemSize.height),
                    menuView.widthAnchor.constraint(equalToConstant: itemSize.width),
                    menuView.topAnchor.constraint(equalTo: cardScrollView.topAnchor, constant: 9.0),
                    menuView.bottomAnchor.constraint(equalTo: cardScrollView.bottomAnchor, constant: -59)
                ])
            }
            else{
                NSLayoutConstraint.activate([
                    menuView.leadingAnchor.constraint(equalTo: previousAnchor, constant: 0),
                    menuView.heightAnchor.constraint(equalToConstant: itemSize.height),
                    menuView.widthAnchor.constraint(equalToConstant: itemSize.width),
                    menuView.topAnchor.constraint(equalTo: cardScrollView.topAnchor, constant: 59.0),
                    menuView.bottomAnchor.constraint(equalTo: cardScrollView.bottomAnchor, constant: -9.0)
                ])
            }
            previousAnchor = menuView.trailingAnchor
        }
        
        previousAnchor.constraint(equalTo: cardScrollView.trailingAnchor, constant: -10).isActive = true
        //        configureCell()
    }
    
    
    private func configureCategoriesWidthUI() {
        var previousAnchor = cardScrollView.leadingAnchor
        let totalCount = (self.categoriesData?.section6Data.count ?? 0)
        if totalCount == 0{
            self.cardScrollView.subviews.forEach({$0.removeFromSuperview()})
            return
        }
        //
        var totalWidth: CGFloat = 0.0
        for (index,_)in  self.categoriesData!.section6Data.enumerated(){
            totalWidth += cardSizeForCategoriesItemAtForCategories(indexPath: index).width
        }
        let halfWidth = totalWidth/2
        totalWidth = 0
        var lastItemWidth: CGFloat = 0
        var isMeanItem:Bool = false
        //
        for i in 0..<totalCount{
            let menuView = MenuItemView.instanciateFromNib()
            menuView.configureCell()
            menuView.titlelbl.text = self.categoriesData?.section6Data[i].primaryTag ?? ""
            menuView.translatesAutoresizingMaskIntoConstraints = false
            cardScrollView.addSubview(menuView)
            let itemSize = cardSizeForCategoriesItemAtForCategories(indexPath: i)
            if totalWidth > halfWidth && !isMeanItem{
                previousAnchor = cardScrollView.leadingAnchor
                isMeanItem = true
                //
                lastItemWidth = (totalWidth - halfWidth)
            }
            if totalWidth <= halfWidth{
                NSLayoutConstraint.activate([
                    menuView.leadingAnchor.constraint(equalTo: previousAnchor, constant: 0),
                    menuView.heightAnchor.constraint(equalToConstant: itemSize.height),
                    menuView.widthAnchor.constraint(equalToConstant: itemSize.width),
                    menuView.topAnchor.constraint(equalTo: cardScrollView.topAnchor, constant: 9.0),
                    menuView.bottomAnchor.constraint(equalTo: cardScrollView.bottomAnchor, constant: -59)
                ])
                totalWidth += itemSize.width
            }
            else{
                NSLayoutConstraint.activate([
                    menuView.leadingAnchor.constraint(equalTo: previousAnchor, constant: 0),
                    menuView.heightAnchor.constraint(equalToConstant: itemSize.height),
                    menuView.widthAnchor.constraint(equalToConstant: itemSize.width),
                    menuView.topAnchor.constraint(equalTo: cardScrollView.topAnchor, constant: 59.0),
                    menuView.bottomAnchor.constraint(equalTo: cardScrollView.bottomAnchor, constant: -9.0)
                ])
            }
            previousAnchor = menuView.trailingAnchor
        }
        //
        let menuView = MenuItemView.instanciateFromNib()
        menuView.dataView.isHidden = true
        menuView.translatesAutoresizingMaskIntoConstraints = false
        cardScrollView.addSubview(menuView)
        NSLayoutConstraint.activate([
            menuView.leadingAnchor.constraint(equalTo: previousAnchor, constant: 0),
            menuView.heightAnchor.constraint(equalToConstant: 40.0),
            menuView.widthAnchor.constraint(equalToConstant: lastItemWidth + 85.0),
            menuView.topAnchor.constraint(equalTo: cardScrollView.topAnchor, constant: 59.0),
            menuView.bottomAnchor.constraint(equalTo: cardScrollView.bottomAnchor, constant: -9.0)
        ])
        previousAnchor = menuView.trailingAnchor
        //
        previousAnchor.constraint(equalTo: cardScrollView.trailingAnchor, constant: -10).isActive = true
    }
    
    private func cardSizeForCategoriesItemAt(indexPath: Int) -> CGSize {
        if let cardData =  superYouData?.categories{
            let dataSource = cardData[indexPath].name
            let textSize = "\(dataSource)".sizeCount(withFont: AppFonts.BoldItalic.withSize(12.0), boundingSize: CGSize(width: 10000.0, height: 40.0))
            return CGSize(width: textSize.width + 80.0, height: 40.0)
        }
        return CGSize(width: 50.0, height: 40.0)
    }
    
    private func cardSizeForCategoriesItemAtForCategories(indexPath: Int) -> CGSize {
        if let cardData =  categoriesData?.section6Data{
            let dataSource = cardData[indexPath].primaryTag
            let textSize = "\(dataSource)".sizeCount(withFont: AppFonts.BoldItalic.withSize(12.0), boundingSize: CGSize(width: 10000.0, height: 40.0))
            return CGSize(width: textSize.width + 80.0, height: 40.0)
        }
        return CGSize(width: 50.0, height: 40.0)
    }
}
