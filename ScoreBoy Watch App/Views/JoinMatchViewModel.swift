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
  
  @Published var entryCode = ""
  @Published var matchState = MatchState.idle
  
  private let ref = Database.database().reference()
  
  
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
          .child("test op UserID")
          .setValue(["score" : 0]) { [weak self] error, ref in
            if let error {
              self?.matchState = .failed
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
        self?.matchState = .matched
      }
  }
}
