//
//  WebSearchViewController.swift
//  PhotoGram
//
//  Created by 마르 on 2023/08/31.
//

import UIKit

// Alamofire 사용

class WebSearchViewController: BaseViewController {
    
    let mainView = SearchView()
    var imageList: [String] = []
    
    override func loadView() {
        view.self = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainView.searchButton.addTarget(self, action: #selector(callRequest), for: .touchUpInside)
        
    }
    
    @objc func callRequest() {
        
        guard let text = mainView.searchBar.text else { return }
        UnsplashAPIManager.shared.callRequest(query: text) { data in
            for result in data.results {
                self.imageList.append(result.urls.small)
                print(result.urls.small)
            }
        }
        print(imageList)
    }
    
}
