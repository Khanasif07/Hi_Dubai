//
//  MusicCollCell.swift
//  Hi_Dubai
//
//  Created by Asif Khan on 06/06/2023.
//

import UIKit

class MusicCollCell: UICollectionViewCell {

    @IBOutlet var iconView: UIView!
    @IBOutlet var buyButton: UIButton!
    @IBOutlet var titleLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()

        iconView.clipsToBounds = true
        iconView.layer.cornerRadius = 8

        buyButton.clipsToBounds = true
        buyButton.layer.cornerRadius = 8
    }


}
