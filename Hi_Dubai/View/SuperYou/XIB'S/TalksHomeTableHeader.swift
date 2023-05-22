//
//  TalksHomeTableHeader.swift
//  Hi_Dubai
//
//  Created by Asif Khan on 17/05/2023.
//

import UIKit

class TalksHomeTableHeader: UITableViewHeaderFooterView {

    var btnViewAllAction : (()->Void)?
    
    @IBOutlet weak var outerView: UIView!
    @IBOutlet weak var mainLabel: UILabel!
    @IBOutlet weak var titleLeadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var trailingLeadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var btnViewAll: UIButton!

    
    @IBAction func btnViewAllAction(_ sender: Any) {
        btnViewAllAction?()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        btnViewAll.isHidden = true
        mainLabel.textColor = AppColors.white
        mainLabel.font  = AppFonts.BoldItalic.withSize(15.0)
        btnViewAll.titleLabel?.font = AppFonts.BoldItalic.withSize(14.0)
    }
    
    func isClass() {
        mainLabel.textColor = AppColors.white
        btnViewAll.isHidden = false
    
    }
    
    func showViewAll(_ toShow : Bool) {
        btnViewAll.isHidden = !toShow
    }
    
    func headerViewSetUpForSuperYou(title: String, toShowSeeAll : Bool) {
        self.mainLabel.numberOfLines = 2
        self.mainLabel.attributedText = nil
        self.titleLeadingConstraint.constant = 18.0
        self.trailingLeadingConstraint.constant = 18.0
        self.mainLabel.text = title.uppercased()
        self.mainLabel.font = AppFonts.BoldItalic.withSize(15.0)
//        self.btnViewAll.setTitle(LS.viewAll.localized, for: .normal)
        self.btnViewAll.titleLabel?.font = AppFonts.BoldItalic.withSize(14.0)
        self.btnViewAll.isHidden = false
        showViewAll(toShowSeeAll)
    }
        
    func headerViewAttributedSetUpForSuperYou(title: String, subtitle: String, toShowSeeAll : Bool) {
        self.mainLabel.numberOfLines = 0
        self.mainLabel.text = nil
        self.titleLeadingConstraint.constant = 18.0
        self.trailingLeadingConstraint.constant = 18.0
        self.btnViewAll.titleLabel?.font = AppFonts.BoldItalic.withSize(12)
        self.btnViewAll.isHidden = false
        let attributedString = NSMutableAttributedString()
        let boldAttribute = [NSAttributedString.Key.font: AppFonts.BoldItalic.withSize(15.0), NSAttributedString.Key.foregroundColor: AppColors.white] as [NSAttributedString.Key : Any]
        
        let clearAtrribute = [NSAttributedString.Key.font: AppFonts.SemiBoldItalic.withSize(12.0), NSAttributedString.Key.foregroundColor: UIColor.clear] as [NSAttributedString.Key : Any]

        let regularAtrribute = [NSAttributedString.Key.font: AppFonts.BoldItalic.withSize(12.0), NSAttributedString.Key.foregroundColor: AppColors.white]
        
        let boldAttributedString = NSAttributedString(string: title.uppercased(), attributes: boldAttribute)
        
        let clearLineStr = NSAttributedString(string: "\n", attributes: clearAtrribute)
        
        let regularAttributedString = NSAttributedString(string: "\(subtitle)", attributes: regularAtrribute)
        
        attributedString.append(boldAttributedString)
        attributedString.append(clearLineStr)
        attributedString.append(regularAttributedString)
        
        self.mainLabel.attributedText = attributedString
        showViewAll(toShowSeeAll)
    }


}
