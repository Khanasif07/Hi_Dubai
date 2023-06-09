//
//  Networking.swift
//  Hi_Dubai
//
//  Created by Asif Khan on 21/06/2023.
//

import Foundation
import UIKit

/// Result enum is a generic for any type of value
/// with success and failure case
//public enum ResultType<T> {
//    case success(T)
//    case failure(Error)
//}

final class Networking: NSObject {
    
    // MARK: - Private functions
    private static func getData(url: URL,
                                completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
    // MARK: - Public function
    
    /// downloadImage function will download the thumbnail images
    /// returns Result<Data> as completion handler
    public static func downloadImageFromCache(url: URL,
                                     completion: @escaping (Result<Data,Error>) -> Void) {
        Networking.getData(url: url) { data, response, error in
            
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data, error == nil else {
                return
            }
            
            DispatchQueue.main.async() {
                completion(.success(data))
            }
        }
    }
}
