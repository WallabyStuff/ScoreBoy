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
  private let userId = UserIdManager.shared.getUserId()
  private var opUserId = ""
  private var goalScore: Int = 0
  
  @Published private(set) var myScore = 0
  @Published private(set) var opScore = 0
  
  @Published var isMeWon = false
  @Published var isOpWon = false
  
  
  // MARK: - Initializers
  
  init(key: String) {
    self.key = key
    
    setupMatchInfo()
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
      .child(userId)
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
      .child(opUserId)
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
  
  private func setupMatchInfo() {
    ref.child(key).observeSingleEvent(of: .value) { [weak self] snapshot in
      guard let self = self,
            var dictionary = snapshot.value as? [String: Any] else { return }
      
      // 딕셔너리에서 내 아이디 값 빼고 나머지로 매치 정보 세팅
      dictionary.removeValue(forKey: userId)
      
      dictionary.forEach { key, value in
        if key == "goal_score" {
          self.goalScore = value as! Int
        } else {
          self.opUserId = key
        }
      }
    }
  }
  
  private func observeMatch() {
    ref.child(key)
      .observe(.childChanged) { [weak self] snapshot in
        guard let self else { return }
        
        if let value = snapshot.value as? [String: Any] {
          if let newScore = value["score"] as? Int {
            // 상대 점수 업데이트
            if snapshot.key == opUserId {
              self.opScore = newScore
              
              // 상대 점수가 목표 점수에 도달했는지 확인
              if newScore == self.goalScore {
                isOpWon = true
              }
            }
            
            // 내 점수 업데이트
            if snapshot.key == self.userId {
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
