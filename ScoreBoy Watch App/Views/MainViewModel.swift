//
//  MainViewModel.swift
//  ScoreBoy Watch App
//
//  Created by 이승기 on 2023/09/16.
//

import SwiftUI

final class MainViewModel: ObservableObject {
  
  // MARK: - Properties
  
  private let matchHistoryManager = MatchHistoryManager()
  @Published private(set) var matchHistories = [MatchHistory]()
  
  
  // MARK: - Public
  
  public func loadMatchHistories() {
    matchHistories = matchHistoryManager.loadMatchHistories()
  }
}
