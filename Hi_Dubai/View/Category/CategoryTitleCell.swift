//
//  CategoryTitleCell.swift
//  Hi_Dubai
//
//  Created by Asif Khan on 03/07/2023.
//

import UIKit
import FontAwesome_swift
var maxCountForViewMore: Int = 10
var viewMoreSelected: Bool = false
class CategoryTitleCell: UITableViewCell {

    //MARK: - Properties
    weak var helperDelegate: HeplerDelegate?
    var model: Goal?
    var modele: Category?
    var buttonTapped: ((UIButton) -> Void)?
    var selectedIndexPath: IndexPath?
   
    //MARK: - IBOutlets
    @IBOutlet weak var containerStackView: UIStackView!
    @IBOutlet weak var internalTableView: CustomTableView!
    @IBOutlet weak var lineView: UIView!
    @IBOutlet weak var outerView: UIView!
    @IBOutlet weak var arrowIcon: UIButton!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    
    //MARK: - View Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = .clear
        internalTableView.isHidden = true
        internalTableView.delegate = self
        internalTableView.dataSource = self
        internalTableView.registerCell(with: SubCategoryTableViewCell.self)
        internalTableView.registerCell(with: ViewMoreCell.self)
        internalTableView.estimatedRowHeight = 36
        self.internalTableView.tableFooterView?.height = 18.0
        internalTableView.rowHeight = UITableView.automaticDimension
        internalTableView.allowsSelection = true
        internalTableView.backgroundColor =  UIColor.black.withAlphaComponent(0.75)
        self.isRowShow = !self.internalTableView.isHidden
        self.footerView()
        // Initialization code
    }
    
    var isRowShow: Bool = false{
        didSet{
            lineView.backgroundColor = !isRowShow ? .white : .black
            arrowIcon.setImage(!isRowShow ? UIImage(named: "icons8-arrow_up-35")! : UIImage(named: "icons8-arrow-35")! , for: .normal)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imgView.layer.cornerRadius = 5.0
        outerView.layer.cornerRadius = 5.0
    }
    
    //MARK: - IBActions
    @IBAction func sectionTapped(_ sender: UIButton) {
        if let handle = buttonTapped{
            handle(sender)
        }
    }
}

    //MARK: - Extension
    //MARK: Configure
extension CategoryTitleCell {
    func configure(withModel model: Goal) {
        self.model = model
        self.titleLbl.text = model.title
        self.internalTableView.reloadData()
    }
    
    func configuree(withModel model: Category) {
        self.modele = model
        
//        let myChar: UniChar = 0xf48b
//        let fontref = UIFont(name: CustomFonts.FASharpLight, size: 20.0)
//        self.titleLbl.font = fontref
//        self.titleLbl.text = String(format: "%C", myChar)
        self.titleLbl.text = modele?.name?.en ?? ""
//        String(format: "%C", myChar) //modele?.name?.en ?? ""
//        self.titleLbl.textColor = .blue
        //
        //
        var classNameArr: [String]? = []
        if ((modele?.classImage?.contains(" ")) != nil){
            classNameArr = modele?.classImage?.components(separatedBy: " ") ?? []
        }else{
            classNameArr = [modele?.classImage ?? ""]
        }
//        switch classNameArr?.first{
//        case  "fa-solid":
//
//            self.imgView.image =
//            UIImage.fontAwesomeIcon(code: classNameArr?.last ?? "", style: .solid, textColor: .white, size: CGSize(width: 30, height: 30))
//            //            UIImage.fontAwesomeIcon(name: FontAwesome.monkey, style: .solid, textColor: .white, size: CGSize(width: 30, height: 30))
//        case "fa-brands":
//            self.imgView.image = UIImage.fontAwesomeIcon(code: classNameArr?.last ?? "", style: .brands, textColor: .white, size: CGSize(width: 30, height: 30))
//        case "fa-light":
//            self.imgView.image = UIImage.fontAwesomeIcon(code: FontAwesome.icons.rawValue, style: .light, textColor: .red, size: CGSize(width: 30, height: 30))
//        case "fa-thin":
//            self.imgView.image = UIImage.fontAwesomeIcon(code: classNameArr?.last ?? "", style: .regular, textColor: .white, size: CGSize(width: 30, height: 30))
//        default:
//            self.imgView.image = UIImage.fontAwesomeIcon(code: classNameArr?.last ?? "", style: .regular, textColor: .white, size: CGSize(width: 30, height: 30))
//        }
        if self.imgView.image ==  nil {
            self.imgView.image = UIImage(named: "ic_bestseller") 
        }
        print(modele?.name?.en ?? "")
        print(modele?.classImage ?? "")
        self.internalTableView.reloadData()
    }
    
