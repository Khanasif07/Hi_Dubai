//
//  UIViewExtension.swift
//  Hi_Dubai
//
//  Created by Admin on 11/02/23.
//
import Foundation
import UIKit
extension UIView{
    
    func addShadow(cornerRadius: CGFloat, maskedCorners: CACornerMask = [.layerMaxXMinYCorner, .layerMinXMinYCorner, .layerMaxXMaxYCorner, .layerMinXMaxYCorner], color: UIColor, offset: CGSize, opacity: Float, shadowRadius: CGFloat) {
        self.layer.cornerRadius = cornerRadius
        self.layer.maskedCorners = maskedCorners
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOffset = offset
        self.layer.shadowOpacity = opacity
        self.layer.shadowRadius = shadowRadius
    }
    
//    func roundCorners(){
//        self.cornerRadius = self.height/2.0
//    }
    
    ///Rounds the given corner based on the given radius
    func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
        let maskPath = UIBezierPath(roundedRect: bounds,
                                    byRoundingCorners: corners,
                                    cornerRadii: CGSize(width: radius, height: radius))
        let shape = CAShapeLayer()
        shape.path = maskPath.cgPath
        layer.mask = shape
    }
    
}


class GradientView: UIView {
    
    
    
    var colors: [CGColor] = UIColor.AppColor.otherUserProfileGradientColors { didSet { self.setNeedsDisplay()} }
    
    private var gradientLayer: CAGradientLayer!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = .clear
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        self.createGradientLayer()
    }
    
    override var bounds: CGRect {
        didSet {
            self.createGradientLayer()
        }
    }
    
    

    
    ///draw gradient on the top layer
    func createGradientLayer() {
        for layer in layer.sublayers ?? [] {
            if layer is CAGradientLayer {
                layer.removeFromSuperlayer()
            }
        }
        gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.bounds
        gradientLayer.colors = colors
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0, y: 1)
        self.layer.addSublayer(gradientLayer)
    }
}

extension UIView {
    
    enum Border {
        case left
        case right
        case top
        case bottom
    }
    
    var width: CGFloat {
        get { return self.frame.size.width }
        set { self.frame.size.width = newValue }
    }
    var height: CGFloat {
        get { return self.frame.size.height }
        set { self.frame.size.height = newValue }
    }
    var top: CGFloat {
        get { return self.frame.origin.y }
        set { self.frame.origin.y = newValue }
    }
    var right: CGFloat {
        get { return self.frame.origin.x + self.width }
        set { self.frame.origin.x = newValue - self.width }
    }
    var bottom: CGFloat {
        get { return self.frame.origin.y + self.height }
        set { self.frame.origin.y = newValue - self.height }
    }
    var left: CGFloat {
        get { return self.frame.origin.x }
        set { self.frame.origin.x = newValue }
    }
    var centerX: CGFloat{
        get { return self.center.x }
        set { self.center = CGPoint(x: newValue,y: self.centerY) }
    }
    var centerY: CGFloat {
        get { return self.center.y }
        set { self.center = CGPoint(x: self.centerX,y: newValue) }
    }
    var origin: CGPoint {
        set { self.frame.origin = newValue }
        get { return self.frame.origin }
    }
    var size: CGSize {
        set { self.frame.size = newValue }
        get { return self.frame.size }
    }
    
    var globalPoint :CGPoint? {
        return self.superview?.convert(self.frame.origin, to: nil)
    }
    
    var globalFrame :CGRect? {
        return self.superview?.convert(self.frame, to: nil)
    }
    
    ///Returns the parent view controller ( if any ) of the view
    var parentViewController: UIViewController? {
        var parentResponder: UIResponder? = self
        while let responder = parentResponder {
            parentResponder = responder.next
            if let viewController = parentResponder as? UIViewController {
                return viewController
            }
        }
        return nil
    }
    
    
    ///Sets the corner radius of the view
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
    
    ///Sets the border width of the view
    @IBInspectable var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    ///Sets the border color of the view
    @IBInspectable var borderColor: UIColor? {
        get {
            let color = UIColor(cgColor: layer.borderColor!)
            return color
        }
        set {
            layer.borderColor = newValue?.cgColor
        }
    }
    
    ///Sets the shadow color of the view
    @IBInspectable var shadowColor:UIColor? {
        set {
            layer.shadowColor = newValue!.cgColor
        }
        get {
            if let color = layer.shadowColor {
                return UIColor(cgColor: color)
            }
            else {
                return nil
            }
        }
    }
    
