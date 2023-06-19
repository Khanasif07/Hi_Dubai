//
//  SettingTableViewCell.swift
//  Hi_Dubai
//
//  Created by Asif Khan on 19/06/2023.
//

import UIKit

class SettingTableViewCell: UITableViewCell {
    static let identifier = "SettingTableViewCell"
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


    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(label)
        contentView.addSubview(iconContainer)
        iconContainer.addSubview(iconImgView)
        
        contentView.clipsToBounds = true
        accessoryType = .disclosureIndicator
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
        
        label.frame = CGRect(x: 25.0 + iconContainer.frame.size.width, y: 0, width: contentView.frame.size.width - 20.0 - iconContainer.frame.size.width, height: contentView.frame.size.height)
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        self.iconImgView.image = nil
        self.label.text = nil
        self.iconContainer.backgroundColor = nil
    }
    
    func configure(with model: SettingsOption){
        label.text = model.title
        iconImgView.image = model.icon
        iconContainer.backgroundColor = model.iconBackColor
    }
}
