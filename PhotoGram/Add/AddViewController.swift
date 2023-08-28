//
//  ViewController.swift
//  PhotoGram
//
//  Created by 마르 on 2023/08/28.
//

import UIKit

class AddViewController: BaseViewController {
    
    let mainView = AddView()
    
    override func loadView() { // viewDidLoad보다 먼저 호출됨, super 메서드 호출 X
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(selectImageNotificationObserver), name: NSNotification.Name("SelectImage"), object: nil)
    }
    
    @objc func selectImageNotificationObserver(notification: NSNotification) {
        
        // 타입 캐스팅에 문제가 없다면
        if let name = notification.userInfo?["name"] as? String {
            mainView.photoImageView.image = UIImage(systemName: name)
        }
        
    }
    
    
    @objc func searchButtonClicked() {
        
        let word = ["Apple", "Banana", "Durian", "Mango", "Pineapple"]
        
        NotificationCenter.default.post(name: NSNotification.Name("ReccomendKeyword"), object: nil, userInfo: ["word": word.randomElement()!])
        present(SearchViewController(), animated: true)
    }
    
    override func configureView() { // addSubView
        super.configureView()
        print("Add ConfigureView")
        mainView.searchButton.addTarget(self, action: #selector(searchButtonClicked), for: .touchUpInside) //
    }

    override func setConstraints() { // 제약 조건
        super.setConstraints()
        print("Add SetConstraints")
    }
}

