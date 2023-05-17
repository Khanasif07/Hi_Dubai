//
//  NewSearchTextField.swift
//  Hi_Dubai
//
//  Created by Asif Khan on 16/05/2023.
//


import Foundation
import UIKit

protocol WalifSearchTextFieldDelegate : NSObject {
    // all the delegate functions that need to be implemented
    func walifSearchTextFieldBeginEditing(sender: NewSearchTextField!)
    func walifSearchTextFieldEndEditing(sender: NewSearchTextField!)
    func walifSearchTextFieldChanged(sender: NewSearchTextField!)
    ///tap on icon
    func walifSearchTextFieldIconPressed(sender: NewSearchTextField!)
}

@IBDesignable class NewSearchTextField : UIView, UITextFieldDelegate {
    
    //MARK: - IBOutlets
    @IBOutlet weak var crossBtnWidthConstant: NSLayoutConstraint!
    @IBOutlet weak var mainLabel: UILabel!
    @IBOutlet weak var mainTF: UITextField!
    @IBOutlet weak var icon: UIButton!
    @IBOutlet weak var cancelBtn: UIView!
    
    //MARK: - Properties
    weak var delegate:WalifSearchTextFieldDelegate?
    @IBInspectable var iconImage: UIImage!
    @IBInspectable var searchLabel: String!
    @IBInspectable var defaultSearch: String!
    private var tempView:UIView!
    private var _defaultImage:UIImage!
    private var defaultImage:UIImage! {
        get { return _defaultImage }
        set { _defaultImage = newValue }
    }
    
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
        let view = Bundle.main.loadNibNamed( "NewSearchTextField", owner: self, options: nil)?.first as? UIView
        view?.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        view?.frame = bounds
        addSubview(view!)
        self.autoresizingMask = [.flexibleHeight,.flexibleWidth]
        defaultImage = UIImage(named: "search")
        self.crossBtnWidthConstant.constant = 0.0
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
    
    //MARK: - Function
    func setPlaceholder(placeholder:String!) {
        mainTF.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [NSAttributedString.Key.foregroundColor : UIColor.white])
    }
    
    func setPrefixOfTextField(value:String!) {
        if self.mainLabel.responds(to: Selector(("setAttributedPlaceholder:"))){
            //        .respondsToSelector(Selector("setAttributedPlaceholder:")) {
            NSLog("white placeholder text")
            //UIColor *color = [UIColor whiteColor];
            mainLabel.text = value
            //;[[NSAttributedString alloc] initWithString:value attributes:@{NSForegroundColorAttributeName: color}];
        } else {
            NSLog("Cannot set placeholder text's color, because deployment target is earlier than iOS 6.0")
            // TODO: Add fall-back code to set placeholder color.
            mainLabel.text = value
        }
    }
    
    @IBAction func textChanged(_ sender: UITextField){
        var userInput: String  = mainTF.text ?? ""
        if userInput.count > 0 {
            userInput = String(format:"%@%@",userInput.substring(to: userInput.index(userInput.startIndex, offsetBy: 1)).uppercased(),userInput.substring(from: userInput.index(userInput.startIndex, offsetBy: 1)))
            mainTF.text = userInput
        }
        delegate?.walifSearchTextFieldChanged(sender: self)
    }
    
    @IBAction func iconAction(sender:AnyObject!) {
        delegate?.walifSearchTextFieldIconPressed(sender: self)
        cancelSearch()
    }
    
    func cancelSearch() {
        UIView.animate(withDuration: 0.5,delay: 0.0,options: .curveEaseInOut) {
            if self.mainTF.isFirstResponder {
                self.cancelBtn.isHidden = true
                self.crossBtnWidthConstant.constant = 0.0
                self.mainTF.text = ""
                self.mainTF.resignFirstResponder()
            }
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
    
    func makeSearchFieldActive() {
        mainTF.becomeFirstResponder()
    }
    
    // MARK: - TextField delegate
    // MARK: -
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        mainLabel.isHidden = true
//        cancelBtn.isHidden = false
        delegate?.walifSearchTextFieldBeginEditing(sender: self)
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        return true
    }
    
    func textFieldDidEndEditing(_ textField:UITextField) {
        mainLabel.isHidden = false
        cancelBtn.isHidden = true
    }
    
    func walifSearchTextFieldIconPressed(sender:NewSearchTextField!) {
        delegate?.walifSearchTextFieldIconPressed(sender: self)
//        cancelBtn.isHidden = true
    }
    
    func textFieldShouldReturn(_ textField:UITextField) -> Bool {
        delegate?.walifSearchTextFieldEndEditing(sender: self)
//        mainLabel.isHidden = false
//        cancelBtn.isHidden = true
        textField.resignFirstResponder()
        return true
    }
}
