//
//  MenuItemView.swift
//  Hi_Dubai
//
//  Created by Asif Khan on 20/07/2023.
//
import UIKit
class MenuItemView: UIView {

    //MARK:- IBOUTLETS
    //==================
    @IBOutlet weak var dataView: UIView!
    @IBOutlet weak var titlelbl: UILabel!
   
    
    override func setNeedsLayout() {
        super.setNeedsLayout()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.dataView.layer.cornerRadius = self.dataView.frame.height / 2.0
        self.dataView.setCircleBorder(weight: 0.75, color: .black)
    }
    
    //MARK:- VIEW LIFE CYCLE
    //=====================
    override func awakeFromNib() {
        super.awakeFromNib()
        self.dataView.backgroundColor = .white
    }
    
    
    
    //MARK:- PRIVATE FUNCTIONS
    //=======================
    

    
    //MARK:- IBACTIONS
    //==================
    
   
    class func instanciateFromNib() -> MenuItemView {
        return Bundle.main.loadNibNamed("MenuItemView", owner: self, options: nil)![0] as! MenuItemView
    }
    
    
    
}
