//
//  HomeViewController.swift
//  PhotoGram
//
//  Created by 마르 on 2023/08/31.
//

import UIKit

// 프로토콜 생성해서 '셀을 선택했다'는 정보 넘겨주기 (값 전달)
// AnyObject: 클래스에서만 프로토콜을 정의할 수 있도록 제약
protocol HomeViewProtocol : AnyObject {
    func didSelectItemAt(indexPath: IndexPath)
}

class HomeViewController: BaseViewController {
    
    override func loadView() {
        let view = HomeView()
        view.delegate = self
        self.view = view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(self, #function)
    }
    
    deinit {
        print(self, #function)
    }
}

extension HomeViewController: HomeViewProtocol {
    func didSelectItemAt(indexPath: IndexPath) {
        print(indexPath)
        navigationController?.popViewController(animated: true)
    }
    
}
