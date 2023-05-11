//
//  EmptyStateView.swift
//  Hi_Dubai
//
//  Created by Asif Khan on 10/05/2023.
//

import UIKit
import Foundation
class EmptyStateView: UIView {
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var text: UILabel!
    @IBOutlet weak var learnHow: UIButton!
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var verticalAlignmentConstraint: NSLayoutConstraint!
    @IBOutlet weak var mainContainerView: UIStackView!
    @IBOutlet weak var whiteContainer: UIView!
  
    //MARK:- IBOUTLETS
    //==================
    func show() {
        self.isHidden = false
    }

    func hide() {
        self.isHidden = true
    }
    
    override func setNeedsLayout() {
        super.setNeedsLayout()
    }
    
    //MARK:- VIEW LIFE CYCLE
    //=====================
    override func awakeFromNib() {
        super.awakeFromNib()
        self.initialSetUp()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.whiteContainer.setCircleBorder(weight: 1.0, color: .lightGray)
    }
    
    class func instanciateFromNib() -> EmptyStateView {
        return Bundle .main .loadNibNamed("EmptyStateView", owner: self, options: nil)![0] as! EmptyStateView
    }
    
    //MARK:- PRIVATE FUNCTIONS
    //=======================
    
    private func initialSetUp() {
        self.whiteContainer.backgroundColor = .yellow
    }
}
