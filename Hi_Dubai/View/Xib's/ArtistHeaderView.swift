//
//  ArtistHeaderView.swift
//  Hi_Dubai
//
//  Created by Asif Khan on 15/06/2023.
//


import UIKit
import Foundation

protocol ArtistHeaderViewDelegate: NSObjectProtocol {
    func detailBtnAction(sender: UIButton)
    func otherInfomation()
}

class ArtistHeaderView: UIView {

    enum typeOfView {
        case otherUserProfile
    }
    
    weak var delegate: ArtistHeaderViewDelegate?
    var mainIMgContainerView : UIView?
    
    //MARK:- IBOUTLETS
    //==================
    @IBOutlet weak var mainImgView: UIImageView!
   
    
    override func setNeedsLayout() {
        super.setNeedsLayout()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    //MARK:- VIEW LIFE CYCLE
    //=====================
    override func awakeFromNib() {
        super.awakeFromNib()
      
    }
    
    
    
    //MARK:- PRIVATE FUNCTIONS
    //=======================
    

    
    //MARK:- IBACTIONS
    //==================
    
   
    class func instanciateFromNib() -> ArtistHeaderView {
        return Bundle.main.loadNibNamed("ArtistHeaderView", owner: self, options: nil)![0] as! ArtistHeaderView
    }
    
    
    
}
