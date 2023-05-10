//
//  PartnersViewController.swift
//  Hi_Dubai
//
//  Created by Asif Khan on 05/05/2023.
//


import Foundation
import UIKit

class PartnersViewController: UIViewController {

    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var loader: UIActivityIndicatorView!
    @IBOutlet var tryAgainView: UIView!
    @IBOutlet var errorMsgLbl: UILabel!
    @IBOutlet var retryBtn: UIButton!
    
    
    var partners : [(String,Bool)] =
    [("PARTNER",false),("PARTNER",false),("PARTNER",false),("PARTNER",false),("PARTNER",false),("PARTNER",false),("PARTNER",false),("PARTNER",false),("PARTNER",false),("PARTNER",false)]
    
    override func viewDidLoad() {
       super.viewDidLoad()
        tryAgainView.isHidden = true
        self.loader.isHidden = true
        collectionView.registerCell(with: PartnerCollectionCell.self)
        loader.hidesWhenStopped = true
        loader.color = self.UIColorFromRGB(0x17B6AD);
        self.view.backgroundColor = UIColor(named: "searchBackground")
//        errorMsgLbl.text = "Unable to get Partners information"
//        retryBtn.semanticContentAttribute = .forceRightToLeft
   }
    
    func fetchDataSourceFromServer() {
        tryAgainView.isHidden = true
        loader.startAnimating()
        delay(seconds: 1.0, completion: {
            self.loader.stopAnimating()
            self.loader.isHidden = true
            self.collectionView.scrollToItem(at: IndexPath(item: 1, section: 0), at: .centeredHorizontally, animated: true)
        })
    }

   override func viewWillAppear(_ animated: Bool) {
       super.viewWillAppear(animated)
      
   }

       override func viewDidAppear(_ animated: Bool) {
//        loader.center = self.view.center
        reloadView()
    }
    
    
    func reloadView(){
        DispatchQueue.main.async {
            self.collectionView.reloadData()
            self.collectionView.scrollToItem(at: IndexPath(item: 1, section: 0), at: .centeredHorizontally, animated: false)
        }
    }
    
     @IBAction func reload(_ sender: Any) {
        fetchDataSourceFromServer()
    }
    
    
    @objc func flipPreviousCardIfAvailable(){

        let countLimit = partners.count
        let indexPaths =  collectionView.indexPathsForVisibleItems

        for index in 0..<countLimit {

            let isCardFlipped = partners[index].1
            if isCardFlipped == true {
                partners[index].1  = false
                for path in indexPaths {

                    if path.item == index {
                        (collectionView.cellForItem(at: path) as? PartnerCollectionCell)?.flipCard(isFlipped: true)
                        break
                    }
                }
            }

        }

    }
    
    func UIColorFromRGB(_ rgbValue: UInt) -> UIColor {
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }

    
}


extension PartnersViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return partners.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 240.0, height: 213.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PartnerCollectionCell", for: indexPath) as? PartnerCollectionCell
        cell?.setPatnerObjs(partners[indexPath.item])
        return cell!
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10.0
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let isFlipped = partners[indexPath.item].1
        (cell as? PartnerCollectionCell)?.showHideDetailCard(show: isFlipped)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 10)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        guard let cell = collectionView.cellForItem(at: indexPath) as? PartnerCollectionCell else {
            return
        }
        let isFlipped = partners[indexPath.row].1
        if isFlipped == false {
            flipPreviousCardIfAvailable()
        }
        cell.flipCard(isFlipped: isFlipped)
        partners[indexPath.row].1  = !isFlipped
    }
    
}
