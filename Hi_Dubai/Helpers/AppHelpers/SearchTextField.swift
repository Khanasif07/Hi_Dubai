//
//  SearchTextField.swift
//  Hi_Dubai
//
//  Created by Asif Khan on 23/05/2023.
//

import Foundation
import UIKit
@IBDesignable class SearchTextField : UIView, UITextFieldDelegate {

    weak var delegate: WalifSearchTextFieldDelegate?
   
    @IBInspectable private var iconImage: UIImage!
    @IBInspectable private var searchLabel: String!
    @IBInspectable private var defaultSearch: String!
    private var tempView:UIView!
    private var defaultImage:UIImage!
    
    @IBOutlet weak var mainLabel: UILabel!
    @IBOutlet weak var mainTF: UITextField!
    @IBOutlet weak var labelWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var icon: UIButton!
    
    //MARK: - Init View
    required init?(coder: NSCoder){
        super.init(coder: coder)
        self.loadFromnib()
        
    }
    
    override init(frame: CGRect) {
        super.init(frame:frame)
        self.loadFromnib()
    }

    @discardableResult func loadFromnib() -> UIView! {
        let view = Bundle.main.loadNibNamed( "SearchTextField", owner: self, options: nil)?.first as? UIView
        view?.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        view?.frame = bounds
        addSubview(view!)
        self.autoresizingMask = [.flexibleHeight,.flexibleWidth]
        defaultImage = UIImage(named: "search")
        self.mainTF.autocorrectionType = .no
        return view
    }

    func drawRect(rect:CGRect) {
        super.draw(rect)
        if iconImage != nil {
            defaultImage = iconImage
            icon.setImage(defaultImage, for: .normal)
        }
        if searchLabel != nil {
            mainLabel.text = searchLabel
        }
        if defaultSearch != nil {
            mainTF.text = defaultSearch
        }
    }


    func setPlaceholder(value:String!) {
        let color:UIColor! = UIColor.white
        self.mainTF.attributedPlaceholder = NSAttributedString(string:value, attributes:[NSAttributedString.Key.foregroundColor: color!])
    }


    @IBAction func textChanged(_ sender: UITextField) {
        var userInput:String = sender.text ?? ""
        if userInput.count > 0 {
            userInput = String(format: "%@%@", userInput[...userInput.startIndex].uppercased())
            mainTF.text = userInput
        }
        delegate?.walifSearchTextFieldChanged(sender: sender)
    }

    @IBAction func iconAction(sender:AnyObject!) {
        delegate?.walifSearchTextFieldIconPressed(sender: mainTF)
        if mainTF.isFirstResponder {
            mainTF.text = ""
            mainTF.resignFirstResponder()
        }
    }

    func text() -> String! {
        return mainTF.text
    }

    func setText(value:String!) {
        mainTF.text = value
    }

    @IBAction func tapOnView(sender:AnyObject!) {
        mainTF.becomeFirstResponder()
    }

    // MARK: - TextField delegate
    // MARK:

    func textFieldDidBeginEditing(_ textField:UITextField) {
        delegate?.walifSearchTextFieldBeginEditing(sender: textField)
        mainLabel.isHidden = true
        icon.isHidden = false
        icon.setImage(UIImage(named: "cancel_icon"), for:.normal)
    }

    func textFieldDidEndEditing(_ textField:UITextField) {
        mainLabel.isHidden = false
        icon.isHidden = mainTF.text?.count != 0
        icon.setImage(defaultImage, for:.normal)
    }

    func textFieldShouldReturn(_ textField:UITextField) -> Bool {
        delegate?.walifSearchTextFieldEndEditing(sender: textField)
        mainLabel.isHidden = false
        icon.isHidden = true
        textField.resignFirstResponder()
        return true
    }
}
