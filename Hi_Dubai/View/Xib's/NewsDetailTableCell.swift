//
//  NewsDetailTableCell.swift
//  Hi_Dubai
//
//  Created by Admin on 11/02/23.
//

import UIKit
class NewsDetailTableCell: UITableViewCell {
    @IBOutlet weak var readTimeLbl: UILabel!
    @IBOutlet weak var tagView: UIView!
    @IBOutlet weak var tagLbl: UILabel!
    @IBOutlet weak var descLbl: UILabel!
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var titleLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupfont()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        descLbl.text = nil
        titleLbl.text = nil
        dateLbl.text = nil
        tagLbl.text = nil
        readTimeLbl.text = nil
      }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.tagView.layer.cornerRadius = 16.0
    }
    
    private func setupfont(){
        titleLbl.font = UIFont.boldSystemFont(ofSize: 15)
        descLbl.font = UIFont.boldSystemFont(ofSize: 14)
        dateLbl.font = UIFont.boldSystemFont(ofSize: 14)
        readTimeLbl.font = UIFont.boldSystemFont(ofSize: 14)
        tagLbl.font = UIFont.boldSystemFont(ofSize: 14)
        dateLbl.textColor = .tertiaryLabel
        descLbl.textColor = .lightGray
        readTimeLbl.textColor = .tertiaryLabel
        tagLbl.textColor = .white
        self.tagView.backgroundColor = .orange
    }
    
    var cellViewModel: Record?{
        didSet{
            titleLbl.text = cellViewModel?.title
            dateLbl.text  = cellViewModel?.dateString
            descLbl.text  = cellViewModel?.content
            tagLbl.text =   cellViewModel?.primaryTag
            readTimeLbl.text = "- \(cellViewModel?.readTime ?? "")" + " min read"
        }
    }
}
