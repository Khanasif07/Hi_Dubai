//
//  CategoriesSectionView.swift
//  Hi_Dubai
//
//  Created by Asif Khan on 26/06/2023.
//

import UIKit

class CategoriesSectionView: UITableViewHeaderFooterView {
    
    var buttonTapped: ((UIButton) -> Void)?

    @IBOutlet weak var lineView: UIView!
    @IBOutlet weak var outerView: UIView!
    @IBOutlet weak var arrowIcon: UIButton!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    
    var isRowShow: Bool = false{
        didSet{
            lineView.isHidden = isRowShow
            arrowIcon.setImage(!isRowShow ? UIImage(named: "icons8-arrow_up-35")! : UIImage(named: "icons8-arrow-35")! , for: .normal)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imgView.layer.cornerRadius = 5.0
        isRowShow ? outerView.roundCorners(.allCorners, radius: 5.0) : outerView.roundCorners([.topLeft,.topRight], radius: 5.0)
    }
    
    @IBAction func sectionTapped(_ sender: UIButton) {
        if let handle = buttonTapped{
            handle(sender)
        }
    }
    
}
