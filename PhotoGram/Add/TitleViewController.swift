//
//  TitleViewController.swift
//  PhotoGram
//
//  Created by 마르 on 2023/08/29.
//

import UIKit

class TitleViewController: BaseViewController {
    
    let mainView = TitleView()
    
    // Closure로 값 전달 - 1
    var completionHandler: ((String, Int, Bool) -> Void)?
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        // Closure로 값 전달 - 2
        //completionHandler?(mainView.textField.text!)
    }
    
    override func configureView() {
        super.configureView()

        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "완료", style: .plain, target: self, action: #selector(doneButtonClicked))
    }
    
    @objc func doneButtonClicked() {
        // Closure로 값 전달 - 2
        completionHandler?(mainView.textField.text!, 1220, false)
        navigationController?.popViewController(animated: true) //
    }
}
