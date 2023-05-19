//
//  SuperYouTitleTableViewCell.swift
//  Hi_Dubai
//
//  Created by Asif Khan on 17/05/2023.
//

import UIKit
class SuperYouTitleTableViewCell: UITableViewCell {
    
    //MARK:- Variables
    
    
    //MARK:- IBOutlets
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var titleLabelLeadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var titleLabelTrailingCOnstraint: NSLayoutConstraint!
    @IBOutlet weak var subTitleLabel: UILabel!
    @IBOutlet weak var subTitleTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var subTitleBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var subTitleLabelLeadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var subTitleLabelTrailingCOnstraint: NSLayoutConstraint!
    @IBOutlet weak var emptyLabelOne: UILabel!
    
    //MARK:- LifeCycle
    override func awakeFromNib() {
        super.awakeFromNib()
        self.configureUI()
    }
    
    //MARK:- Functions
    
    /// Call to configure ui
    private func configureUI() {
        self.containerView.backgroundColor = AppColors.black
        self.titleLabel.textColor = UIColor.clear
        self.subTitleLabel.textColor = UIColor.clear
        self.emptyLabelOne.textColor = UIColor.clear
        self.titleLabel.font = AppFonts.BoldItalic.withSize(32.0)
        self.subTitleLabel.font = AppFonts.BoldItalic.withSize(19.0)
    }
    
    ///Call to populates data
    internal func configureCell(startTitle: String, firstName: String, subtitle: String) {
        self.setUpShimmer()
        self.emptyLabelOne.text = ""
        self.constraintSetUp()
        self.titleLabel.textColor = AppColors.white
        self.subTitleLabel.textColor = AppColors.white
        self.subTitleLabel.numberOfLines = 3
        self.titleLabel.text = "\(startTitle.uppercased()), \(firstName.uppercased())"
        self.subTitleLabel.text = subtitle
    }
    
    func setUpShimmer() {
        self.titleLabel.textColor = AppColors.white
        self.subTitleLabel.textColor = AppColors.white
        self.emptyLabelOne.textColor = AppColors.white
    }
    
    private func constraintSetUp() {
        self.titleLabelLeadingConstraint.constant = 60.0
        self.titleLabelTrailingCOnstraint.constant = 60.0
        self.subTitleLabelLeadingConstraint.constant = 35.0
        self.subTitleLabelTrailingCOnstraint.constant = 35.0
        self.subTitleTopConstraint.constant = 2
        self.subTitleBottomConstraint.constant = 0.0
    }
    
    
    //MARK:- IBActions
}

//MARK:- Extensions
