//
//  TitleTableViewLastCell.swift
//  Hi_Dubai
//
//  Created by Asif Khan on 28/06/2023.
//

import UIKit

class TitleTableViewLastCell: UITableViewCell {

    
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var outerView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
   
    
    override func layoutSubviews() {
        super.layoutSubviews()
       outerView.roundCorners([.bottomLeft,.bottomRight], radius: 5.0)
    }
    
}
