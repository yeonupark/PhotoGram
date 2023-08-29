//
//  DateFormatter+Extension.swift
//  PhotoGram
//
//  Created by 마르 on 2023/08/29.
//

import Foundation

// static을 통해 dateformat 인스턴스를 미리 만들어놓고 얘를 활용하자 .

extension DateFormatter {
    static let format = {
        let format = DateFormatter()
        format.dateFormat = "yyyy년 MM월 dd일"
        return format
    }()
    
    static func today() -> String {
        return format.string(from: Date())
    }
    
    static func convertDate(date: Date) -> String {
        return format.string(from: date)
    }
}
