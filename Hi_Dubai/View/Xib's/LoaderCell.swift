//
//  LoaderCell.swift
//  Hi_Dubai
//
//  Created by Asif Khan on 20/06/2023.
//

import UIKit

class LoaderCell: UITableViewCell {

    // MARK: - IBOutlets
    //=====================================================================
    @IBOutlet weak var loader: UIActivityIndicatorView!
    
    // MARK: - Cell lifecycle
    //=====================================================================
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
        self.loader.startAnimating()
        self.loader.color = .red
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.loader.startAnimating()
    }
    
}
