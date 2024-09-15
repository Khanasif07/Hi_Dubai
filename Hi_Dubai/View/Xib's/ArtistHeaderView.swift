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
    var headerVC: ProfileHeaderPagerViewController?
    
    //MARK:- IBOUTLETS
    //==================
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var mainImgView: UIImageView!
    @IBOutlet weak var pageControl: UIPageControl!
    
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
        mainImgView.isHidden = true
        headerVC = ProfileHeaderPagerViewController.instantiate(fromAppStoryboard: .Main)
        headerVC?.headerView = self
        headerVC?.view.frame = containerView.bounds
        containerView.addSubview((headerVC?.view!)!)
    }
    
    
    
    //MARK:- PRIVATE FUNCTIONS
    //=======================
    

    
    //MARK:- IBACTIONS
    //==================
    
   
    class func instanciateFromNib() -> ArtistHeaderView {
        return Bundle.main.loadNibNamed("ArtistHeaderView", owner: self, options: nil)![0] as! ArtistHeaderView
    }
    
    
    
}
