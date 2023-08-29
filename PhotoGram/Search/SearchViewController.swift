//
//  SearchViewController.swift
//  PhotoGram
//
//  Created by 마르 on 2023/08/28.
//

import UIKit

class SearchViewController: BaseViewController {
    
    let mainView = SearchView()
    let imageList = ["star", "person", "star.fill", "heart", "heart.fill"]
    
    var delegate: PassImageDelegate?
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // addObserver보다 post가 먼저 신호를 보내면 실행될 수 없다...
        NotificationCenter.default.addObserver(self, selector: #selector(recommendKeywordNotificationObserver), name: NSNotification.Name("ReccomendKeyword"), object: nil)
    }

    @objc func recommendKeywordNotificationObserver(notification: NSNotification) {
        let word = notification.userInfo?["word"]
        print(word) // 출력 안됨
    }
    
    override func configureView() {
        super.configureView()
        
        mainView.collectionView.delegate = self
        mainView.collectionView.dataSource = self
    }
}

extension SearchViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SearchCollectionViewCell", for: indexPath) as? SearchCollectionViewCell else { return UICollectionViewCell() }
        
        cell.imageView.image = UIImage(systemName: imageList[indexPath.item])
        cell.imageView.backgroundColor = .systemPink
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        // 값 전달 - Notification (발신)
        //NotificationCenter.default.post(name: NSNotification.Name("SelectImage"), object: nil, userInfo: ["name": imageList[indexPath.item], "sample": "악어"])
        // 값 전달 - Delegate
        delegate?.receiveImage(image: UIImage(systemName: imageList[indexPath.item])!)
        
        dismiss(animated: true)
    }
    
}
