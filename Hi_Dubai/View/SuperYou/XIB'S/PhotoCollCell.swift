//
//  PhotoCollCell.swift
//  Hi_Dubai
//
//  Created by Asif Khan on 07/06/2023.
//

import UIKit
import SwiftUI
class PhotoCollCell: UICollectionViewCell {
    
    var animal: Animal?

    @IBOutlet weak var dataView: UIView!
    
    
    lazy var host: UIHostingController? = {
        return UIHostingController(rootView: GalleryView(animal: animal))
    }()
       
    override func awakeFromNib() {
        super.awakeFromNib()
        dataView.isHidden = true
        host?.view.frame = self.contentView.bounds
        contentView.addSubview((host?.view)!)
        // Initialization code
    }
    
    func embed(in parent: UIViewController, withContent: Animal?) {
        self.animal = withContent
        if let host = self.host {
            host.rootView.animal = animal
            host.view.layoutIfNeeded()
        } else{
            host = UIHostingController(rootView: GalleryView(animal: animal))
            parent.addChild(host!)
            host?.didMove(toParent: parent)
            print("MyCollectionViewCell has been added to parent UIViewController")
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        host?.view.frame = self.contentView.bounds
    }
    
    deinit {
        host?.willMove(toParent: nil)
        host?.view.removeFromSuperview()
        host?.removeFromParent()
        host = nil
        print("MyCollectionViewCell has been cleaned up")
    }

}
