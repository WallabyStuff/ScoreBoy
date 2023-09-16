//
//  Date+Formatted.swift
//  ScoreBoy Watch App
//
//  Created by 이승기 on 2023/09/16.
//

import UIKit

extension Date {
  func formatted() -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy.MM.dd"
    return formatter.string(from: self)
  }
}
