//
//  MenuItemView.swift
//  Hi_Dubai
//
//  Created by Asif Khan on 20/07/2023.
//
import UIKit
protocol MenuItemViewDelegate: NSObject{
    func categorySelected(_ model: Category)
}
class MenuItemView: UIView {
    var category: Category?
    weak var delegate: MenuItemViewDelegate?
    let color = UIColor(r: 38, g: 193, b: 188, alpha: 1.0)
//    UIColor(red: CGFloat(38),green: CGFloat(193),blue: CGFloat(188), alpha: CGFloat(1.0))
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
    }
    
    //MARK:- VIEW LIFE CYCLE
    //=====================
    override func awakeFromNib() {
        super.awakeFromNib()
        self.titlelbl.font =  UIFont(name: "Helvetica Neue Medium", size: 12.0)
    }
    
    func configureCell(_ model: Category?){
        self.category = model
        self.dataView.backgroundColor = .black
        self.titlelbl.textColor = color
        self.dataView.setCircleBorder(weight: 1.0, color: color)
       
    }
    
    func configureCellWithTitle(_ model: Category?){
        self.category = model
        self.dataView.backgroundColor = .clear
        self.titlelbl.textColor = color
        self.dataView.setCircleBorder(weight: 0.0, color: .clear)
    }
    
    
    
    //MARK:- PRIVATE FUNCTIONS
    //=======================
    

    
    //MARK:- IBACTIONS
    //==================
    @IBAction func btnTapped(_ sender: UIButton) {
        self.delegate?.categorySelected(category ?? Category())
    }
    
   
    class func instanciateFromNib() -> MenuItemView {
        return Bundle.main.loadNibNamed("MenuItemView", owner: self, options: nil)![0] as! MenuItemView
    }
    
    
    
}
