//
//  PlacesAndSuperShesViewTableViewCell.swift
//  Hi_Dubai
//
//  Created by Asif Khan on 17/05/2023.
//

import UIKit
class PlacesAndSuperShesViewTableViewCell: UITableViewCell {
    //MARK: - Variables
    //MARK: ===========
    
    //MARK:- IBOutlets
    //MARK:===========
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var profileImageView: UIImageView?
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var clapBtnOutlet: UIButton!
    @IBOutlet weak var locationName: UILabel!
    
    //MARK: - LifeCycle
    //MARK: ===========
    override func awakeFromNib() {
        super.awakeFromNib()
        self.configureUI()
    }
    
    //MARK:- Functions
    //MARK:===========
    private func configureUI() {
//        self.userName.text = ""
//        self.locationName.text = ""
//        self.heartImageView.isHidden = true
//        self.clapBtnOutlet.isHidden = true
        self.profileImageView?.layer.cornerRadius = (self.profileImageView?.height ?? 0) / 2.0
        self.userName.textColor = .white
        self.locationName.textColor = UIColor.white.withAlphaComponent(0.75)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
//        self.userName.text = ""
//        self.locationName.text = ""
//        self.heartImageView.isHidden = true
//        self.clapBtnOutlet.isHidden = true
//        self.profileImageView?.image = nil
//        self.locationName.textColor = .clear
//        self.userName.textColor = .clear
    }
}

