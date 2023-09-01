//
//  WebSearchViewController2.swift
//  PhotoGram
//
//  Created by 마르 on 2023/08/31.
//

import UIKit

// URLSession

class WebSearchViewController2: BaseViewController, URLSessionDelegate {
    
    let mainView = SearchView()
    var imageList: [String] = []
    
    override func loadView() {
        view.self = mainView
    }
    
    var session: URLSession!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainView.searchButton.addTarget(self, action: #selector(callRequest), for: .touchUpInside)
        
    }
    
    @objc func callRequest() {
        
        guard let text = mainView.searchBar.text else { return }
        let url = URL(string: "https://api.unsplash.com/search/photos/?query=\(text)&client_id=\(Key.unsplash)")
        let request = URLRequest(url: url!)
        
        session = URLSession(configuration: .default, delegate: self, delegateQueue: .main)
        session.dataTask(with: request).resume()
        
    }
}

extension WebSearchViewController: URLSessionDataDelegate {
    
    // 서버에서 데이터 받을 때마다 반복적으로 호출
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data) {
        print("DATA:", data)
        
        
    }
    
    // 서버에서 응답이 완료가 된 이후에 호출
    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        print("END")
    }
    
}
