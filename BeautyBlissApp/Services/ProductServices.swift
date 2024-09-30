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
        case get = "GET"
        case post = "POST"
        case put = "PUT"
        case delete = "DELETE"
    }
    
    private static func performRequest(urlPath: String, method: Method, parameters: [String: Any]? = nil, completion: @escaping (Result<Data, NetworkError>) -> Void) {
        guard let url = URL(string: "\(NetworkConstants.baseURL)\(urlPath)") else {
            completion(.failure(.urlError))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        if let params = parameters, (method == .post || method == .put) {
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
            
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(.serverError))
                return
            }
            
            switch httpResponse.statusCode {
            case 200, 201:
                guard let data = data else {
                    completion(.failure(.noData))
                    return
                }
                completion(.success(data))
            case 401:
                completion(.failure(.unauthorized))
            default:
                completion(.failure(.serverError))
            }
        }
        task.resume()
    }
    
    // Ürün listesi çekme
    static func fetchProduct(completion: @escaping (Result<Data, NetworkError>) -> Void) {
        performRequest(urlPath: "product", method: .get, completion: completion)
    }
    
    // Ürün bilgisi ID ile çekme
    static func fetchProductById(productId: String, completion: @escaping (Result<Data, NetworkError>) -> Void) {
        performRequest(urlPath: "product/\(productId)", method: .get, completion: completion)
    }
    
    // Favorilere ürün ekleme
    static func addFavorite(productId: String, userId: String, completion: @escaping (Result<[String: Any], NetworkError>) -> Void) {
        let params = ["productId": productId, "userId": userId]
        performRequest(urlPath: "favorite", method: .post, parameters: params) { result in
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
    
    // Favori kaldırma (isActive'ı false yapma)
    static func removeFavorite(favoriteId: String, completion: @escaping (Result<Void, NetworkError>) -> Void) {
        performRequest(urlPath: "favorite/\(favoriteId)", method: .put) { result in
            switch result {
            case .success(_):
                completion(.success(()))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    // Kullanıcının favorilerini çekme
    static func fetchFavorite(userId: String, completion: @escaping (Result<Data, NetworkError>) -> Void) {
        performRequest(urlPath: "favorite/\(userId)", method: .get, completion: completion)
    }
}