    ///Sets the shadow opacity of the view
    @IBInspectable var shadowOpacity:Float {
        set {
            layer.shadowOpacity = newValue
        }
        get {
            return layer.shadowOpacity
        }
    }
    
    ///Sets the shadow offset of the view
    @IBInspectable var shadowOffset:CGSize {
        set {
            layer.shadowOffset = newValue
        }
        get {
            return layer.shadowOffset
        }
    }
    
    ///Sets the shadow radius of the view
    @IBInspectable
    var shadowRadius: CGFloat {
        get {
            return layer.shadowRadius
        }
        set {
            layer.shadowRadius = newValue //shadowRadius
        }
    }
    
    func applyGradient(colors: [CGColor]) {
        self.backgroundColor = nil
        self.layoutIfNeeded()
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = colors
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 0)
        gradientLayer.frame = self.bounds
        gradientLayer.cornerRadius = self.frame.height/2
        
        gradientLayer.shadowColor = UIColor.darkGray.cgColor
        gradientLayer.shadowOffset = CGSize(width: 2.5, height: 2.5)
        gradientLayer.shadowRadius = 5.0
        gradientLayer.shadowOpacity = 0.3
        gradientLayer.masksToBounds = false
        self.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    func roundCornersWithBorder(weight: CGFloat,borderColor: UIColor){
        self.cornerRadius = self.height/2.0
        setCircleBorder(weight: weight, color: borderColor)
    }
    
    func setCircleBorder(weight: CGFloat, color: UIColor) {
         self.layer.borderColor = color.cgColor
         self.layer.borderWidth = weight
     }
    
    enum VerticalLocation: String {
        case bottom
        case top
    }
    
    func addShadowToView(location: VerticalLocation, color: UIColor = .black, opacity: Float = 0.5, radius: CGFloat = 5.0) {
         switch location {
         case .bottom:
             addShadow(offset: CGSize(width: 0, height: 10), color: color, opacity: opacity, radius: radius)
         case .top:
             addShadow(offset: CGSize(width: 0, height: -5), color: color, opacity: opacity, radius: radius)
         }
     }
    
    func addShadow(offset: CGSize, color: UIColor = .black, opacity: Float = 0.5, radius: CGFloat = 5.0) {
         self.layer.masksToBounds = false
         self.layer.shadowColor = color.cgColor
         self.layer.shadowOffset = offset
         self.layer.shadowOpacity = opacity
         self.layer.shadowRadius = radius
     }
    
    func addGradient(colors: [CGColor]) {
         let gradientLayer = CAGradientLayer()
         gradientLayer.frame = self.bounds
         gradientLayer.colors = colors
         self.layer.insertSublayer(gradientLayer, at: 0)
     }
    
    func addGradientOnHeaderImage() {
        let gradient = CAGradientLayer()
        gradient.frame = self.bounds
        gradient.colors = [UIColor.init(r: 86, g: 102, b: 126, alpha: 0.0).cgColor,UIColor.init(r: 14, g: 11, b: 31, alpha: 1.0).cgColor]
        self.layer.addSublayer(gradient)
    }
    
    func addGradientToHeaderView() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.bounds
        gradientLayer.colors = [UIColor(displayP3Red: 44/255, green: 175/255, blue: 205/255, alpha: 1.0).cgColor, UIColor(displayP3Red: 15/255, green: 76/255, blue: 130/255, alpha: 1.0).cgColor]
        self.layer.insertSublayer(gradientLayer, at: 0)
    }
}
extension UIView {
    
    func setUp(to superView: UIView) {
        translatesAutoresizingMaskIntoConstraints = false
        topAnchor.constraint(equalTo: superView.topAnchor).isActive = true
        leadingAnchor.constraint(equalTo: superView.leadingAnchor).isActive = true
        bottomAnchor.constraint(equalTo: superView.bottomAnchor).isActive = true
        trailingAnchor.constraint(equalTo: superView.trailingAnchor).isActive = true
    }
    
    func setGradient(withColors colors: [CGColor] , startPoint: CGPoint , endPoint: CGPoint) {
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.colors = colors
        gradient.startPoint = startPoint
        gradient.endPoint = endPoint
        gradient.frame = CGRect(x: 0.0, y: 0.0, width: self.frame.size.width, height: self.frame.size.height)
        self.layer.insertSublayer(gradient, at: 0)
    }
}

