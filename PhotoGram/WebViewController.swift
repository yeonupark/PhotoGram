//
//  WebViewController.swift
//  PhotoGram
//
//  Created by 마르 on 2023/08/29.
//

import UIKit
import WebKit

class WebViewController: UIViewController, WKUIDelegate {

    var webView = WKWebView()
    
//    override func loadView() {
//        let webConfiguration = WKWebViewConfiguration()
//        webView = WKWebView(frame: .zero, configuration: webConfiguration)
//        webView.uiDelegate = self
//        view = webView
//    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(webView)
        
        webView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide).inset(10)
        }
        
        let myURL = URL(string:"https://www.apple.com")
        let myRequest = URLRequest(url: myURL!)
        webView.load(myRequest)
        
        // 네비게이션 컨트롤러 디자인
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .systemGreen
        
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        
        title = "이건 웹뷰입니다"
    }
    
    func reloadButtonClicked() {
        webView.reload()
    }
    
    func goBackButtonClicked() {
        if webView.canGoBack {
            webView.goBack()
        }
    }
    
    func goForwardButtonClicked() {
        if webView.canGoForward {
            webView.goForward()
        }
    }
}
