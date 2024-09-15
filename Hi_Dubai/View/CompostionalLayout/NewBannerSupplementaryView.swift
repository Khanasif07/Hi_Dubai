//
//  NewBannerSupplementaryView.swift
//  Hi_Dubai
//
//  Created by Asif Khan on 07/06/2023.
//

import UIKit

/// A supplementary banner view containing the text "NEW".
final class NewBannerSupplementaryView: UICollectionReusableView {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.borderColor = UIColor.black.cgColor
        layer.borderWidth = 1
    }
}
