//
//  AppButton.swift
//  Hi_Dubai
//
//  Created by Asif Khan on 17/05/2023.
//

import Foundation
import UIKit

class AppButton: UIButton {
    
    // MARK: Enums
    //==============
    enum CustomButtonType {
        case themeColor, whiteColor, clearColor, blackColor
    }
    
    // MARK: Variables
    //===================
    var btnType = CustomButtonType.themeColor {
        didSet{
            self.setupSubviews()
        }
    }
    private var containerView: UIView?
    private var loader: UIActivityIndicatorView?
    private var label: UILabel?
    internal var widthDivider: CGFloat = 2.76
    private var loaderFrame: CGRect = CGRect()
    
    // MARK: Initializers
    //=====================
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setupSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.setupSubviews()
    }
    
    // MARK: Life Cycle Functions
    //==============================
    override func layoutSubviews() {
        super.layoutSubviews()
        self.setupLayouts()
        self.loaderLayOuts()
    }
    
}

// MARK: Private Functions
//==========================
extension AppButton {
    
    /// Setup Subviews
    private func setupSubviews() {
        
        self.clipsToBounds = true
        //        self.layer.borderWidth = 1
        self.titleLabel?.font = AppFonts.BoldItalic.withSize(19)
        
        switch btnType {
        case .themeColor:
            self.backgroundColor = AppColors.appBlueColor
            self.setTitleColor(AppColors.white, for: .normal)
        //            self.layer.borderColor = AppColors.whiteColor.cgColor
        case .whiteColor:
            self.backgroundColor = AppColors.white
            self.setTitleColor(AppColors.appBlueColor, for: .normal)
        //            self.layer.borderColor = AppColors.themeColor.cgColor
        case .clearColor:
            self.backgroundColor = .clear
            self.setTitleColor(AppColors.white, for: .normal)
            self.titleLabel?.font = AppFonts.BoldItalic.withSize(13.0)
        //            self.layer.borderColor = AppColors.themeColor.cgColor
        case .blackColor:
            self.backgroundColor = AppColors.appBlackColor
            self.setTitleColor(AppColors.white, for: .normal)
            
        }
    }
    
    /// Setup Layouts
    private func setupLayouts() {
        
        //        self.layer.cornerRadius = 5 //self.frame.height/2
    }
    private func loaderLayOuts() {
        if let containerVw = self.containerView, let loader = self.loader, let label = self.label {
            containerVw.frame = CGRect(x: self.centerX - self.bounds.width/(2*widthDivider), y: 0.0, width: self.bounds.width/widthDivider, height: self.bounds.height)
            loader.frame = CGRect(x: 0.0, y: containerVw.centerY/2, width: self.bounds.height/2, height: self.bounds.height/2)
            label.frame = CGRect(x: 40.0, y: containerVw.centerY/2, width: containerVw.bounds.width - 40.0, height: self.bounds.height/2)
        }
        
        if let loader = self.loader, containerView == nil {
            //            loader.frame = CGRect(x: 10.0, y: 7.75, width: 14.5, height: 14.5)
            loader.frame = self.loaderFrame
        }
    }
    
    internal func loaderOnButtonSetUp(textColor: UIColor = AppColors.white, text: String = "Loading...", font: UIFont = AppFonts.BoldItalic.withSize(19.0), loaderStyle: UIActivityIndicatorView.Style = .white) {
        self.containerView = UIView(frame: CGRect(x: self.centerX - self.bounds.width/(2*widthDivider), y: 0.0, width: self.bounds.width/widthDivider, height: self.bounds.height))
        if let containerVw = self.containerView{
            self.loader = UIActivityIndicatorView(frame: CGRect(x: 0.0, y: containerVw.centerY/2, width: self.bounds.height/2, height: self.bounds.height/2))
            guard let loader = self.loader else { return }
            self.label = UILabel(frame: CGRect(x: 40.0, y: loader.centerY, width: containerVw.bounds.width - 40.0, height: self.bounds.height/2))
            guard let label = self.label else { return }
            containerVw.centerX = self.centerX
            containerVw.backgroundColor = .clear
            loader.centerY = self.centerY
            loader.style = loaderStyle//.white
            //Loader Width + 10 Distance
            label.centerY = self.centerY
            label.textColor = textColor
            label.text = text
            label.font = font
            label.textAlignment = .left
            containerVw.addSubview(loader)
            containerVw.addSubview(label)
            self.addSubview(containerVw)
            containerVw.isHidden = true
        }
    }
    
