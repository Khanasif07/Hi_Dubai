//
//  NetworkManager.swift
//  Hi_Dubai
//
//  Created by Admin on 11/02/23.
//

import Foundation
extension Error {
    var errorCode:Int? {
        return (self as NSError).code
    }
}
class NetworkManager{
    static let shared = NetworkManager()
    private init(){}
    
    func getDataFromServer<T: Codable>(requestType: AppNetworkingHttpMethods,
                                       endPoint: String,_ params: [String: String] = [:],_ completion: @escaping (Result<T,Error>) -> Void){
        let urlStringWithQuery = self.queryString(endPoint, params: params)
        guard let url = URL(string: urlStringWithQuery!) else { return }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = requestType.rawValue
        urlRequest.setValue(EndPoint.x_master_key.rawValue, forHTTPHeaderField: "X-MASTER-KEY")
        //
        let sessionConfig = URLSessionConfiguration.default
        sessionConfig.timeoutIntervalForRequest  = 5.0
        sessionConfig.timeoutIntervalForResource = 5.0
        //
        let task = URLSession(configuration: sessionConfig).dataTask(with: urlRequest) { data, response, error in
            if let error = error{
                completion(.failure(error))
                return
            }
            do {
                let formatter = DateFormatter()
                formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .formatted(formatter)
                let model = try decoder.decode(T.self, from: data!)
                completion(.success(model))
            }catch(let error){
                print(error)
                completion(.failure(error))
            }
        }
        task.resume()
    }
    
    func queryString(_ value: String, params: [String: String]) -> String? {
        var components = URLComponents(string: value)
        components?.queryItems = params.map { element in URLQueryItem(name: element.key, value: element.value) }
        return components?.url?.absoluteString
    }
}
