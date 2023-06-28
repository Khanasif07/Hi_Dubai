//
//  CategoryHeaderView.swift
//  Hi_Dubai
//
//  Created by Asif Khan on 27/06/2023.
//

import UIKit
import Foundation

class CategoryHeaderView: UIView {
    
  
    //MARK:- IBOUTLETS
    //==================
    @IBOutlet weak var searchTxtFld: NewSearchTextField!
    //    @IBOutlet weak var searchTxtFld: UIView!
//    @IBOutlet weak var scrollView: UIScrollView!
    

    override func setNeedsLayout() {
        super.setNeedsLayout()
    }
    
    //MARK:- VIEW LIFE CYCLE
    //=====================
    override func awakeFromNib() {
        super.awakeFromNib()
        self.initialSetUp()
        
    }
    
    
    class func instanciateFromNib() -> CategoryHeaderView {
        return Bundle .main .loadNibNamed("CategoryHeaderView", owner: self, options: nil)![0] as! CategoryHeaderView
    }
    
    
    
    //MARK:- PRIVATE FUNCTIONS
    //=======================
    
    private func initialSetUp() {
//        searchTxtFld.delegate = self
        searchTxtFld.roundedView.backgroundColor = .black
        searchTxtFld.setPlaceholder(placeholder: "Search category...")
    }

}
