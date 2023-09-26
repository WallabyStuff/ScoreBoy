//
//  JoinMatchViewModel.swift
//  ScoreBoy Watch App
//
//  Created by 이승기 on 2023/09/26.
//

import SwiftUI
import Firebase

final class JoinMatchViewModel: ObservableObject {
  
  // MARK: - Properties
  
  enum MatchState {
    case idle
    case matched
    case failed
  }
  
  private let ref = Database.database().reference()
  @Published var goalScore: Int? = nil
  
  @Published var entryCode = ""
  @Published var matchState = MatchState.idle
  
  
  // MARK: - Public
  
  public func deleteCode() {
    if entryCode.isEmpty == false {
      entryCode.removeLast()
    }
  }
  
  public func enterCode(_ character: String) {
    if entryCode.count < 5 {
      entryCode.append(character)
    }
  }
  
  public func enter() {
    // 해당 entryCode로 생성된 방이 없다면 빠른 종료
    ref.observeSingleEvent(of: .value) { [weak self] snapshot in
      guard let self else { return }
      
      if snapshot.hasChild(entryCode) {
        self.ref.child(entryCode)
          .child("test_op_user_id")
          .setValue(["score" : 0]) { [weak self] error, ref in
            if let error {
              self?.matchState = .failed
              print(error)
            }
            
            self?.observeMatchState()
          }
      } else {
        self.matchState = .failed
      }
    }
  }
  
  
  // MARK: - Private
  
  private func observeMatchState() {
    ref.child(entryCode)
      .observe(.childAdded) { [weak self] snapshot in
        if snapshot.key == "goal_score" {
          if let goalScore = snapshot.value as? Int {
            self?.goalScore = goalScore
          }
        }
        
        if snapshot.key == "test_op_user_id" {
          self?.matchState = .matched
        }
      }
  }
}
