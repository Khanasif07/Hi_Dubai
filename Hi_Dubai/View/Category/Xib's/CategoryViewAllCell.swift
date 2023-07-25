//
//  CategoryViewAllCell.swift
//  Hi_Dubai
//
//  Created by Asif Khan on 25/07/2023.
//

import UIKit

class CategoryViewAllCell: UITableViewCell {
    var seeMoreBtnTapped:((UIButton)->Void)?

    @IBOutlet weak var seeMoreBtn: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        seeMoreBtn.layer.cornerRadius = 20.0
    }

    @IBAction func seeMoreBtnAction(_ sender: UIButton) {
        if let handle = seeMoreBtnTapped{
            handle(sender)
        }
    }
}
