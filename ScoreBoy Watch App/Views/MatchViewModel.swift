//
//  MatchViewModel.swift
//  ScoreBoy Watch App
//
//  Created by 이승기 on 2023/09/26.
//

import SwiftUI
import Firebase

class MatchViewModel: ObservableObject {
  
  // MARK: - Properties
  
  private let key: String
  private let ref = Database.database().reference()
  private let goalScore: Int
  
  @Published var myScore = 0
  @Published var opScore = 0
  
  @Published var isMeWon = false
  @Published var isOpWon = false
  
  
  // MARK: - Initializers
  
  init(key: String, goalScore: Int) {
    self.key = key
    self.goalScore = goalScore
    
    observeMatch()
  }
  
  deinit {
    ref.child(key)
      .removeAllObservers()
  }
  
  
  // MARK: - Public
  
  public func adjustMy(score: Int) {
    let increasedNumber = myScore + score
    myScore = increasedNumber
    
    ref.child(key)
      .child("test_user_id")
      .setValue(["score" : increasedNumber])
    
    // 내 점수가 목표 점수에 도달했는지 확인
    if increasedNumber == goalScore {
      isMeWon = true
    }
  }
  
  public func adjustOp(score: Int) {
    let increasedNumber = opScore + score
    opScore = increasedNumber
    
    ref.child(key)
      .child("test_op_user_id")
      .setValue(["score" : increasedNumber])
    
    // 상대 점수가 목표 점수에 도달했는지 확인
    if increasedNumber == goalScore {
      isOpWon = true
    }
  }
  
  public func finishMatch() {
    ref.child(key)
      .removeValue()
  }
  
  
  // MARK: - Private
  
  private func observeMatch() {
    ref.child(key)
      .observe(.childChanged) { [weak self] snapshot in
        guard let self else { return }
        
        if let value = snapshot.value as? [String: Any] {
          if let newScore = value["score"] as? Int {
            // 상대 점수 업데이트
            if snapshot.key == "test_op_user_id" {
              self.opScore = newScore
              
              // 상대 점수가 목표 점수에 도달했는지 확인
              if newScore == self.goalScore {
                isOpWon = true
              }
            }
            
            // 내 점수 업데이트
            if snapshot.key == "test_user_id" {
              self.myScore = newScore
              
              // 내 점수가 목표 점수에 도달했는지 확인
              if newScore == self.goalScore {
                isMeWon = true
              }
            }
          }
        }
      }
  }
}
