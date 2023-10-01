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
  
  
  // MARK: - Properties
  
  @Published private(set) var goalScore = 1
  
  
  // MARK: - Public
  
  public func increaseScore() {
    if goalScore < MAXIMUM_SCORE {
      goalScore += 1
      saveLastUsedGoalScore()
    }
  }
  
  public func decreaseScore() {
    if goalScore > MINIMUM_SCORE {
      goalScore -= 1
      saveLastUsedGoalScore()
    }
  }
  
  
  // MARK: - Initializers
  
  init() {
    loadLastUsedGoalScore()
  }
  
  
  // MARK: - Private
  
  private func loadLastUsedGoalScore() {
    do {
      let url = getDocumentDirectory().appendingPathComponent("LastUsedScore")
      let data = try Data(contentsOf: url)
      goalScore = try JSONDecoder().decode(Int.self, from: data)
    } catch {
      print("fail to load data", error)
    }
  }
  
  private func saveLastUsedGoalScore() {
    do {
      let data = try JSONEncoder().encode(goalScore)
      let url = getDocumentDirectory().appendingPathComponent("LastUsedScore")
      try data.write(to: url)
    } catch {
      print("fail to save data", error)
    }
  }
  
  private func getDocumentDirectory() -> URL {
    let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    return path[0]
  }
}
