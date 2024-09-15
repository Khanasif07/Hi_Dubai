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
    
    //MARK:- LifeCycle
    override func awakeFromNib() {
        super.awakeFromNib()
        self.configureUI()
    }
    
    //MARK:- Functions
    
    /// Call to configure ui
    private func configureUI() {
        self.containerView.backgroundColor = AppColors.black
    }
    
    
    //MARK:- IBActions
}

//MARK:- Extensions
