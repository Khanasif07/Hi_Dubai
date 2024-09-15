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

extension UIImage {
    
    func withColor(_ color1:UIColor?) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        let context = UIGraphicsGetCurrentContext()
        context?.translateBy(x: 0, y: size.height)
        context?.scaleBy(x: 1.0, y: -1.0)
        context?.setBlendMode(.normal)
        let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        if let cgImage = cgImage {
            context?.clip(to: rect, mask: cgImage)
        }
        color1?.setFill()
        context?.fill(rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }


    class func image(from color: UIColor?) -> UIImage? {
        let rect = CGRect(x: 0, y: 0, width: 1, height: 1)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        if let cgColor = color?.cgColor {
            context?.setFillColor(cgColor)
        }
        context?.fill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }

    class func image(from color: UIColor?, height heigth: Float, width: Float) -> UIImage? {
        let rect = CGRect(x: 0, y: 0, width: CGFloat(width), height: CGFloat(heigth))
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        if let cgColor = color?.cgColor {
            context?.setFillColor(cgColor)
        }
        context?.fill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }

    
    func scalingProportionally(to targetSize:CGSize) -> UIImage?{
        let sourceImage = self;
        var newImage:UIImage?
        
        let imageSize = sourceImage.size;
        let width = imageSize.width;
        let height = imageSize.height;
        
        let targetWidth = targetSize.width;
        let targetHeight = targetSize.height;
        
        var scaleFactor = 0.0;
        var scaledWidth = targetWidth;
        var scaledHeight = targetHeight;
        
        var thumbnailPoint = CGPoint(x: 0.0, y: 0.0)
        if !CGSizeEqualToSize(imageSize, targetSize) {
            
            let widthFactor = targetWidth / width
            let heightFactor = targetHeight / height
            
            if (widthFactor < heightFactor){
                scaleFactor = widthFactor
            }
            else {
                scaleFactor = heightFactor
            }
                
            scaledWidth  = width * scaleFactor
            scaledHeight = height * scaleFactor
            // center the image
            
            
            if (widthFactor < heightFactor) {
                thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
            } else if (widthFactor > heightFactor) {
                thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
            }
            
        }
        
        // this is actually the interesting part:
        UIGraphicsBeginImageContextWithOptions(targetSize, false, 0)
        
        var thumbnailRect = CGRect.zero;
        thumbnailRect.origin = thumbnailPoint;
        thumbnailRect.size.width  = scaledWidth;
        thumbnailRect.size.height = scaledHeight;
        
        sourceImage.draw(in: thumbnailRect)
        
        newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        if newImage == nil {
            print("could not scale image")
        }
        
        return newImage
        
        
    }

    
    
    class func fit(with view: UIView?, imageName: String?) -> UIImage? {

        if (imageName?.count ?? 0) < 1 {
            
            var e = NSException(name:NSExceptionName(rawValue: "There is no image name.") , reason:"Image name is : \(imageName ?? "")", userInfo:nil)
            e.raise()
          
        }

        var img: UIImage? = nil

        UIGraphicsBeginImageContext(view?.frame.size ?? CGSize.zero)
        UIImage(named: imageName ?? "")?.draw(in: view?.bounds ?? CGRect.zero)
        img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return img
    }
}
