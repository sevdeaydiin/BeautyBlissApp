//
//  ProductServices.swift
//  BeautyBlissApp
//
//  Created by Sevde Aydın on 13.08.2024.
//

import Foundation

public class ProductServices {
    
    public static var requestDomain = ""
    
    static func fetchProduct(completion: @escaping (_ result: Result<Data?, NetworkError>) -> Void) {
        let url = URL(string: requestDomain)!
        
        let session = URLSession.shared
        var request = URLRequest(url: url, cachePolicy: .returnCacheDataElseLoad, timeoutInterval: 10.0)
        
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
        var request = URLRequest(url: url, cachePolicy: .returnCacheDataElseLoad, timeoutInterval: 10.0)
        
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
}

