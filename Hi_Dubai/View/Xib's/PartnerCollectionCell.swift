//
//  PartnerCollectionCell.swift
//  Hi_Dubai
//
//  Created by Asif Khan on 05/05/2023.
//

import UIKit
import Foundation

class PartnerCollectionCell: UICollectionViewCell {
//    var partnerObj: Partner?
    @IBOutlet weak var bgView1StackBtmCost: NSLayoutConstraint!
    @IBOutlet weak var bgView1: UIView!
    @IBOutlet weak var photo1: UIImageView!
    @IBOutlet weak var titleLabel1: UILabel!
    
    @IBOutlet weak var bgView2: UIView!
    @IBOutlet weak var titleLabel2: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var readMoreBtn: UIButton!
//    weak var delegate:PartnerCollectionCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        bgView1.layer.cornerRadius = 5.0
        bgView1.clipsToBounds = true
//        bgView1.layer.borderWidth = 1.0
//        bgView1.layer.borderColor = UIColor(named: "separatorColor")?.cgColor
//        photo1.roundCorners([.allCorners], radius: 10.0)
//        photo1.contentMode = .scaleAspectFill
        photo1.clipsToBounds = true
        
        bgView2.layer.cornerRadius = 5.0
        bgView2.clipsToBounds = true
        bgView2.layer.borderWidth = 1.0
        bgView2.layer.borderColor = UIColor(named: "separatorColor")?.cgColor
        
        bgView1.isHidden = false
        bgView2.isHidden = true
        
        titleLabel2.textColor = UIColor.white
        descLabel.textColor = UIColor.white
        bgView2.backgroundColor = UIColor(red: 23.0/255.0, green: 182.0/255.0, blue: 173.0/255.0, alpha: 0.8)
        //bgView2.backgroundColor = UIColor(red: 26.0/255.0, green: 170.0/255.0, blue: 193.0/255.0, alpha: 0.8)
        //bgView2.backgroundColor = UIColor(named: "blackAndWhiteColor")?.withAlphaComponent(0.6)
        
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        // You need to change the border color here
        bgView1.layer.borderColor = UIColor(named: "separatorColor")?.cgColor
        bgView2.layer.borderColor = UIColor(named: "separatorColor")?.cgColor
//        setPatnerImageAsPerThemeMode()
        //photo1.sd_setImage(with: imageUrl, placeholderImage: UIImage(from: WalifTheme.lightGrey()))

        
    }
    
    func showHideDetailCard( show:Bool){

        let isCardFlipped = show

        let xDim = bgView2.frame.origin.x
        let widthDim = bgView2.frame.size.width
        let heightDim = bgView2.frame.size.height

        if isCardFlipped == true {
            self.bgView2.frame = CGRect(x: xDim, y: 0, width: widthDim, height: heightDim)
            bgView2.isHidden = false
            //bgView1.alpha = 0.2
            bgView1.alpha = 0.2
        }else {
            self.bgView2.frame = CGRect(x: xDim, y: heightDim, width: widthDim, height: heightDim)
            bgView2.isHidden = true
            bgView1.alpha = 1.0
        }
    }
    
    func setPatnerObjs(_ partnerObjRef: (String,Bool)) {
//        self.partnerObj = partnerObjRef
        photo1.contentMode = .scaleAspectFit
        photo1.clipsToBounds = true

//        if let data = partnerObjRef {
            let isCardFlipped = partnerObjRef.1

            let xDim = bgView2.frame.origin.x
            let widthDim = bgView2.frame.size.width
            let heightDim = bgView2.frame.size.height

            if isCardFlipped == true {
                self.bgView2.frame = CGRect(x: xDim, y: 0, width: widthDim, height: heightDim)
                bgView2.isHidden = false
               // bgView1.alpha = 0.2
                bgView1.alpha = 0.2
            }else {
                self.bgView2.frame = CGRect(x: xDim, y: heightDim, width: widthDim, height: heightDim)
                bgView2.isHidden = true
                bgView1.alpha = 1.0
            }
//            titleLabel1.text = data.title?.uppercased()
//            titleLabel2.text = data.title?.uppercased()
//            descLabel.text = data.description


            setPatnerImageAsPerThemeMode()

            /*photo2.sd_setImage(with: imageUrl, placeholderImage: UIImage(from: WalifTheme.lightGrey()))
            photo2.contentMode = .scaleAspectFit
            photo2.clipsToBounds = true*/
//        }
    }
    
    
    func setPatnerImageAsPerThemeMode() {
    }
    
    func flipCard(isFlipped:Bool) {



        let xDim = bgView2.frame.origin.x
        var yDim = bgView2.frame.origin.y


        let widthDim = bgView2.frame.size.width
        let heightDim = bgView2.frame.size.height

        var finalYDim = yDim
        if isFlipped == true {
            yDim = 0
            finalYDim = heightDim
        }else {
            yDim = heightDim
            finalYDim = 0
        }




        bgView2.frame = CGRect(x: xDim, y: yDim, width: widthDim, height: heightDim)
        self.bgView2.isHidden = false
        UIView.animate(withDuration: 0.4, animations: {

            if finalYDim == 0 {
                //self.bgView1.alpha = 0.2
                self.bgView1.alpha = 0.2
            }else {
                self.bgView1.alpha = 1.0
            }

            self.bgView2.frame = CGRect(x: xDim, y: finalYDim, width: widthDim, height: heightDim)

         }) { finished in

                if finalYDim == 0 {
                    self.bgView2.isHidden = false
                    //self.bgView1.alpha = 0.2
                    self.bgView1.alpha = 0.2
                }else {
                    self.bgView2.isHidden = true
                    self.bgView1.alpha = 1.0
                }
               }


//        if isFlipped == false {
//            // is fliping to view details, Send Google Analytics
//            if let code = self.partnerObj?.code {
//
////                Analytics.logEvent(GA_ACTION_VIEWED_PARTNER_DESC, parameters: [
////                WE_EVENT_NAME: GA_ACTION_VIEWED_PARTNER_DESC,
////                GA_EVENT_CATEGORY: GA_CATEGORY_HOMEPAGE,
////                GA_EVENT_LABEL: code
////                ])
//
//            }
//        }

    }
    
    func populateCell(model: Record?){
        self.photo1.setImageFromUrl(ImageURL: model?.postImageURL ?? "")
        self.titleLabel1.text = model?.title ?? ""
    }

}


