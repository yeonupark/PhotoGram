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
    
    let sampleView = {
        let view = UIView()
        view.backgroundColor = .systemBlue
        return view
    }()
    
    let greenView = {
        let view = UIView()
        view.backgroundColor = .systemGreen
        return view
    }()
    
    deinit {
        print(self, "deinit됨 ")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        // closure 2.
        completionHandler?(textView.text!)
    }
    
    func setAnimation() {
        // 시작할 때 ui
        sampleView.alpha = 0
        greenView.alpha = 0
        
        // 끝났을 때 ui
        UIView.animate(withDuration: 1, delay: 2, options: .curveLinear) {
            self.sampleView.alpha = 1
            self.sampleView.backgroundColor = .yellow
        } completion: { bool in
            //self.greenView.alpha = 0.5
            UIView.animate(withDuration: 1) {
                self.greenView.alpha = 0.8
            }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        DispatchQueue.main.async {
            
            self.greenView.alpha = 1.0
            UIView.animate(withDuration: 0.3) {
                self.greenView.alpha = 0.5
            }
        }
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        DispatchQueue.main.async {
            
            self.greenView.alpha = 0.5
            UIView.animate(withDuration: 0.3) {
                self.greenView.alpha = 1.0
            }
        }
    }
    
    override func configureView() {
        super.configureView()
        view.addSubview(textView)
        view.addSubview(sampleView)
        view.addSubview(greenView)
        setAnimation()
    }
    
    override func setConstraints() {
        
        sampleView.snp.makeConstraints { make in
            make.size.equalTo(100)
            make.center.equalTo(view)
        }
        textView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(10)
            make.height.equalTo(250)
        }
        greenView.snp.makeConstraints { make in
            make.center.equalToSuperview().offset(80)
            make.size.equalTo(120)
        }
    }
    
}
