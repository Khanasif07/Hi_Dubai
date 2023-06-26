//
//  TitleTableViewCell.swift
//  Hi_Dubai
//
//  Created by Asif Khan on 26/06/2023.
//

import UIKit

class TitleTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var outerView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    var isLastRow: Bool = false{
        didSet{
            isLastRow ?outerView.roundCorners([.bottomLeft,.bottomRight], radius: 5.0) : outerView.roundCorners(.allCorners, radius: 0.0)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        isLastRow ? outerView.roundCorners([.bottomLeft,.bottomRight], radius: 5.0) : outerView.roundCorners(.allCorners, radius: 0.0)
    }

    
}
