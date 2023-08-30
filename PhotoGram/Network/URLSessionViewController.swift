//
//  URLSessionViewController.swift
//  PhotoGram
//
//  Created by 마르 on 2023/08/30.
//

import UIKit

class URLSessionViewController: UIViewController {
    
    var session: URLSession!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = URL(string: "https://www.nasa.gov/sites/default/files/thumbnails/image/lunar-south-pole-lro-svs.jpg")
        let request = URLRequest(url: url!)
        
        session = URLSession(configuration: .default, delegate: self, delegateQueue: .main)
        session.dataTask(with: request).resume()
        
    }
    
}

extension URLSessionViewController: URLSessionDataDelegate {
    
    // 서버에서 최초로 응답 답은 경우에 호출 (상태코드 처리)
//    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive response: URLResponse) async -> URLSession.ResponseDisposition {
//        print("RESPONSE", response)
//    }
    
    // 서버에서 데이터 받을 때마다 반복적으로 호출
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data) {
        print("DATA:", data)
    }
    
    // 서버에서 응답이 완료가 된 이후에 호출
    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        print("END")
    }
}
