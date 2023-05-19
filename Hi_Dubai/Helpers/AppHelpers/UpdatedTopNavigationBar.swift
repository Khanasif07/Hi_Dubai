//
//  UpdatedTopNavigationBar.swift
//  Hi_Dubai
//
//  Created by Asif Khan on 17/05/2023.
//

import UIKit
protocol UpdatedTopNavigationBarDelegate: NSObject {
    func leftButtonAction()
    func rigthButtonAction()
    func imageTapAction()
}

extension UpdatedTopNavigationBarDelegate {
    func leftButtonAction() {}
    func rigthButtonAction() {}
    func imageTapAction() {}
}

class UpdatedTopNavigationBar: UIView {
    
    //MARK:- Variables -
    internal weak var delegate: UpdatedTopNavigationBarDelegate?
    
    //MARK:- IBOutlets -
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var leftButtonOutlet: UIButton!
    @IBOutlet weak var rightButtonOutlet: UIButton!
    @IBOutlet weak var rightImageView: UIImageView!
    
    //MARK:- LifeCycle -
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setUpView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setUpView()
    }
    
    //MARK:- Functions -
    private func setUpView() {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "UpdatedTopNavigationBar", bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        view.frame = bounds
        view.backgroundColor = .clear
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.addSubview(view)
        self.rightImageView.isHidden = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.tapImgAction(_:)))
        self.rightImageView.isUserInteractionEnabled = true
        self.rightImageView.addGestureRecognizer(tapGesture)
        self.rightImageView.layer.cornerRadius = self.rightImageView.height/2.0
    }
    
    internal func configureUI(title: String = "" , isTitle: Bool = false, mainImage: UIImage = #imageLiteral(resourceName: "supersheLogo") , isMainImage: Bool = true, leftButtonImage: UIImage = #imageLiteral(resourceName: "Back Icon") ,isLeftButton: Bool = true , rightButtonImage: UIImage = #imageLiteral(resourceName: "Back Icon") , isRightButton: Bool = false) {
        if isTitle {
            self.titleLabel.text = title
        } else {
            self.titleLabel.isHidden = true
        }
        
        if isMainImage {
            self.mainImageView.borderColor = AppColors.white
    
        } else {
             self.mainImageView.isHidden = true
        }
        self.mainImageView.image = mainImage
        
        if isLeftButton {
            self.leftButtonOutlet.setImage(leftButtonImage, for: .normal)
        } else {
            self.leftButtonOutlet.isHidden = true
        }
        
        if isRightButton {
            self.rightButtonOutlet.setImage(rightButtonImage, for: .normal)
        } else {
            self.rightButtonOutlet.isHidden = true
        }
    }
    
    internal func imageViewSetUp(withDuration: TimeInterval, imageUrl: String) {
        self.rightImageView.isHidden = false
        self.rightButtonOutlet.isHidden = true
        self.rightImageView.alpha = 0.0
//        self.rightImageView.setImage(imageString: imageUrl, imageQuality: .low)
        self.rightImageView.borderColor = AppColors.white
        self.rightImageView.borderWidth = 1.5
        UIView.animate(withDuration: withDuration) { [weak self] in
            self?.rightImageView.alpha = 1.0
        }
    }
    
    //MARK:- IBActions -
    @IBAction func leftButtonAction() {
        self.delegate?.leftButtonAction()
    }
    
    @IBAction func rightButtonAction() {
        self.delegate?.rigthButtonAction()
    }
    
    @IBAction func tapImgAction(_ recognizer: UITapGestureRecognizer) {
        self.delegate?.imageTapAction()
    }
    
}
