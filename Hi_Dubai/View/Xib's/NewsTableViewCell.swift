//
//  NewsTableViewCell.swift
//  Hi_Dubai
//
//  Created by Admin on 11/02/23.
//

import UIKit
class NewsTableViewCell: UITableViewCell{
    @IBOutlet weak var dataContainerView: UIView!
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
        self.dataContainerView.addShadow(cornerRadius: 5, color: UIColor(white: 48.0 / 255.0, alpha: 0.26), offset: CGSize(width: 0.5, height: 0.5), opacity: 1, shadowRadius: 5)
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
    
    var cellViewModel: Record?{
        didSet{
            titleLbl.text = cellViewModel?.title
            dateLbl.text  = cellViewModel?.dateString
            descLbl.text  = cellViewModel?.content
            tagLbl.text   = cellViewModel?.primaryTag
            timeLbl.text  = "- \(cellViewModel?.readTime ?? "")" + " min read"
            newsImgView.setImageFromUrl(ImageURL: cellViewModel?.postImageURL ?? "")
        }
    }
}
