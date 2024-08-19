//
//  NoonHomeVC.swift
//  Hi_Dubai
//
//  Created by Asif Khan on 11/06/2024.
//

import UIKit

class NoonHomeVC: BaseVC {
    var isAnimateInProgress:Bool = false
   
    @IBOutlet var headerImgViews: [UIImageView]!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var internalScrollView: UIScrollView!
    override func viewDidLoad() {
        super.viewDidLoad()
        internalScrollView.delegate = self
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        // Do any additional setup after loading the view.
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
extension NoonHomeVC{
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        print(scrollView.contentOffset.y)
        let isHeaderImgShowing = self.headerImgViews.first?.isHidden ?? false
        if scrollView.contentOffset.y > 128 && !isAnimateInProgress && !isHeaderImgShowing{
            self.isAnimateInProgress = true
            UIView.animate(withDuration: 1, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 5, options: .curveEaseInOut, animations: {
                    self.headerImgViews.forEach({$0.alpha = 0.0})
                    self.headerImgViews.forEach({$0.isHidden = true})
                    self.view.layoutIfNeeded()
                }) { _ in
                    self.isAnimateInProgress = false
//                    self.viewToAnimate.removeFromSuperview()
                }
            
        }else if scrollView.contentOffset.y < 128 && !isAnimateInProgress && isHeaderImgShowing{
         
                self.isAnimateInProgress = true
            UIView.animate(withDuration: 1, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 5, options: .curveEaseInOut, animations: {
                self.headerImgViews.forEach({$0.isHidden = false})
                self.headerImgViews.forEach({$0.alpha = 0.5})
                self.view.layoutIfNeeded()
            }) { animated in
                self.headerImgViews.forEach({$0.alpha = 1.0})
                self.isAnimateInProgress = false
            }
//            UIView.animate(withDuration: 1, delay: 0.0, usingSpringWithDamping: 0.0, initialSpringVelocity: 5, options: .curveEaseInOut, animations: {
//                    self.headerImgViews.forEach({$0.isHidden = false})
//                    self.headerImgViews.forEach({$0.alpha = 1.0})
//                    self.view.layoutIfNeeded()
//                }) { _ in
//                    self.isAnimateInProgress = false
//                    //                self.viewToAnimate.removeFromSuperview()
//                }
        }
    }
}
