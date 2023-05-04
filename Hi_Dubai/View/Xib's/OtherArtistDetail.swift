//
//  OtherArtistDetail.swift
//  Hi_Dubai
//
//  Created by Asif Khan on 01/05/2023.
//


import UIKit
import Foundation

class OtherArtistDetail: UIView {
    
  
    //MARK:- IBOUTLETS
    //==================
    
    @IBOutlet weak var scrollView: UIScrollView!
    
   
    
    
    
    override func setNeedsLayout() {
        super.setNeedsLayout()
    }
    
    //MARK:- VIEW LIFE CYCLE
    //=====================
    override func awakeFromNib() {
        super.awakeFromNib()
        self.initialSetUp()
        
    }
    
    
    class func instanciateFromNib() -> OtherArtistDetail {
        return Bundle .main .loadNibNamed("OtherArtistDetail", owner: self, options: nil)![0] as! OtherArtistDetail
    }
    
    
    
    //MARK:- PRIVATE FUNCTIONS
    //=======================
    
    private func initialSetUp() {
//        self.headerImgSetUp()
    }
    

    
}
