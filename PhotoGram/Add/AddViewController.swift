//
//  ViewController.swift
//  PhotoGram
//
//  Created by 마르 on 2023/08/28.
//

import UIKit
import SeSACFramework

// protocol 값 전달 1. 프로토콜 구조 만들기
protocol PassDataDelegate {
    func receiveDate(date: Date)
}

protocol PassImageDelegate {
    func receiveImage(image: UIImage)
}

class AddViewController: BaseViewController {
    
    let mainView = AddView()
    
    override func loadView() { // viewDidLoad보다 먼저 호출됨, super 메서드 호출 X
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainView.SearchProtocolButton.addTarget(self, action: #selector(searchProtocolButtonClicked), for: .touchUpInside)
        mainView.dateButton.addTarget(self, action: #selector(dateButtonClicked), for: .touchUpInside)
        
        mainView.titleButton.addTarget(self, action: #selector(titleButtonClicked), for: .touchUpInside)
        mainView.textButton.addTarget(self, action: #selector(textButtonClicked), for: .touchUpInside)
        
        APIService.shared.callRequest()
    }
    
    deinit {
        print(self, "deinit됨") // 현재 클래스 네임
    }
    
    @objc func textButtonClicked() {
        let vc = TextViewController()
        vc.completionHandler = { jack in
            self.mainView.textButton.setTitle(jack, for: .normal)
        }
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func titleButtonClicked()  {
        let vc = TitleViewController()
        
        // Closure로 값 전달 - 3
        vc.completionHandler = { title, age, push in
            self.mainView.titleButton.setTitle(title, for: .normal)
            print("completionHadler")
        }
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func searchProtocolButtonClicked() {
        let vc = SearchViewController()
        vc.delegate = self
        present(vc, animated: true)
    }
    
    @objc func dateButtonClicked() {
        
//        let vc = DateViewController()
//        // 5.
//        vc.delegate = self
//        navigationController?.pushViewController(vc, animated: true)
        
        let vc = HomeViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print(#function)
        NotificationCenter.default.addObserver(self, selector: #selector(selectImageNotificationObserver), name: .selectImage, object: nil)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        NotificationCenter.default.removeObserver(self, name: .selectImage, object: nil)
    }
    
    @objc func selectImageNotificationObserver(notification: NSNotification) {
        
        print(#function)
        // 타입 캐스팅에 문제가 없다면
        if let name = notification.userInfo?["name"] as? String {
            mainView.photoImageView.image = UIImage(systemName: name)
        }
    }
    
    @objc func searchButtonClicked() {
        
        let word = ["Apple", "Banana", "Durian", "Mango", "Pineapple"]
        
        NotificationCenter.default.post(name: NSNotification.Name("ReccomendKeyword"), object: nil, userInfo: ["word": word.randomElement()!])
        navigationController?.pushViewController(SearchViewController(), animated: true) //
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

// 4.
extension AddViewController: PassDataDelegate {
    func receiveDate(date: Date) {
        mainView.dateButton.setTitle(DateFormatter.convertDate(date: date), for: .normal)
    }
}

extension AddViewController: PassImageDelegate {
    func receiveImage(image: UIImage) {
        mainView.photoImageView.image = image
    }
}
