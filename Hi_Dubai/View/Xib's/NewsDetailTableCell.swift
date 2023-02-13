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
        self.tagView.layer.cornerRadius = 18.0
    }
    
    private func setupfont(){
        titleLbl.font = UIFont.boldSystemFont(ofSize: 16)
        descLbl.font = UIFont.boldSystemFont(ofSize: 15)
        dateLbl.font = UIFont.boldSystemFont(ofSize: 15)
        readTimeLbl.font = UIFont.boldSystemFont(ofSize: 15)
        tagLbl.font = UIFont.boldSystemFont(ofSize: 15)
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
