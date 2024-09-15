//
//  TitleTableViewCell.swift
//  Hi_Dubai
//
//  Created by Asif Khan on 26/06/2023.
//

import UIKit

class TitleTableViewCell: UITableViewCell {
    
    var model: Action?
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var outerView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    func configure(withModel model: Action) {
        self.model = model
        self.titleLbl.text = model.title
    }

    
}
