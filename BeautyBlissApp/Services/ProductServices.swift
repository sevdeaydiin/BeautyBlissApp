//
//  ProductServices.swift
//  BeautyBlissApp
//
//  Created by Sevde Aydın on 13.08.2024.
//

import Foundation

public class ProductServices {
    
    enum NetworkError: Error {
        case urlError, noData, serverError, decodingError, unauthorized, customError(String)
    }
    
    enum Method: String {
        case get, post, put, delete
    }
    
    //public static var requestDomain = ""
    
    private static func performRequest(urlPath: String, method: String, parameters: [String: Any]? = nil, completion: @escaping (Result<Data, NetworkError>) -> Void) {
        guard let url = URL(string: "\(NetworkConstants.baseURL)\(urlPath)")  else {
            completion(.failure(.urlError))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = method
        //Method.post.rawValue
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        if let params = parameters, method == "POST" {
            do {
                request.httpBody = try JSONSerialization.data(withJSONObject: params)
            } catch {
                completion(.failure(.decodingError))
                return
            }
        }
        
        if let token = UserDefaults.standard.string(forKey: "jsonwebtoken") {
            request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(.customError(error.localizedDescription)))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                completion(.failure(.serverError))
                return
            }
            
            guard let data = data else {
                completion(.failure(.noData))
                return
            }
            completion(.success(data))
        }
        task.resume()
    }
    
    
    static func fetchProduct(completion: @escaping (Result<Data, NetworkError>) -> Void) {
        performRequest(urlPath: "product", method: "GET", completion: completion)
    }
    
    static func fetchProductById(productId: String, completion: @escaping (Result<Data, NetworkError>) -> Void) {
        performRequest(urlPath: "product/\(productId)", method: "GET", completion: completion)
    }
    
    static func addFavorite( productId: String, userId: String, completion: @escaping (Result<[String: Any], NetworkError>) -> Void) {
        let params = ["productId": productId, "userId": userId]
        performRequest(urlPath: "favorite/\(userId)", method: "POST", parameters: params) { result in
            switch result {
            case .success(let data):
                do {
                    if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                        completion(.success(json))
                    } else {
                        completion(.failure(.decodingError))
                    }
                } catch {
                    completion(.failure(.decodingError))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    static func fetchFavorite(userId: String, completion: @escaping (Result<Data, NetworkError>) -> Void) {
        performRequest(urlPath: "favorite/\(userId)", method: "GET", completion: completion)
    }
    
    
    /*public static var requestDomain = ""
    
    static func fetchProduct(completion: @escaping (_ result: Result<Data?, NetworkError>) -> Void) {
        let url = URL(string: requestDomain)!
        
        let session = URLSession.shared
        var request = URLRequest(url: url)
                                 //, cachePolicy: .returnCacheDataElseLoad, timeoutInterval: 10.0)
        
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let task = session.dataTask(with: request) { data, res, err in
            guard err == nil else {
                completion(.failure(.noData))
                return
            }
            guard let data = data else { return }
            completion(.success(data))
        }
        task.resume()
    }
    
    
    static func fetchProductById(completion: @escaping (_ result: Result<Data?, NetworkError>) -> Void) {
        let url = URL(string: requestDomain)!
        
        let session = URLSession.shared
        var request = URLRequest(url: url)
                                 //, cachePolicy: .returnCacheDataElseLoad, timeoutInterval: 10.0)
        
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let task = session.dataTask(with: request) { data, res, err in
            guard err == nil else {
                completion(.failure(.noData))
                return
            }
            guard let data = data else { return }
            completion(.success(data))
        }
        task.resume()
    }
    
    static func addFavorite(productId: String, userId: String, completion : @escaping (_ result: Result<[String: Any]?, DatabaseError>) -> Void) {
        let params = ["productId": productId, "userId": userId] as [String: Any]
        let url = URL(string: requestDomain)!
        let session = URLSession.shared
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: params, options: .prettyPrinted)
        } catch let error {
            print(error)
        }
        
        // authentication part in the http request
        let token = UserDefaults.standard.string(forKey: "jsonwebtoken")!
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let task = session.dataTask(with: request) { data, res, err in
            guard err == nil else { return }
            guard let data = data else { return }
            
            do {
                if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] {
                    completion(.success(json))
                }
            } catch {
                completion(.failure(DatabaseError.failedToFavorite))
            }
        }
        task.resume()
    }*/
    
}

