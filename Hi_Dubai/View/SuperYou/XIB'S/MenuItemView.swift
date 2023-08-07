//
//  MenuItemView.swift
//  Hi_Dubai
//
//  Created by Asif Khan on 20/07/2023.
//
import UIKit
class MenuItemView: UIView {

    let color = UIColor(red: CGFloat(93/255.0),green: CGFloat(132/255.0),blue: CGFloat(171/255.0), alpha: CGFloat(1.0))
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
        self.dataView.setCircleBorder(weight: 0.75, color: color)
    }
    
    //MARK:- VIEW LIFE CYCLE
    //=====================
    override func awakeFromNib() {
        super.awakeFromNib()
        self.dataView.backgroundColor = .white
        self.titlelbl.font =  UIFont(name: "Helvetica Neue Medium", size: 12.0)
    }
    
    func configureCell(){
        self.dataView.backgroundColor = .black
        self.titlelbl.textColor = color
        self.dataView.backgroundColor = .white
    }
    
    func configureCellWithTitle(){
        self.titlelbl.textColor = color
        self.titlelbl.textColor = .white
        self.dataView.backgroundColor = .clear
        self.dataView.setCircleBorder(weight: 0.0, color: .clear)
    }
    
    
    
    //MARK:- PRIVATE FUNCTIONS
    //=======================
    

    
    //MARK:- IBACTIONS
    //==================
    
   
    class func instanciateFromNib() -> MenuItemView {
        return Bundle.main.loadNibNamed("MenuItemView", owner: self, options: nil)![0] as! MenuItemView
    }
    
    
    
}
