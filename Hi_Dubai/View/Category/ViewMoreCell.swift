//
//  ViewMoreCell.swift
//  Hi_Dubai
//
//  Created by Asif Khan on 03/07/2023.
//


import UIKit

class ViewMoreCell: UITableViewCell {
    var buttonTapped: ((UIButton) -> Void)?

    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var outerView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = .clear
        // Initialization code
    }
    
    
    @IBAction func viewMoreTapped(_ sender: UIButton) {
        if let handle = buttonTapped{
            handle(sender)
        }
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
//        outerView.roundCorners([.bottomLeft,.bottomRight], radius: 5.0)
    }
    
}
