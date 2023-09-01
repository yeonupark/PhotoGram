//
//  URLSessionViewController.swift
//  PhotoGram
//
//  Created by 마르 on 2023/08/30.
//

import UIKit

class URLSessionViewController: UIViewController {
    
    var session: URLSession!
    
    var total: Double = 0
    
    var buffer: Data? {
        didSet {
            let result = Double(buffer?.count ?? 0) / total
            progressLabel.text = "\(result * 100)%"
        }
    }
    
    let progressLabel = {
        let view = UILabel()
        view.backgroundColor = .black
        view.textColor = .white
        return view
    }()
    
    let imageView = {
        let view = UIImageView()
        view.backgroundColor = .lightGray
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        buffer = Data() // buffer?.append(data)가 실행되기 위함
        
        let url = URL(string: "https://www.nasa.gov/sites/default/files/thumbnails/image/lunar-south-pole-lro-svs.jpg")
        let request = URLRequest(url: url!)
        
        session = URLSession(configuration: .default, delegate: self, delegateQueue: .main)
        session.dataTask(with: request).resume()
        
        view.backgroundColor = .white
        view.addSubview(progressLabel)
        view.addSubview(imageView)
        
        progressLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(100)
        }
        imageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(100)
        }
    }
    
    // 다운로드 중단
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        // 취소 액션(화면이 사라질 때)
        // 리소스 즉시 정리. 실행중인 것도 무시
        session.invalidateAndCancel()
        
        // 기다렸다가 리소스 끝나면 정리 (이미지 세개 중에 지금 받고있는 하나만 다 다운 받고 중단해주겠다)
        //session.finishTasksAndInvalidate()
    }
    
}

extension URLSessionViewController: URLSessionDataDelegate {
    
    // 서버에서 최초로 응답 답은 경우에 호출 (상태코드 처리)
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive response: URLResponse) async -> URLSession.ResponseDisposition {
        print("RESPONSE", response) // 서버에 대한 헤더 출력해볼 수 있는 부분
        
        if let response = response as? HTTPURLResponse, (200...500).contains(response.statusCode) {
            
            total = Double(response.value(forHTTPHeaderField: "Content-Length")!)!
            
            return .allow
        } else {
            return .cancel
        }
    }
    
    // 서버에서 데이터 받을 때마다 반복적으로 호출
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data) {
        print("DATA:", data)
        buffer?.append(data) // buffer가 nil이면 append 구문 실행 안됨 -> buffer에 초기값 부여해줘서 nil값 안오게 하자.
    }
    
    // 서버에서 응답이 완료가 된 이후에 호출
    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        print("END")
        
        if let error {
            print(error)
        } else {
            guard let buffer = buffer else {
                print(error)
                return
            }
            
            imageView.image = UIImage(data: buffer)
        }
    }
}
