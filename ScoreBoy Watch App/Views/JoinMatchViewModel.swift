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
  private let userId = UserIdManager.shared.getUserId()
  
  @Published private(set) var entryCode = ""
  @Published private(set) var matchState = MatchState.idle
  
  
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
          .child(userId)
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
        guard let self else { return }
        
        // 매치 노드에 내 아이디 추가가 되었다면 매치 시작
        if snapshot.key == self.userId {
          self.matchState = .matched
        }
      }
  }
}