    internal func activityLoaderOnButtonSetUp(loaderStyle: UIActivityIndicatorView.Style = .white, frame: CGRect = CGRect(x: 10.0, y: 7.75, width: 14.5, height: 14.5)) {
        self.loaderFrame = frame
        self.loader = UIActivityIndicatorView(frame: frame)
        guard let loader = self.loader else { return }
        loader.centerY = self.centerY
        loader.style = loaderStyle
        self.addSubview(loader)
        loader.isHidden = true
    }
    
    
    internal func startLoader() {
        if let containerVw = self.containerView, let loader = self.loader,let label = self.label, !loader.isAnimating {
            self.setTitle(nil, for: .normal)
            self.setTitle(nil, for: .selected)
            containerVw.centerX = self.centerX
            loader.centerY = self.centerY
            label.centerY = self.centerY
            loader.isHidden = false
            containerVw.isHidden = false
//            printDebug(containerVw.subviews)
            loader.startAnimating()
            self.isUserInteractionEnabled = false
        }
    }
    
    internal func stopLoader(title: String = "Continue") {
        if let containerVw = self.containerView, let loader = self.loader, loader.isAnimating {
            self.setTitle(title, for: .normal)
            self.setTitle(title, for: .selected)
            loader.stopAnimating()
            containerVw.isHidden = true
            self.isUserInteractionEnabled = true
        }
    }
    
    internal func startActivityLoader() {
        if let loader = self.loader, !loader.isAnimating {
            self.setImage(nil, for: .normal)
            self.setTitle(nil, for: .normal)
            self.setTitle(nil, for: .selected)
            self.setImage(nil, for: .selected)
            loader.isHidden = false
            loader.startAnimating()
            self.isUserInteractionEnabled = false
        }
    }
    
    internal func stopActivityLoader(title: String = "Continue", image: UIImage? = nil) {
        if let loader = self.loader, loader.isAnimating {
            self.setImage(image, for: .normal)
            self.setTitle(title, for: .normal)
            self.setTitle(title, for: .selected)
            self.setImage(image, for: .selected)
            loader.stopAnimating()
            self.isUserInteractionEnabled = true
        }
    }
    
}

// MARK: Functions
//===================
extension UIButton {
    
    func setupUnderlineTitle(title: String, underlineColor: UIColor = AppColors.appBlueColor, font: UIFont, underlineBtnColor: UIColor = AppColors.appBlueColor) {
        
        let attrs: [NSAttributedString.Key: Any] = [
            NSAttributedString.Key.font: font,
            NSAttributedString.Key.foregroundColor: underlineBtnColor,
            NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue
        ]
        let attributtedString = NSAttributedString(string: title, attributes: attrs)
        self.setAttributedTitle(attributtedString, for: .normal)
    }
    
    
    func alignTextBelow(spacing: CGFloat = 6.0) {
        
        if let image = self.imageView?.image {
            
            let imageSize: CGSize = image.size
            self.titleEdgeInsets = UIEdgeInsets(top: spacing, left: -imageSize.width, bottom: -(imageSize.height), right: 0.0)
            let labelString = NSString(string: self.titleLabel!.text!)
            let titleSize = labelString.size(withAttributes: [NSAttributedString.Key.font: self.titleLabel!.font])
            self.imageEdgeInsets = UIEdgeInsets(top: -(titleSize.height + spacing), left: 0.0, bottom: 0.0, right: -titleSize.width)
        }
    }
}
