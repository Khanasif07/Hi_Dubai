//
//  EmptyView.swift
//  Hi_Dubai
//
//  Created by Asif Khan on 10/05/2023.
//

import UIKit
import Foundation
protocol EmptyStateViewDelegate: NSObject{
    func loginAction()
    func learnHowAction()
}
class EmptyView : UIView{
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var text: UILabel!
    @IBOutlet weak var learnHow: UIButton!
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var verticalAlignmentConstraint: NSLayoutConstraint!
    @IBOutlet weak var mainContainerView: UIStackView!
    @IBOutlet weak var whiteContainer: UIView!
    
    weak var delegate: EmptyStateViewDelegate?
    var tempView: UIView?
    private var learnHowAction:(()->Void)?

    required init?(coder: NSCoder){
        super.init(coder: coder)
        self.loadFromnib()
        self.xibSetup()
    }

    override init(frame: CGRect) {
        super.init(frame:frame)
        self.loadFromnib()
        self.xibSetup()
    }

    convenience init(frame:CGRect, inView superview:UIView!, centered:Bool, icon:UIImage!, message:String!){
        self.init(frame:frame)
        superview.addSubview(self)
        self.isHidden = true
    }

    func show() {
        self.isHidden = false
    }

    func hide() {
        self.isHidden = true
    }

    func setIcon(icon:UIImage!, message:String!, centered:Bool, learnHowAction: @escaping ()->Void, showLoginBtn:Bool) {
        self.icon.image = icon
        self.text.text = message
        self.loginBtn.isHidden = !showLoginBtn
        if learnHowAction != nil {
            self.learnHow.isHidden = false
            self.learnHowAction = learnHowAction
        }else{
            self.learnHow.isHidden = true
        }
        if !centered {
            self.whiteContainer.removeConstraint(self.verticalAlignmentConstraint)
            //topConstraint
            let topConstraint:NSLayoutConstraint! = NSLayoutConstraint(item: self.whiteContainer!, attribute: .top, relatedBy: .equal, toItem: self.mainContainerView, attribute: .topMargin, multiplier: 1.0, constant: -20.0)
            self.whiteContainer.addConstraint(topConstraint)
            self.whiteContainer.updateConstraints()
        }
    }

    @IBAction func learnHowAction(_ sender: UIButton) {
        self.delegate?.learnHowAction()
        
    }
    
    @IBAction func loginAction(_ sender: UIButton) {
        self.delegate?.loginAction()
    }
    
    
    
    func xibSetup() {
//        self.tempView = self.loadFromnib()
//        self.tempView?.frame = CGRect(origin: CGPoint.zero, size: CGSize(width: self.bounds.width, height: self.bounds.height))
//        self.tempView?.autoresizingMask = [.flexibleHeight,.flexibleWidth]
//        self.addSubview(self.tempView!)
//        self.autoresizingMask = [.flexibleHeight,.flexibleWidth]
    }

    func loadFromnib() -> UIView! {
        let view = Bundle.main.loadNibNamed( "EmptyView", owner: self, options: nil)?.first as? UIView
        view?.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        view?.frame = bounds
        addSubview(view!)
        self.autoresizingMask = [.flexibleHeight,.flexibleWidth]
        return view
    }
}
