//
//  UnsplashAPIManager.swift
//  PhotoGram
//
//  Created by 마르 on 2023/08/31.
//

import UIKit
import Alamofire

class UnsplashAPIManager {
    
    static let shared = UnsplashAPIManager()
    private init() {}
    
    func callRequest(query: String, completionHandler: @escaping (Image) -> Void) {
        
        let url = "https://api.unsplash.com/search/photos/?query=\(query)&client_id=\(Key.unsplash)"
        
        AF.request(url, method: .get).validate()
            .responseDecodable(of: Image.self) { response in
                guard let value = response.value else {
                    print(response)
                    return }
                
                completionHandler(value)
            }
        
    }
}
