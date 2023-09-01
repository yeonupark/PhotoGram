//
//  APIService.swift
//  PhotoGram
//
//  Created by 마르 on 2023/08/30.
//

import Foundation

class APIService {
    
    private init() {} // 인스턴스 생성 방지 !!
    
    static let shared = APIService() // 인스턴스 생성하지 말고 얘를 사용해라.
    
    func callRequest(query: String, completionHandler: @escaping (Photo?) -> Void) {
        
        guard let url = URL(string: "https://api.unsplash.com/search/photos/?query=\(query)&client_id=\(Key.unsplash)") else { return }
        let request = URLRequest(url: url, timeoutInterval: 10)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            DispatchQueue.main.async {
                if let error { // error가 nil이 아니라면
                    completionHandler(nil)
                    return
                }
                
                guard let response = response as? HTTPURLResponse, (200...500).contains(response.statusCode) else {
                    completionHandler(nil)  // Alert 또는 Do try Catch 등 사용자에게 띄워주기
                    return
                }
                
                guard let data = data else {
                    completionHandler(nil)
                    return }
                do {
                    let result = try JSONDecoder().decode(Photo.self, from: data)
                    completionHandler(result) //
                    print(result)
                } catch {
                    completionHandler(nil)
                }
            }
            
        }.resume() // 네트워크 통신 시작하라고 트리거를 주는 사인.
    }
}

struct Photo: Codable {
    let total: Int
    let total_pages: Int
    let results: [PhotoResult]
}

struct PhotoResult: Codable {
    let id: String
    let urls: PhotoURL
}

struct PhotoURL: Codable {
    let full: String
    let thumb: String
}