    func footerView() {
        let view = UIView(frame: CGRect.init(origin: CGPoint.zero, size: CGSize(width: self.contentView.frame.width, height: 18.0)))
        view.backgroundColor = UIColor.clear
        self.internalTableView.tableFooterView = view
    }

}

   //MARK: - Tableview delegates
extension CategoryTitleCell: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let index  = hiddenSections.firstIndex(where: {$0.0 == selectedIndexPath?.row ?? 0}){
            if ((modele?.children?.count ?? 0) > maxCountForViewMore) && !hiddenSections[index].1{
                return maxCountForViewMore
            }else{
                if ((modele?.children?.count ?? 0) > maxCountForViewMore){
                    return modele?.children?.count ?? 0 + 1
                }
                return modele?.children?.count ?? 0
            }
        }else{
            if ((modele?.children?.count ?? 0) > maxCountForViewMore){
                return maxCountForViewMore
            }else{
                if ((modele?.children?.count ?? 0) > maxCountForViewMore){
                    return modele?.children?.count ?? 0 + 1
                }
                return modele?.children?.count ?? 0
            }
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let index = hiddenSections.firstIndex(where: {$0.0 == selectedIndexPath?.row ?? 0}){
            if ((maxCountForViewMore-1) == indexPath.row) && !hiddenSections[index].1{
                let cell = tableView.dequeueCell(with: ViewMoreCell.self, indexPath: indexPath)
                cell.titleLbl.text = "View More"
                //MARK: - Cell Button Action
                cell.ViewMoreButtonTapped = { [weak self] (btn) in
                    guard let `self` = self else { return }
                    hiddenSections[index].1 = true
                    (self.parentViewController as? CategoryVC)?.viewMoreLessbtnAction(section: selectedIndexPath?.row ?? 0)
                }
                return cell
            }else if ((modele?.children?.count ?? 0) > maxCountForViewMore) && (indexPath.row == ((modele?.children?.count ?? 0)-1)){
                let cell = tableView.dequeueCell(with: ViewMoreCell.self, indexPath: indexPath)
                cell.titleLbl.text = "View Less"
                //MARK: - Cell Button Action
                cell.ViewLessButtonTapped = { [weak self] (btn) in
                    guard let `self` = self else { return }
                    hiddenSections[index].1 = false
                    (self.parentViewController as? CategoryVC)?.viewMoreLessbtnAction(section: selectedIndexPath?.row ?? 0)
                }
                return cell
            }else{
                let cell = tableView.dequeueCell(with: SubCategoryTableViewCell.self)
                let action = modele?.children?[indexPath.row] ?? Child()
                cell.configuree(withModel: action)
                return cell
            }
        }else{
            if ((maxCountForViewMore-1) == indexPath.row){
                let cell = tableView.dequeueCell(with: ViewMoreCell.self, indexPath: indexPath)
                cell.titleLbl.text = "View More"
                //MARK: - Cell Button Action
                cell.ViewMoreButtonTapped = { [weak self] (btn) in
                    guard let `self` = self else { return }
                    if let index = hiddenSections.firstIndex(where: {$0.0 == self.selectedIndexPath?.row ?? 0}){
                        hiddenSections[index].1 = true
                    }
                    UIView.transition(with: containerStackView,
                                      duration: 0.3,
                                      options: .curveEaseInOut) {
                        self.containerStackView.setNeedsLayout()
                        (self.parentViewController as? CategoryVC)?.dataTableView.performBatchUpdates({
                            (self.parentViewController as? CategoryVC)?.dataTableView.reloadRows(at: [IndexPath(row: self.selectedIndexPath?.row ?? 0, section: self.selectedIndexPath?.section ?? 0)], with: .automatic)
                        })
                    }
                }
                return cell
            }else{
                let cell = tableView.dequeueCell(with: SubCategoryTableViewCell.self)
                let action = modele?.children?[indexPath.row] ?? Child()
                cell.configuree(withModel: action)
                return cell
            }
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 36.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let selectedIndexPath = selectedIndexPath   {
            self.helperDelegate?.cellSelected(selectedIndexPath,index: indexPath)
        }
    }
}


struct CustomFonts {
    static let FAProBrands = "FontAwesome6Brands-Regular"
    static let FAProDuotone = "FontAwesome6Pro-Duotone"
    static let FAProLight = "FontAwesome6Pro-Light"
    static let FAProRegular = "FontAwesome6Pro-Regular"
    static let FASharpLight = "FontAwesome6Sharp-Light"
    static let FASharpRegular = "FontAwesome6Sharp-Regular"
    static let FASharpSolid = "FontAwesome6Sharp-Solid"
    static let FASolid = "FontAwesome6Pro-Solid"
    static let FAThin = "FontAwesome6Pro-Thin"
}
