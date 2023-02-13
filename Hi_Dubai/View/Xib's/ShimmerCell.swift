//
//  ShimmerCell.swift
//  Hi_Dubai
//
//  Created by Admin on 13/02/23.
//

import UIKit
import SkeletonView
class ShimmerCell: UITableViewCell {
    
    @IBOutlet weak var dataContainerView: UIView!
    @IBOutlet weak var timeLbl: UILabel!
    @IBOutlet weak var tagLbl: UILabel!
    @IBOutlet weak var descLbl: UILabel!
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var newsImgView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        self.showAnimatedCell()
    }
    
    public func showAnimatedCell(_ isShow: Bool = true){
        [newsImgView,descLbl,timeLbl,titleLbl,dateLbl,tagLbl].forEach { view in
            isShow ? view.showSkeleton() : view.hideSkeleton()
        }
    }
}
