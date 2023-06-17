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

        self.profileImageView?.layer.cornerRadius = (self.profileImageView?.height ?? 0) / 2.0
        self.userName.textColor = .white
        self.locationName.textColor = UIColor.white.withAlphaComponent(0.75)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    func populateCell(_ model: Record?){
        profileImageView?.setImageFromUrl(ImageURL: model?.postImageURL ?? "")
        userName.text = model?.primaryTag ?? ""
        clapBtnOutlet.setImage(UIImage(named: model?.isSelected ?? false ? "remove_icon_blue" : "plus_blue_icon"), for: .normal)
    }
}

