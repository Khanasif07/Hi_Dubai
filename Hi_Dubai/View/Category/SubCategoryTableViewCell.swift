//
//  SubCategoryTableViewCell.swift
//  Hi_Dubai
//
//  Created by Asif Khan on 03/07/2023.
//


import UIKit

class SubCategoryTableViewCell: UITableViewCell {
    
    var model: Action?
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var outerView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    var isLastRow: Bool = false{
        didSet{
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
//        isLastRow ? outerView.roundCorners([.bottomLeft,.bottomRight], radius: 5.0) : outerView.roundCorners(.allCorners, radius: 0.0)
    }
    
    func configure(withModel model: Action) {
        self.model = model
        self.titleLbl.text = model.title
    }

    
}
