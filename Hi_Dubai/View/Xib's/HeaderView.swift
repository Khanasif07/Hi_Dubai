//
//  HeaderView.swift
//  Hi_Dubai
//
//  Created by Admin on 11/02/23.
//

import Foundation
import UIKit

class HeaderView: UIView {
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var tagLbl: UILabel!
    @IBOutlet weak var topContainerView: UIView!
    @IBOutlet weak var playerImageView: UIImageView!
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var topContainerHeight: NSLayoutConstraint!

    
    override func awakeFromNib() {
        super.awakeFromNib()
        tagLbl.font = UIFont.boldSystemFont(ofSize: 24)
        tagLbl.textColor = .white
        let cross = #imageLiteral(resourceName: "iconfinder_cross-24_103181").withRenderingMode(.alwaysTemplate)
        backBtn.setImage(cross, for: .normal)
        backBtn.tintColor = .white
    }
    
}
