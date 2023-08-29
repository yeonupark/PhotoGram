//
//  AddView.swift
//  PhotoGram
//
//  Created by 마르 on 2023/08/28.
//

import UIKit

class AddView: BaseView {
    
    let photoImageView = {
        let view = UIImageView()
        view.backgroundColor = .lightGray
        view.contentMode = .scaleAspectFill
        return view
    }()
    
    let searchButton = {
        let view = UIButton()
        view.backgroundColor = .systemPink
        
        return view
    }()
    
    let dateButton = {
        let view = UIButton()
        view.backgroundColor = .systemPink
        view.setTitle(DateFormatter.today(), for: .normal)
        
        return view
    }()
    
    let SearchProtocolButton = {
        let view = UIButton()
        view.backgroundColor = .black
        
        return view
    }()
    
    let titleButton = {
        let view = UIButton()
        view.backgroundColor = .darkGray
        view.setTitle("오늘의 사진", for: .normal)
        
        return view
    }()
    
    let textButton = {
        let view = UIButton()
        view.backgroundColor = .black
        view.setTitle("오늘의 한마디", for: .normal)
        
        return view
    }()
    
    override func configureView() {
        addSubview(photoImageView)
        addSubview(searchButton)
        addSubview(dateButton)
        addSubview(SearchProtocolButton)
        addSubview(titleButton)
        addSubview(textButton)
    }
    
    override func setConstraints() {
        photoImageView.snp.makeConstraints { make in
            make.leadingMargin.trailingMargin.topMargin.equalTo(self.safeAreaLayoutGuide).inset(20)
            make.height.equalTo(self).multipliedBy(0.3)
        }
        searchButton.snp.makeConstraints { make in
            make.size.equalTo(50)
            make.bottom.trailing.equalTo(photoImageView)
        }
        dateButton.snp.makeConstraints { make in
            make.top.equalTo(photoImageView.snp.bottom).offset(10)
            make.horizontalEdges.equalTo(self.safeAreaLayoutGuide).inset(10)
            make.height.equalTo(50)
        }
        SearchProtocolButton.snp.makeConstraints { make in
            make.size.equalTo(50)
            make.bottom.leading.equalTo(photoImageView)
        }
        titleButton.snp.makeConstraints { make in
            make.top.equalTo(dateButton.snp.bottom).offset(10)
            make.horizontalEdges.equalTo(self.safeAreaLayoutGuide).inset(10)
            make.height.equalTo(50)
        }
        textButton.snp.makeConstraints { make in
            make.top.equalTo(titleButton.snp.bottom).offset(10)
            make.horizontalEdges.equalTo(self.safeAreaLayoutGuide).inset(10)
            make.height.equalTo(200)
        }
    }
}
