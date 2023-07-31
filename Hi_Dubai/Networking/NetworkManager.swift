//
//  NetworkManager.swift
//  Hi_Dubai
//
//  Created by Admin on 11/02/23.
//
import Network
import Foundation
extension Error {
    var errorCode:Int? {
        return (self as NSError).code
    }
}

class NetworkManager{
    let monitor = NWPathMonitor()
    static let shared = NetworkManager()
    private init(){
        networkConnectivity()
    }
    private var cache: URLCache = CacheManager.shared.cache

    func networkConnectivity(){
        monitor.pathUpdateHandler = { path in
            if path.status == .satisfied {
                print("We're connected!")
            } else {
                print("No connection.")
            }
            print(path.isExpensive)
        }
    }
    
    
    func getDataFromServer<T: Codable>(requestType: AppNetworkingHttpMethods,
                                       endPoint: String,_ params: [String: String] = [:],_ completion: @escaping (Result<T,Error>) -> Void){
        let urlStringWithQuery = self.queryString(endPoint, params: params)
        guard let url = URL(string: urlStringWithQuery!) else { return }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = requestType.rawValue
        urlRequest.setValue(EndPoint.x_master_key.rawValue, forHTTPHeaderField: "X-MASTER-KEY")
        //
        let sessionConfig = URLSessionConfiguration.default
        sessionConfig.requestCachePolicy = .returnCacheDataElseLoad
        sessionConfig.timeoutIntervalForRequest  = 2.5
        sessionConfig.timeoutIntervalForResource = 30
        sessionConfig.urlCache = cache
        sessionConfig.waitsForConnectivity = true
            let task = URLSession(configuration: sessionConfig).dataTask(with: urlRequest) { data, response, error in
                if let error = error{
                    completion(.failure(error))
                    return
                }
                do {
//                    self.cache.removeAllCachedResponses()
                    self.cache.storeCachedResponse(CachedURLResponse(response: response!, data: data!), for: urlRequest)
                    //==
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
    
    
    func getPumpkinDataFromServer<T: Codable>(requestType: AppNetworkingHttpMethods,
                                              endPoint: String,_ params: [String: String] = [:],_ path: String = "",_ completion: @escaping (Result<T,Error>) -> Void){
        let urlStringWithQuery = self.queryString(endPoint, params: params,path: path)
        guard let url = URL(string: urlStringWithQuery!) else { return }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = requestType.rawValue
        //
        let sessionConfig = URLSessionConfiguration.default
        sessionConfig.requestCachePolicy = .returnCacheDataElseLoad
        sessionConfig.timeoutIntervalForRequest  = 2.5
        sessionConfig.timeoutIntervalForResource = 2.5
        sessionConfig.urlCache = cache
        sessionConfig.waitsForConnectivity = true
        //
        let task = URLSession(configuration: sessionConfig).dataTask(with: urlRequest) { data, response, error in
            if let error = error{
                completion(.failure(error))
                return
            }
            do {
                //==
//                self.cache.removeAllCachedResponses()
                self.cache.storeCachedResponse(CachedURLResponse(response: response!, data: data!), for: urlRequest)
                //==
                let decoder = JSONDecoder()
                let model = try decoder.decode(T.self, from: data!)
                print("model:\(model)")
                completion(.success(model))
            }catch(let error){
                print(error)
                completion(.failure(error))
            }
        }
        task.resume()
    }
    
    func getCategoriesDataFromServer<T: Codable>(requestType: AppNetworkingHttpMethods,
                                              endPoint: String,_ params: [String: String] = [:],_ path: String = "",_ completion: @escaping (Result<T,Error>) -> Void){
        let urlStringWithQuery = self.queryString(endPoint, params: params,path: path)
        guard let url = URL(string: urlStringWithQuery!) else { return }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = requestType.rawValue
        urlRequest.allHTTPHeaderFields = ["Content-Type":"application/json","Accept":"application/json","WL-GuestUserId":"64a3e672dc1907771db37113","Authorization":"eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJib2xhZGVwMzEzQHJ4Y2F5LmNvbSIsImZpcnN0TmFtZSI6IlNuZWhhIiwibGFzdE5hbWUiOiJFbWFpbFVzZXIiLCJhdWRpZW5jZSI6IndlYiIsInBhc3N3b3JkIjoiJDJhJDEwJGlibnVBMjk4R09UWm1wRXZnU0doVk9LWlBJQWwvL0tpS0V2MVJLZm9ialJWcERINnpJN1htIiwicm9sZXMiOlt7ImF1dGhvcml0eSI6IlJPTEVfQlVTSU5FU1NfT1dORVIifSx7ImF1dGhvcml0eSI6IlJPTEVfVVNFUiJ9XSwibWlkZGxlTmFtZSI6IiIsImV4cCI6MTY5MTE0Mjg4NiwidXVpZCI6IjU0NTViNDExLThiMWEtNDcwNi1hOWIwLTcyZjk4ZGVhMjI2MSIsImVuYWJsZWQiOnRydWUsImVtYWlsIjoiYm9sYWRlcDMxM0ByeGNheS5jb20iLCJzdGF0dXMiOjF9.8iLVwEuZHTZhx8UcKudUhd-oK6dOyN8tguz4XmGFqCQ1vdNvai9xV73telzZmO86a5qbuD1FAfaYneHZmZUEyg","WL-Channel":"ma"]
        //
        let sessionConfig = URLSessionConfiguration.default
//        sessionConfig.requestCachePolicy = .returnCacheDataElseLoad
        sessionConfig.requestCachePolicy = .useProtocolCachePolicy
        sessionConfig.timeoutIntervalForRequest  = 2.5
        sessionConfig.timeoutIntervalForResource = 2.5
        sessionConfig.urlCache = cache
        sessionConfig.waitsForConnectivity = true
        //
        let task = URLSession(configuration: sessionConfig).dataTask(with: urlRequest) { data, response, error in
            if let error = error{
                completion(.failure(error))
                return
            }
            do {
                //==
//                self.cache.removeCachedResponse(for: urlRequest)
//                let currentDate = Date()
//                var dateComponent = DateComponents()
//                dateComponent.second = -60
//                let futureDate = Calendar.current.date(byAdding: dateComponent, to: currentDate)
                self.cache.storeCachedResponse(CachedURLResponse(response: response!, data: data!), for: urlRequest)
//                self.cache.removeCachedResponses(since: futureDate!)
                //==
                let decoder = JSONDecoder()
                let model = try decoder.decode(T.self, from: data!)
                print("model:\(model)")
                completion(.success(model))
            }catch(let error){
                print(error)
                completion(.failure(error))
            }
        }
        task.resume()
    }
    
    
    func getMovieDetailDataFromServer<T: Codable>(requestType: AppNetworkingHttpMethods,
                                              endPoint: String,_ params: [String: String] = [:],_ path: String = "",_ completion: @escaping (Result<T,Error>) -> Void){
        let urlStringWithQuery = self.queryString(endPoint, params: params,path: path)
        guard let url = URL(string: urlStringWithQuery!) else { return }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = requestType.rawValue
        //
        let sessionConfig = URLSessionConfiguration.default
        sessionConfig.requestCachePolicy = .returnCacheDataElseLoad
        sessionConfig.timeoutIntervalForRequest  = 2.5
        sessionConfig.timeoutIntervalForResource = 2.5
        sessionConfig.urlCache = cache
        sessionConfig.waitsForConnectivity = true
        //
        let task = URLSession(configuration: sessionConfig).dataTask(with: urlRequest) { data, response, error in
            if let error = error{
                completion(.failure(error))
                return
            }
            do {
                //==
//                self.cache.removeAllCachedResponses()
                self.cache.storeCachedResponse(CachedURLResponse(response: response!, data: data!), for: urlRequest)
                //==
                let decoder = JSONDecoder()
                let model = try decoder.decode(T.self, from: data!)
                print("model:\(model)")
                completion(.success(model))
            }catch(let error){
                print(error)
                completion(.failure(error))
            }
        }
        task.resume()
    }
    
    
    func queryString(_ value: String, params: [String: String],path: String! = "") -> String? {
        var components = URLComponents(string: value)
        if !params.isEmpty {
            components?.queryItems = params.map { element in URLQueryItem(name: element.key, value: element.value) }
        }
        //== Path Parameter
        if !(path.isEmpty) {
            if let paramPath = components?.path {
                components?.path = paramPath + path
            }
        }
        //==
        return components?.url?.absoluteString
    }
}
