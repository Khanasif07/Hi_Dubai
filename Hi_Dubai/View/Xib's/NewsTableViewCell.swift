//
//  NewsTableViewCell.swift
//  Hi_Dubai
//
//  Created by Admin on 11/02/23.
//

import UIKit
class NewsTableViewCell: UITableViewCell{
    
    @IBOutlet weak var timeLbl: UILabel!
    @IBOutlet weak var tagView: UIView!
    @IBOutlet weak var tagLbl: UILabel!
    @IBOutlet weak var descLbl: UILabel!
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var newsImgView: UIImageView!
    
    private lazy var setupOnce: Void = {
        self.newsImgView.layer.cornerRadius = 5.0
        self.tagView.layer.cornerRadius = 14.0
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupfont()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        newsImgView.image = nil
        descLbl.text = nil
        timeLbl.text = nil
        titleLbl.text = nil
        dateLbl.text = nil
        tagLbl.text = nil
      }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        _ = setupOnce
    }
    
    private func setupfont(){
        titleLbl.font = UIFont.boldSystemFont(ofSize: 15)
        descLbl.font = UIFont.boldSystemFont(ofSize: 14)
        dateLbl.font = UIFont.boldSystemFont(ofSize: 14)
        tagLbl.font = UIFont.boldSystemFont(ofSize: 14)
        timeLbl.font = UIFont.boldSystemFont(ofSize: 14)
        dateLbl.textColor = .tertiaryLabel
        descLbl.textColor = .lightGray
        timeLbl.textColor = .tertiaryLabel
        tagLbl.textColor = .white
        self.tagView.backgroundColor = .orange
    }
    
    func populateCell(_ model: Record){
        titleLbl.text = model.title
        dateLbl.text  = model.dateString
        descLbl.text  = model.content
        tagLbl.text   = model.primaryTag
        timeLbl.text  = "- \(model.readTime)" + " min read"
        newsImgView.setImageFromUrl(ImageURL: model.postImageURL)
    }
}
