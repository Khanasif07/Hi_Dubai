//
//  LoadingView.swift
//  Hi_Dubai
//
//  Created by Asif Khan on 24/05/2023.
//

import UIKit
import Foundation
class LoadingView : UIView {
    private var tempView:UIView!

    required init?(coder: NSCoder){
       super.init(coder: coder)
   }

   override init(frame: CGRect) {
       super.init(frame:frame)
       self.loadFromnib()
   }

   convenience init(frame:CGRect, inView superview:UIView!){
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

    func loadFromnib() -> UIView! {
        let view = Bundle.main.loadNibNamed( "LoadingView", owner: self, options: nil)?.first as? UIView
        view?.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        view?.frame = bounds
        addSubview(view!)
        self.autoresizingMask = [.flexibleHeight,.flexibleWidth]
        return view
    }
}
