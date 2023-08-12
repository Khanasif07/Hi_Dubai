//
//  StuffCollCell.swift
//  Hi_Dubai
//
//  Created by Asif Khan on 09/07/2023.
//

import UIKit
import Combine
class StuffCollCell: UICollectionViewCell {

    private var cancellable: AnyCancellable?
    private var animator: UIViewPropertyAnimator?
    @IBOutlet weak var outerView: UIView!
    @IBOutlet weak var topCountLbl: UILabel!
    @IBOutlet weak var businessNameLbl: UILabel!
    @IBOutlet weak var locationLbl: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func populateCell(model: Record?){
        
    }
    
    func populateCellBusiness(model: Business?){
        topCountLbl.text = "\(model?.localBusinessSeq ?? 0)"
        locationLbl.text = model?.plainNeighborhood.name.en ?? ""
        self.imgView.setImageFromUrl(ImageURL: model?.thumbnailURL ?? "")
        self.businessNameLbl.text = model?.businessName.en ?? ""
    }
    
    private func loadImageForBusiness(for movie: Business?) -> AnyPublisher<UIImage?, Never> {
        return Just(movie?.thumbnailURL ?? "")
            .flatMap({ poster -> AnyPublisher<UIImage?, Never> in
                let url = URL(string: movie?.thumbnailURL ?? "")!
                return ImageLoader.shared.loadImage(from: url)
            })
            .eraseToAnyPublisher()
    }
    
    private func showImage(image: UIImage?) {
        imgView.alpha = 0.0
        animator?.stopAnimation(false)
        imgView.image = image
        animator = UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 0.3, delay: 0, options: .curveLinear, animations: {
            self.imgView.alpha = 1.0
        })
    }

}
