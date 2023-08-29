//
//  TextViewController.swift
//  PhotoGram
//
//  Created by 마르 on 2023/08/29.
//

import UIKit

class TextViewController: BaseViewController {
    
    // closure 1.
    var completionHandler: ((String) -> Void)?
    
    let textView = {
        let view = UITextView()
        view.backgroundColor = .lightGray
        
        return view
    }()
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        // closure 2.
        completionHandler?(textView.text!)
    }
    
    override func configureView() {
        super.configureView()
        view.addSubview(textView)
    }
    
    override func setConstraints() {
        textView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(10)
            make.height.equalTo(250)
        }
    }
    
}
