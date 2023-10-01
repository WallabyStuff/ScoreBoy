//
//  WaitingRoomViewModel.swift
//  ScoreBoy Watch App
//
//  Created by 이승기 on 2023/09/25.
//

import SwiftUI
import Firebase

final class WaitingRoomViewModel: ObservableObject {
  
  // MARK: - Properties
  
  enum MatchState {
    case matched
    case waiting
  }
  
  private let ref = Database.database().reference()
  private let userId = UserIdManager.shared.getUserId()
  public let goalScore: Int
  
  @Published private(set) var entryCode = RandomCodeGenerator.generateRandomCode()
  @Published private(set) var matchState = MatchState.waiting
  
  
  
  // MARK: - Initializers
  
  init(goalScore: Int) {
    self.goalScore = goalScore
  }
  
  deinit {
    removeMatchStateObserver()
  }
  
  
  // MARK: - Public
  
  public func generateRoom() {
    ref.child(entryCode)
      .setValue([
        "goal_score" : goalScore,
        userId : ["score" : 0]
      ])
    
    // 방 생성한 후 상대방이 들오는지 상태 감시
    observeMatchState()
  }
  
  public func removeRoom() {
    ref.child(entryCode)
      .removeValue()
  }
  
  
  // MARK: - Private
  
  private func observeMatchState() {
    ref.child(entryCode)
      .observe(.value) { [weak self] snapshot in
        guard let self else { return }
        // 내 아이디가 아닌 사람이 들어왔다면 매치 시작
        print(snapshot.childrenCount)
        if snapshot.childrenCount == 3 {
          self.matchState = .matched
        }
      }
  }
  
  private func removeMatchStateObserver() {
    ref.child(entryCode)
      .removeAllObservers()
  }
}
