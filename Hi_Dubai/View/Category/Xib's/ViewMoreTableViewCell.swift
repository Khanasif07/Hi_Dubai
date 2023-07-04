//
//  ViewMoreTableViewCell.swift
//  Hi_Dubai
//
//  Created by Asif Khan on 28/06/2023.
//

import UIKit

class ViewMoreTableViewCell: UITableViewCell {
    var buttonTapped: ((UIButton) -> Void)?

    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var outerView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    @IBAction func viewMoreTapped(_ sender: UIButton) {
        if let handle = buttonTapped{
            handle(sender)
        }
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.outerView.roundCorners([.bottomLeft,.bottomRight], radius: 5.0)
    }
    
}
