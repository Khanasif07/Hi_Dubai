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
    var buttonTapped: ((UIButton) -> Void)?
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
    @IBAction func btnAction(_ sender: UIButton) {
        if let handle = buttonTapped{
            handle(sender)
        }
    }
    
    private func configureUI() {

        self.profileImageView?.layer.cornerRadius = 7.5
        self.userName.textColor = .white
        self.locationName.textColor = UIColor.white.withAlphaComponent(0.75)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.userName.text = nil
        self.locationName.text = nil
        self.profileImageView?.image = nil
    }
    
    func populateCell(_ model: NewsModel?){
        profileImageView?.loadThumbnail(urlSting: model?.postImageURL ?? "")
        userName.text = model?.primaryTag ?? ""
        clapBtnOutlet.setImage(UIImage(named: model?.isSelected ?? false ? "following" : "plus_blue_icon"), for: .normal)
    }
    
    func populatePumpkinCell(_ model: Pumpkin?){
        profileImageView?.loadThumbnail(urlSting: model?.imageURL ?? "")
        userName.text = model?.name ?? ""
        locationName.text = model?.tagline ?? ""
        clapBtnOutlet.setImage(UIImage(named: model?.isSelected ?? false ? "following" : "plus_blue_icon"), for: .normal)
    }
    
    func populateMovieCell(_ model: Movie?){
        clapBtnOutlet.setImage(UIImage(named: model?.isSelected ?? false ? "following" : "plus_blue_icon"), for: .normal)
        userName.text = model?.title ?? ""
        locationName.text = model?.overview ?? ""
        profileImageView?.loadThumbnail(urlSting: model?.posterURL ?? "")
    }
    
}

