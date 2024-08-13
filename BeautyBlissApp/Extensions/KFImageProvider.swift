//
//  KFImageProvider.swift
//  BeautyBlissApp
//
//  Created by Sevde Aydın on 13.08.2024.
//

import Kingfisher
import SwiftUI

struct KFImageProvider: ImageDataProvider {
    let cacheKey: String = UUID().uuidString
    let image: UIImage
    
    func data(handler: @escaping (Result<Data, Error>) -> Void) {
        if let imageData = image.pngData() {
            handler(.success(imageData))
        } else {
            handler(.failure(NSError(domain: "com.example", code: -1, userInfo: nil)))
        }
    }
}