struct windowConstant {
    
    private static let window = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
    
    static var getTopPadding: CGFloat {
        return window?.safeAreaInsets.top ?? 0
    }
    
    static var getBottomPadding: CGFloat {
        return window?.safeAreaInsets.bottom ?? 0
    }
    
}


extension NSTextAttachment {
    func setImageHeight(height: CGFloat) {
        guard let image = image else { return }
        let ratio = image.size.width / image.size.height
        
        bounds = CGRect(x: bounds.origin.x, y: bounds.origin.y, width: ratio * height, height: height)
    }
}

extension UIButton {
    
    func setButtonTitleWithLeftImage(title: String, btnImage: String , customFont: UIFont , color: UIColor, imageColor: UIColor , imageSize: CGFloat, isImageOriginal: Bool = false) {
        let attributedText = NSMutableAttributedString(string:"" , attributes:[NSAttributedString.Key.font: customFont, NSAttributedString.Key.foregroundColor: color])
        
        let font = customFont
        var Img = UIImage()
        if isImageOriginal {
            Img = UIImage(named: btnImage)!
        } else {
            Img = (UIImage(named: btnImage)?.withRenderingMode(.alwaysTemplate).withTintColor(imageColor))!
        }
        let Image = NSTextAttachment()
        Image.image = Img
        Image.bounds = CGRect(x: 0, y: (font.capHeight - imageSize).rounded() / 2, width: imageSize, height: imageSize)
        Image.setImageHeight(height: imageSize)
        let imgString = NSAttributedString(attachment: Image)
        attributedText.append(imgString)
        
        attributedText.append(NSAttributedString(string: " \(title)", attributes: [NSAttributedString.Key.font: customFont, NSAttributedString.Key.foregroundColor: color]))
        
        self.setAttributedTitle(attributedText, for: .normal)
    }

    func setButtonTitleWithRightImage(title: String, btnImage: String , customFont: UIFont , color: UIColor, imageColor: UIColor ,imageSize: CGFloat, isImageOriginal: Bool = false) {
        let attributedText = NSMutableAttributedString(string:"\(title) " , attributes:[NSAttributedString.Key.font: customFont, NSAttributedString.Key.foregroundColor: color])
        
        let font = customFont
        var Img = UIImage()
        if isImageOriginal {
            Img = UIImage(named: btnImage)!
        } else {
            Img = (UIImage(named: btnImage)?.withRenderingMode(.alwaysTemplate).withTintColor(imageColor))!
        }
        let Image = NSTextAttachment()
        Image.image = Img
        Image.bounds = CGRect(x: 0, y: (font.capHeight - imageSize).rounded() / 2, width: imageSize, height: imageSize)
        Image.setImageHeight(height: imageSize)
        let imgString = NSAttributedString(attachment: Image)
        attributedText.append(imgString)
        
        self.setAttributedTitle(attributedText, for: .normal)
    }
    
}

extension UIView{
    func rotate(clockwise: Bool = true) {
        if clockwise {
            /// clockwise
//            let radians = 180.0 / 180.0 * CGFloat.pi
//            let rotation = CGAffineTransformRotate(self.transform, radians)
//            self.transform = rotation
            let radians = 180.0 / 180.0 * CGFloat.pi
            let rotate = CABasicAnimation(keyPath: "transform.rotation")
            rotate.fromValue = radians
            rotate.toValue = 0
            rotate.duration = 0.25
            rotate.fillMode = CAMediaTimingFillMode.forwards
            rotate.isRemovedOnCompletion = false
            self.layer.add(rotate, forKey: "transform.rotation")
        } else {
            /// anticlockwise
            let radians = -(180.0 / 180.0 * CGFloat.pi)
            let rotate = CABasicAnimation(keyPath: "transform.rotation")
            rotate.fromValue = radians
            rotate.toValue = 0
            rotate.duration = 0.25
            rotate.fillMode = CAMediaTimingFillMode.forwards
            rotate.isRemovedOnCompletion = false
            self.layer.add(rotate, forKey: "transform.rotation")
//            let radians = 180.0 / 180.0 * CGFloat.pi
//            let rotation = CGAffineTransformRotate(self.transform, radians)
//            self.transform = rotation
        }
    }
}
