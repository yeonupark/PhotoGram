//
//  DateViewController.swift
//  PhotoGram
//
//  Created by 마르 on 2023/08/29.
//

import UIKit

class DateViewController: BaseViewController {
    
    let mainView = DateView()
    
    // Protocol 값 전달 2. 부하직원으로 내가 가지고 있을게
    var delegate: PassDataDelegate?
    
    override func loadView() {
        self.view = mainView
    }
    
    // 3. 메서드를 실행시켜라
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        delegate?.receiveDate(date: mainView.picker.date)
    }
    
}
