//
//  SearchView.swift
//  PhotoGram
//
//  Created by 마르 on 2023/08/28.
//

import UIKit

class SearchView: BaseView {
    
    let searchBar = {
        let view = UISearchBar()
        view.placeholder = "검색어를 입력해주세요"
        return view
    }()
    
    // 초기화 늦춰서 self에 대한 인스턴스 사용할 수 있게 해주기
    lazy var collectionView = {
        // UICollectionView parameter 두가지 가져와야함
        let view = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout())
        // 셀 등록
        view.register(SearchCollectionViewCell.self, forCellWithReuseIdentifier: "SearchCollectionViewCell")
        // 레이아웃 등록
        view.collectionViewLayout = collectionViewLayout()
        
        return view
    }()
    
    let searchButton = {
        let view = UIButton()
        view.backgroundColor = .systemBlue
        return view
    }()
    
    private func collectionViewLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 8
        let size = UIScreen.main.bounds.width - 40 //self.frame.width - 40
        //print(self.frame.width)
        layout.itemSize = CGSize(width: size/4, height: size/4)
        return layout
    }
    
    override func configureView() {
        addSubview(searchBar)
        addSubview(collectionView)
        addSubview(searchButton)
    }
    
    override func setConstraints() {
        searchBar.snp.makeConstraints { make in
            make.top.leading.equalTo(self.safeAreaLayoutGuide)
            make.trailing.equalTo(self.safeAreaLayoutGuide).inset(40)
        }
        searchButton.snp.makeConstraints { make in
            make.top.bottom.equalTo(searchBar)
            make.trailing.equalTo(self.safeAreaLayoutGuide)
        }
        collectionView.snp.makeConstraints { make in
            make.horizontalEdges.bottom.equalToSuperview()
            make.top.equalTo(searchBar.snp.bottom)
        }
    }
}
