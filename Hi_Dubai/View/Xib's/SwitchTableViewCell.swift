//
//  SwitchTableViewCell.swift
//  Hi_Dubai
//
//  Created by Asif Khan on 20/06/2023.
//

import UIKit

import UIKit

class SwitchTableViewCell: UITableViewCell {
    static let identifier = "SwitchTableViewCell"
    private var iconImgView : UIImageView = {
        let imgView = UIImageView()
        imgView.tintColor = .white
        imgView.contentMode = .scaleAspectFit
        return imgView
    }()
    
    private var iconContainer : UIView = {
        let imgView = UIView()
        imgView.clipsToBounds = true
        imgView.layer.cornerRadius = 8.0
        imgView.layer.masksToBounds = true
        return imgView
    }()
    
    private var label : UILabel = {
        let imgView = UILabel()
        imgView.numberOfLines = 1
        return imgView
    }()
    
    private let mySwitch: UISwitch = {
        let myswitch = UISwitch()
        myswitch.onTintColor = .systemBlue
        return myswitch
    }()


    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(label)
        contentView.addSubview(iconContainer)
        contentView.addSubview(mySwitch)
        iconContainer.addSubview(iconImgView)
        
        contentView.clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let size = contentView.frame.size.height - 12
        iconContainer.frame = CGRect(x: 15, y: 6, width: size, height: size)

        let imgSize = size/1.5
        iconImgView.frame = CGRect(x: (size-imgSize)/2, y: (size-imgSize)/2, width: imgSize, height: imgSize)
        
        mySwitch.sizeToFit()
        mySwitch.frame = CGRect(x: contentView.frame.size.width - mySwitch.frame.size.width - 20 , y: (contentView.frame.size.height - mySwitch.frame.size.height)/2 , width: mySwitch.frame.size.width, height: mySwitch.frame.size.height)
        
        label.frame = CGRect(x: 25.0 + iconContainer.frame.size.width, y: 0, width: contentView.frame.size.width - 20.0 - iconContainer.frame.size.width, height: contentView.frame.size.height)
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        self.iconImgView.image = nil
        self.label.text = nil
        self.iconContainer.backgroundColor = nil
        self.mySwitch.isOn = false
    }
    
    func configure(with model: SettingsSwitchOption){
        label.text = model.title
        iconImgView.image = model.icon
        iconContainer.backgroundColor = model.iconBackColor
        self.mySwitch.isOn = model.isOn
    }
}
