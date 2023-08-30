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
    
    func callRequest() {
        
        let url = URL(string: "https://api.nasa.gov/assets/img/general/apod.jpg")
        
        let request = URLRequest(url: url!)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            print(data)
            
            let value = String(data: data!, encoding: .utf8) // byte 시각적으로 확인하기
            print(value)
            
            print(response)
            print(error)
        }.resume() // 네트워크 통신 시작하라고 트리거를 주는 사인.
    }
}
