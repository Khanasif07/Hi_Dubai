//
//  DetailVC.swift
//  Hi_Dubai
//
//  Created by Admin on 11/02/23.
//

import UIKit

class DetailVC: UIViewController {

    @IBOutlet weak var tagLbl: UILabel!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var mainImgView: UIImageView!
    var viewModel: NewsDetailViewModel = NewsDetailViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.mainImgView.setImageFromUrl(ImageURL: self.viewModel.newsModel?.postImageURL ?? "")
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func backBtn(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
