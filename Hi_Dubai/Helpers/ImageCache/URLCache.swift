//
//  URLCache.swift
//  Hi_Dubai
//
//  Created by Asif Khan on 23/05/2023.
//

import Foundation
import PromiseKit

protocol ImageRepositoryProtocol {
    func getImage(imageURL: URL) -> Promise<UIImage>
    func downloadImage(imageURL: URL) -> Promise<UIImage>
    func loadImageFromCache(imageURL: URL) -> Promise<UIImage>
}

private class EmptyPromise: Error { }

public class ImageRepository: ImageRepositoryProtocol {
    public static let shared = ImageRepository()
    let cache = URLCache.shared
   
    func getImage(imageURL: URL) -> Promise<UIImage> {

        let imagePath = imageURL.path
        let request = URLRequest(url: imageURL)

        if (self.cache.cachedResponse(for: request) != nil) {
            return self.loadImageFromCache(imageURL: imageURL)
        } else {
            return self.downloadImage(imageURL: imageURL)
        }
    }
    
    func downloadImage(imageURL: URL) -> Promise<UIImage> {
        return Promise { seal in
            let request = URLRequest(url: imageURL)
                        
            DispatchQueue.global().async {
                let dataTask = URLSession.shared.dataTask(with: imageURL) {data, response, _ in
                    if let data = data {
                        let cachedData = CachedURLResponse(response: response!, data: data)
                        self.cache.storeCachedResponse(cachedData, for: request)
                        seal.fulfill(UIImage(data: data)!)
                    }
                }
                dataTask.resume()
            }
        }
    }
    
    func loadImageFromCache(imageURL: URL) -> Promise<UIImage> {
        return Promise { seal in
            let request = URLRequest(url: imageURL)
            
            DispatchQueue.global(qos: .userInitiated).async {
                if let data = self.cache.cachedResponse(for: request)?.data, let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        seal.fulfill(image)
                    }
                }
            }
        }
    }
    
}
