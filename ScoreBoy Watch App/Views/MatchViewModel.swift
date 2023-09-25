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
  
  @Published var myScore = 0
  @Published var opScore = 0
  
  
  // MARK: - Initializers
  
  init(key: String) {
    self.key = key
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
      .child("test UserID")
      .setValue(["score" : increasedNumber])
  }
  
  public func adjustOp(score: Int) {
    let increasedNumber = opScore + score
    opScore = increasedNumber
    
    ref.child(key)
      .child("test op UserID")
      .setValue(["score" : increasedNumber])
  }
  
  
  // MARK: - Private
  
  private func observeMatch() {
    ref.child(key)
      .observe(.childChanged) { [weak self] snapshot in
        print(snapshot)
        print(snapshot.key)
        print(snapshot.children)
        
        if let value = snapshot.value as? [String: Any] {
          if let newScore = value["score"] as? Int {
            // 상대 점수 업데이트
            if snapshot.key == "test op UserID" {
              self?.opScore = newScore
            }
            
            // 내 점수 업데이트
            if snapshot.key == "test UserID" {
              self?.myScore = newScore
            }
          }
        }
      }
  }
}