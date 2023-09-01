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
    
    var list: Photo = Photo(total: 0, total_pages: 0, results: [])
    let mainView = HomeView()
    
    override func loadView() {
        
        //view.delegate = self
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(self, #function)
        
        mainView.collectionView.delegate = self
        mainView.collectionView.dataSource = self
        
        APIService.shared.callRequest(query: "bts") { photo in
            
            guard let photo = photo else {
                print("데이터를 받아오지 못했다는 에러얼럿띄우기 ")
                return
            }
            
            print("API END")
            self.list = photo // 네트워크 전후로 데이터가 변경됨.
            
            self.mainView.collectionView.reloadData() // 갱신해줘야한다
            
        }
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

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(#function)
        return list.results.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        print(#function)
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SearchCollectionViewCell", for: indexPath) as? SearchCollectionViewCell else { return UICollectionViewCell() }
        cell.imageView.backgroundColor = .systemBlue
        
        let thumb = list.results[indexPath.item].urls.thumb // String
        let url = URL(string: thumb) // 링크를 기반으로 이미지를 보여준다? 이거 자체가 네트워크 통신 !!!
        
        DispatchQueue.global().async {
            let data = try! Data(contentsOf: url!)
            
            DispatchQueue.main.async {
                cell.imageView.image = UIImage(data: data) // UI는 메인쓰레드에서만 가능 !!!
            }
        }
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //delegate?.didSelectItemAt(indexPath: indexPath)
        print(#function)
    }
}
