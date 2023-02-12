//
//  NewsCollViewCell.swift
//  Hi_Dubai
//
//  Created by Admin on 11/02/23.
//

import UIKit

class NewsCollViewCell: UICollectionViewCell {

    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var newsImgView: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func populateCell(_ model: Record){
        titleLbl.text = model.title
        newsImgView.setImageFromUrl(ImageURL: model.postImageURL)
    }

}
