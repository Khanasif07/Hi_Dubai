//
//  OtherArtistHeaderView.swift
//  Hi_Dubai
//
//  Created by Asif Khan on 01/05/2023.
//


import UIKit
import Foundation

protocol OtherArtistHeaderViewDelegate: NSObjectProtocol {
    func detailBtnAction(sender: UIButton)
    func otherInfomation()
}

class OtherArtistHeaderView: UIView {
    
    
    enum typeOfView {
        case otherUserProfile
    }
    
    weak var delegate: OtherArtistHeaderViewDelegate?
    var mainIMgContainerView : UIView?
    
    //MARK:- IBOUTLETS
    //==================
    @IBOutlet weak var mainStackView: UIStackView!
    @IBOutlet var detailBtn: [UIButton]!
    @IBOutlet weak var profileNameLbl: UILabel!
    @IBOutlet weak var mainImgBackView: GradientView!
    @IBOutlet weak var watchBtn: UIButton!
    @IBOutlet weak var watchIconView: UIView!
    @IBOutlet weak var stockPriceView: UIView!

    @IBOutlet var detailImgView: [UIButton]!
    @IBOutlet weak var mainImgView: UIImageView!
    @IBOutlet weak var bottomAnimationView: UIView!
    @IBOutlet weak var bottomAnimationHC: NSLayoutConstraint!
    @IBOutlet weak var valueLabel: UILabel!
    
    
    var currentlyUsingAs = typeOfView.otherUserProfile {
        didSet {
            switch currentlyUsingAs {
            case .otherUserProfile:
                self.setupForotherUserProfile()
            }
        }
    }
    
    
    override func setNeedsLayout() {
        super.setNeedsLayout()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
//        self.stockPriceView.roundCorners([.topRight,.bottomRight], radius: 12.5)
    }
    
    //MARK:- VIEW LIFE CYCLE
    //=====================
    override func awakeFromNib() {
        super.awakeFromNib()
        self.initialSetUp()
        
    }
    
    
    
    //MARK:- PRIVATE FUNCTIONS
    //=======================
    
    private func initialSetUp() {
        self.watchIconView.applyGradient(colors: [UIColor.init(r: 34, g: 131, b: 184, alpha: 1.0).cgColor,UIColor.init(r: 15, g: 76, b: 130, alpha: 1.0).cgColor])
        self.scrollButtonSetUp()
        
       
    }
    
    
    private func scrollButtonSetUp() {
        detailImgView.forEach { (button) in
            detailBtn[button.tag].roundCorners([.allCorners], radius: 15)
        }
        detailBtnAction(detailBtn[0])
    }
    
    private func addGradientOnView() {
        self.mainImgBackView.layer.masksToBounds = true
        self.mainImgBackView.addGradient(colors: UIColor.AppColor.otherUserProfileGradientColors)
    }
    
    
    private func setupForotherUserProfile() {
       self.addGradientOnView()
    }
    
    
//    public func ConfigureHeaderData(model: Artist) {
////        self.mainImgView.setImage(withUrl: model.img, placeholderImage: nil)
//        self.profileNameLbl.text = model.name
//
//    }
    
    public func ConfigureHeaderDataForUserPortfolio(){
        self.profileNameLbl.text = "Joe Biden"
        self.watchIconView.isHidden = true
        self.stockPriceView.backgroundColor = UIColor(r: 255, g: 0, b: 68, alpha: 0.6)
    }
    
    public func ConfigureHeaderDataForArtistModel() {
        self.profileNameLbl.text = "Joe Biden"
    }
 
//    public func ConfigureHeaderDataForYouArtistModel(model: ForYouModel) {
//         self.mainImgView.image = model.image
//         self.profileNameLbl.text = model.title
//     }
//
//    public func ConfigureHeaderDataForBuyPlaylistModel() {
////        self.mainImgView.image = model.image
//        self.profileNameLbl.text = "Joe Biden"
//        self.stockPriceView.backgroundColor = model.isPositiveChange ? UIColor.init(r: 89, g: 161, b: 7, alpha: 0.6) : UIColor.init(r: 255, g: 0, b: 68, alpha: 0.6)
//     }
    
    
    //MARK:- IBACTIONS
    //==================
    @IBAction func detailBtnAction(_ sender: UIButton) {
        detailImgView.forEach { (button) in
            if button.tag == sender.tag{
                detailImgView[sender.tag].alpha = 1.0
                detailBtn[sender.tag].alpha = 1.0
                detailBtn[sender.tag].alpha = 1.0
                detailBtn[button.tag].backgroundColor = .blue
                detailBtn[button.tag].setTitleColor(.white, for: .normal)
            }else{
                detailImgView[button.tag].alpha = 0.0
                detailBtn[button.tag].alpha = 0.70
                detailBtn[button.tag].backgroundColor = .white
                detailBtn[button.tag].setTitleColor(.blue, for: .normal)
            }
        }
        self.delegate?.detailBtnAction(sender: sender)
    }
    
    @IBAction func watchBtnActions(_ sender: UIButton) {
        self.watchBtn.setImage( sender.isSelected ?  #imageLiteral(resourceName: "icWatch") : #imageLiteral(resourceName: "icUnwatch") , for: .normal)
//
        if sender.isSelected {   self.watchIconView.applyGradient(colors: [UIColor.init(r: 34, g: 131, b: 184, alpha: 1.0).cgColor,UIColor.init(r: 15, g: 76, b: 130, alpha: 1.0).cgColor])
            //  self.stockPriceView.backgroundColor = UIColor.init(r: 89, g: 161, b: 7, alpha: 0.6)
            } else { if let layer = watchIconView.layer.sublayers?.first {
                layer.removeFromSuperlayer ()
            self.watchIconView.backgroundColor = .white
//            self.stockPriceView.backgroundColor = UIColor.init(r: 255, g: 0, b: 68, alpha: 0.6)
            }
        }
        self.watchBtn.isSelected =  !sender.isSelected
    }
    
    @IBAction func clickInformationIcon(_ sender: Any) {
        self.delegate?.otherInfomation()
    }
    
    
    class func instanciateFromNib() -> OtherArtistHeaderView {
        return Bundle .main .loadNibNamed("OtherArtistHeaderView", owner: self, options: nil)![0] as! OtherArtistHeaderView
    }
    
    
    
}
