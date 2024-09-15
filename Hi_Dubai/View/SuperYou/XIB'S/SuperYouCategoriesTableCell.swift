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
//            configureCategoriesWidthUI()
        }
    }
    
    var categoriesData: CategoryDetailModel? {
        didSet{
            configureCategoriesWidthUI()
        }
    }
    
    var categoriesNeighboursData: CategoryDetailModel? {
        didSet{
            configureCategoriesNeighboursUI()
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
        let totalCount = (self.superYouData?.categories.count ?? 0)
        if totalCount == 0{
            self.cardScrollView.subviews.forEach({$0.removeFromSuperview()})
            return
        }
        //
        self.cardScrollView.subviews.forEach({$0.removeFromSuperview()})
        var previousAnchor = cardScrollView.leadingAnchor
        var totalWidth: CGFloat = 0.0
        var secondHalfTotalWidth: CGFloat = 0.0
        var firstHalfTotalWidth: CGFloat = 0.0
        for (index,_) in  self.superYouData!.categories.enumerated(){
            totalWidth += cardSizeForCategoriesItemAt(indexPath: index).width
        }
        let totalHalfWidth = totalWidth/2
        var lastItemWidth: CGFloat = 0
        var isMeanItem:Bool = false
        //
        for i in 0..<totalCount{
            let menuView = MenuItemView.instanciateFromNib()
            menuView.configureCellAnimal(self.superYouData?.categories[i])
            menuView.delegate = self
            menuView.titlelbl.text = self.superYouData?.categories[i].name ?? ""
            menuView.translatesAutoresizingMaskIntoConstraints = false
            cardScrollView.addSubview(menuView)
            let itemSize = cardSizeForCategoriesItemAt(indexPath: i)
            if firstHalfTotalWidth > totalHalfWidth && !isMeanItem{
                previousAnchor = cardScrollView.leadingAnchor
                isMeanItem = true
                lastItemWidth = (firstHalfTotalWidth - totalHalfWidth)
            }
            if firstHalfTotalWidth <= totalHalfWidth{
                NSLayoutConstraint.activate([
                    menuView.leadingAnchor.constraint(equalTo: previousAnchor, constant: 0),
                    menuView.heightAnchor.constraint(equalToConstant: itemSize.height),
                    menuView.widthAnchor.constraint(equalToConstant: itemSize.width),
                    menuView.topAnchor.constraint(equalTo: cardScrollView.topAnchor, constant: 12.0),
                    menuView.bottomAnchor.constraint(equalTo: cardScrollView.bottomAnchor, constant: -53.0)
                ])
                firstHalfTotalWidth += itemSize.width
            }
            else{
                NSLayoutConstraint.activate([
                    menuView.leadingAnchor.constraint(equalTo: previousAnchor, constant: 0),
                    menuView.heightAnchor.constraint(equalToConstant: itemSize.height),
                    menuView.widthAnchor.constraint(equalToConstant: itemSize.width),
                    menuView.topAnchor.constraint(equalTo: cardScrollView.topAnchor, constant: 53.0),
                    menuView.bottomAnchor.constraint(equalTo: cardScrollView.bottomAnchor, constant: -12.0)
                ])
                secondHalfTotalWidth += itemSize.width
            }
            previousAnchor = menuView.trailingAnchor
        }
        //
        let finalWidth = (totalHalfWidth - secondHalfTotalWidth) + lastItemWidth
        let menuView = MenuItemView.instanciateFromNib()
        menuView.dataView.isHidden = true
        menuView.translatesAutoresizingMaskIntoConstraints = false
        cardScrollView.addSubview(menuView)
        NSLayoutConstraint.activate([
            menuView.leadingAnchor.constraint(equalTo: previousAnchor, constant: 0),
            menuView.heightAnchor.constraint(equalToConstant: 33.0),
            menuView.widthAnchor.constraint(equalToConstant: finalWidth + 15.0),
            menuView.topAnchor.constraint(equalTo: cardScrollView.topAnchor, constant: 53.0),
            menuView.bottomAnchor.constraint(equalTo: cardScrollView.bottomAnchor, constant: -12.0)
        ])
        previousAnchor = menuView.trailingAnchor
        //
        previousAnchor.constraint(equalTo: cardScrollView.trailingAnchor, constant: -10).isActive = true
    }
    
    /// Call to configure ui
//    private func configureCategoriesUI() {
//        var previousAnchor = cardScrollView.leadingAnchor
//        let totalCount = (self.categoriesData?.section6Data.count ?? 0)
//        if totalCount == 0{
//            self.cardScrollView.subviews.forEach({$0.removeFromSuperview()})
//            return
//        }
//        self.cardScrollView.subviews.forEach({$0.removeFromSuperview()})
//        for i in 0..<totalCount{
//            let menuView = MenuItemView.instanciateFromNib()
//            menuView.configureCell(self.categoriesData?.section6Data[i])
//            menuView.titlelbl.text = self.categoriesData?.section6Data[i].name?.en ?? ""
//            menuView.translatesAutoresizingMaskIntoConstraints = false
//            cardScrollView.addSubview(menuView)
//            let itemSize = cardSizeForCategoriesItemAtForCategories(indexPath: i)
//            if i == (totalCount/2){
//                previousAnchor = cardScrollView.leadingAnchor
//            }
//            if i < (totalCount/2){
//                NSLayoutConstraint.activate([
//                    menuView.leadingAnchor.constraint(equalTo: previousAnchor, constant: 0),
//                    menuView.heightAnchor.constraint(equalToConstant: itemSize.height),
//                    menuView.widthAnchor.constraint(equalToConstant: itemSize.width),
//                    menuView.topAnchor.constraint(equalTo: cardScrollView.topAnchor, constant: 9.0),
//                    menuView.bottomAnchor.constraint(equalTo: cardScrollView.bottomAnchor, constant: -59)
//                ])
//            }
//            else{
//                NSLayoutConstraint.activate([
//                    menuView.leadingAnchor.constraint(equalTo: previousAnchor, constant: 0),
//                    menuView.heightAnchor.constraint(equalToConstant: itemSize.height),
//                    menuView.widthAnchor.constraint(equalToConstant: itemSize.width),
//                    menuView.topAnchor.constraint(equalTo: cardScrollView.topAnchor, constant: 59.0),
//                    menuView.bottomAnchor.constraint(equalTo: cardScrollView.bottomAnchor, constant: -9.0)
//                ])
//            }
//            previousAnchor = menuView.trailingAnchor
//        }
//
//        previousAnchor.constraint(equalTo: cardScrollView.trailingAnchor, constant: -10).isActive = true
//        //        configureCell()
//    }
    
    /// Call to configure ui
    private func configureCategoriesNeighboursUI() {
        var previousAnchor = cardScrollView.leadingAnchor
        let totalCount = (self.categoriesNeighboursData?.section6Data.count ?? 0)
        if totalCount == 0{
            self.cardScrollView.subviews.forEach({$0.removeFromSuperview()})
            return
        }
        self.cardScrollView.subviews.forEach({$0.removeFromSuperview()})
        //
        let menuView = MenuItemView.instanciateFromNib()
        menuView.configureCellWithTitle(self.categoriesData?.section6Data[0])
        menuView.titlelbl.text = "Popular Neighborhoods:"
        menuView.translatesAutoresizingMaskIntoConstraints = false
        cardScrollView.addSubview(menuView)
        let itemSize = titleSize(item:  "Popular Neighborhoods:")
        NSLayoutConstraint.activate([
            menuView.leadingAnchor.constraint(equalTo: previousAnchor, constant: 0),
            menuView.heightAnchor.constraint(equalToConstant: itemSize.height),
            menuView.widthAnchor.constraint(equalToConstant: itemSize.width),
            menuView.topAnchor.constraint(equalTo: cardScrollView.topAnchor, constant: 0),
            menuView.bottomAnchor.constraint(equalTo: cardScrollView.bottomAnchor, constant: -17)
        ])
        previousAnchor = menuView.trailingAnchor
        //
        for i in 0..<totalCount{
            let menuView = MenuItemView.instanciateFromNib()
            menuView.configureCell(self.categoriesData?.section6Data[i])
            menuView.titlelbl.text = self.categoriesNeighboursData?.section6Data[i].name?.en ?? ""
            menuView.translatesAutoresizingMaskIntoConstraints = false
            cardScrollView.addSubview(menuView)
            let itemSize = cardSizeForCategoriesNeighboursItemAtForCategories(indexPath: i)
            NSLayoutConstraint.activate([
                menuView.leadingAnchor.constraint(equalTo: previousAnchor, constant: 0),
                menuView.heightAnchor.constraint(equalToConstant: itemSize.height),
                menuView.widthAnchor.constraint(equalToConstant: itemSize.width),
                menuView.topAnchor.constraint(equalTo: cardScrollView.topAnchor, constant: 0),
                menuView.bottomAnchor.constraint(equalTo: cardScrollView.bottomAnchor, constant: -17)
            ])
            previousAnchor = menuView.trailingAnchor
        }
        
        previousAnchor.constraint(equalTo: cardScrollView.trailingAnchor, constant: -10).isActive = true
        //        configureCell()
    }
    
    
    private func configureCategoriesWidthUI() {
        let totalCount = (self.categoriesData?.section6Data.count ?? 0)
        if totalCount == 0{
            self.cardScrollView.subviews.forEach({$0.removeFromSuperview()})
            return
        }
        //
        self.cardScrollView.subviews.forEach({$0.removeFromSuperview()})
        var previousAnchor = cardScrollView.leadingAnchor
        var totalWidth: CGFloat = 0.0
        var secondHalfTotalWidth: CGFloat = 0.0
        var firstHalfTotalWidth: CGFloat = 0.0
        for (index,_)in  self.categoriesData!.section6Data.enumerated(){
            totalWidth += cardSizeForCategoriesItemAtForCategories(indexPath: index).width
        }
        let totalHalfWidth = totalWidth/2
        var lastItemWidth: CGFloat = 0
        var isMeanItem:Bool = false
        //
        for i in 0..<totalCount{
            let menuView = MenuItemView.instanciateFromNib()
            menuView.configureCell(self.categoriesData?.section6Data[i])
            menuView.delegate = self
            menuView.titlelbl.text = self.categoriesData?.section6Data[i].name?.en ?? ""
            menuView.translatesAutoresizingMaskIntoConstraints = false
            cardScrollView.addSubview(menuView)
            let itemSize = cardSizeForCategoriesItemAtForCategories(indexPath: i)
            if firstHalfTotalWidth > totalHalfWidth && !isMeanItem{
                previousAnchor = cardScrollView.leadingAnchor
                isMeanItem = true
                lastItemWidth = (firstHalfTotalWidth - totalHalfWidth)
            }
            if firstHalfTotalWidth <= totalHalfWidth{
                NSLayoutConstraint.activate([
                    menuView.leadingAnchor.constraint(equalTo: previousAnchor, constant: 0),
                    menuView.heightAnchor.constraint(equalToConstant: itemSize.height),
                    menuView.widthAnchor.constraint(equalToConstant: itemSize.width),
                    menuView.topAnchor.constraint(equalTo: cardScrollView.topAnchor, constant: 12.0),
                    menuView.bottomAnchor.constraint(equalTo: cardScrollView.bottomAnchor, constant: -53.0)
                ])
                firstHalfTotalWidth += itemSize.width
            }
            else{
                NSLayoutConstraint.activate([
                    menuView.leadingAnchor.constraint(equalTo: previousAnchor, constant: 0),
                    menuView.heightAnchor.constraint(equalToConstant: itemSize.height),
                    menuView.widthAnchor.constraint(equalToConstant: itemSize.width),
                    menuView.topAnchor.constraint(equalTo: cardScrollView.topAnchor, constant: 53.0),
                    menuView.bottomAnchor.constraint(equalTo: cardScrollView.bottomAnchor, constant: -12.0)
                ])
                secondHalfTotalWidth += itemSize.width
            }
            previousAnchor = menuView.trailingAnchor
        }
        //
        let finalWidth = (totalHalfWidth - secondHalfTotalWidth) + lastItemWidth
        let menuView = MenuItemView.instanciateFromNib()
        menuView.dataView.isHidden = true
        menuView.translatesAutoresizingMaskIntoConstraints = false
        cardScrollView.addSubview(menuView)
        NSLayoutConstraint.activate([
            menuView.leadingAnchor.constraint(equalTo: previousAnchor, constant: 0),
            menuView.heightAnchor.constraint(equalToConstant: 33.0),
            menuView.widthAnchor.constraint(equalToConstant: finalWidth + 15.0),
            menuView.topAnchor.constraint(equalTo: cardScrollView.topAnchor, constant: 53.0),
            menuView.bottomAnchor.constraint(equalTo: cardScrollView.bottomAnchor, constant: -12.0)
        ])
        previousAnchor = menuView.trailingAnchor
        //
        previousAnchor.constraint(equalTo: cardScrollView.trailingAnchor, constant: -10).isActive = true
    }
    
    private func cardSizeForCategoriesItemAt(indexPath: Int) -> CGSize {
        if let cardData =  superYouData?.categories{
            let dataSource = cardData[indexPath].name
            let textSize = "\(dataSource)".sizeCount(withFont: AppFonts.BoldItalic.withSize(12.0), boundingSize: CGSize(width: 10000.0, height: 40.0))
            return CGSize(width: textSize.width + 30.0, height: 40.0)
        }
        return CGSize(width: 50.0, height: 40.0)
    }
    
    private func cardSizeForCategoriesItemAtForCategories(indexPath: Int) -> CGSize {
        if let cardData =  categoriesData?.section6Data{
            let dataSource = cardData[indexPath].name?.en ?? ""
            let textSize = "\(dataSource)".sizeCount(withFont: UIFont(name: "Helvetica Neue Medium", size: 12.0)!, boundingSize: CGSize(width: 10000.0, height: 33.0))
            return CGSize(width: textSize.width + 30.0, height: 33.0)
        }
        return CGSize(width: 50.0, height: 33.0)
    }
    
    private func cardSizeForCategoriesNeighboursItemAtForCategories(indexPath: Int) -> CGSize {
        if let cardData =  categoriesNeighboursData?.section6Data{
            let dataSource = cardData[indexPath].name
            let textSize = "\(dataSource?.en ?? "")".sizeCount(withFont: AppFonts.BoldItalic.withSize(12.0), boundingSize: CGSize(width: 10000.0, height: 33.0))
            return CGSize(width: textSize.width + 30.0, height: 33.0)
        }
        return CGSize(width: 50.0, height: 33.0)
    }
    
    private func titleSize(item: String) -> CGSize {
        let textSize = "\(item)".sizeCount(withFont: AppFonts.BoldItalic.withSize(12.0), boundingSize: CGSize(width: 10000.0, height: 33.0))
        return CGSize(width: textSize.width + 15.0, height: 33.0)
    }
}

//MARK: - MenuItemViewDelegate
extension SuperYouCategoriesTableCell: MenuItemViewDelegate{
    func categorySelected(_ model: Category){
        print(model)
    }
}
