//
//  GoalScoreViewModel.swift
//  ScoreBoy Watch App
//
//  Created by 이승기 on 2023/10/01.
//

import SwiftUI

final class GoalScoreViewModel: ObservableObject {
  
  // MARK: - Constants
  
  private let MAXIMUM_SCORE = 100
  private let MINIMUM_SCORE = 1
  
  private let LAST_USED_SCORE_KEY = "lastused.score"
  
  
  // MARK: - Properties
  
  @Published private(set) var goalScore = 1
  
  
  // MARK: - Public
  
  public func increaseScore() {
    if goalScore < MAXIMUM_SCORE {
      goalScore += 1
    }
  }
  
  public func decreaseScore() {
    if goalScore > MINIMUM_SCORE {
      goalScore -= 1
    }
  }
}
