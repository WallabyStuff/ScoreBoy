//
//  MainViewModel.swift
//  ScoreBoy Watch App
//
//  Created by 이승기 on 2023/09/16.
//

import SwiftUI

final class MainViewModel: ObservableObject {
  
  // MARK: - Properties
  
  @Published private(set) var histories = [History]()
  
  
  // MARK: - Public
  
  public func fetchHistories() {
    histories = [
      .init(myScore: 14, opScore: 13, date: .init()),
      .init(myScore: 4, opScore: 32, date: .init()),
      .init(myScore: 14, opScore: 42, date: .init())
    ]
  }
}
