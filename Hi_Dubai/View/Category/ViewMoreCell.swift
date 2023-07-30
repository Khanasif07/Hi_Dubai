//
//  ViewMoreCell.swift
//  Hi_Dubai
//
//  Created by Asif Khan on 03/07/2023.
//


import UIKit

class ViewMoreCell: UITableViewCell {
    var ViewMoreButtonTapped: ((UIButton) -> Void)?
    var ViewLessButtonTapped: ((UIButton) -> Void)?
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var outerView: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = .clear
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    
    @IBAction func viewMoreTapped(_ sender: UIButton) {
        if titleLbl.text == "View More"{
            if let handle = ViewMoreButtonTapped{
                handle(sender)
            }
        }else{
            if let handle = ViewLessButtonTapped{
                handle(sender)
            }
        }
    }
    
    
  
}
