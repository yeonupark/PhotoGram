//
//  TitleView.swift
//  PhotoGram
//
//  Created by 마르 on 2023/08/29.
//

import UIKit

class TitleView: BaseView {
    
    let textField = {
        let view = UITextField()
        view.placeholder = "제목을 입력해주세요"
        return view
    }()
    
    
    override func configureView() {
        addSubview(textField)
        
    }
    
    override func setConstraints() {
        textField.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(self.safeAreaLayoutGuide).inset(10)
            make.height.equalTo(50)
        }
    }
}
