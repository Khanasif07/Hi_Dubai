//
//  UIImageExtension.swift
//  Hi_Dubai
//
//  Created by Admin on 11/02/23.
//

import Foundation
import UIKit
extension UIImageView {
    func setImageFromUrl(ImageURL :String) {
       URLSession.shared.dataTask( with: NSURL(string:ImageURL)! as URL, completionHandler: {
          (data, response, error) -> Void in
          DispatchQueue.main.async {
             if let data = data {
                self.image = UIImage(data: data)
             }
          }
       }).resume()
    }
}

