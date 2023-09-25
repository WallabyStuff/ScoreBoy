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
  
  @Published var entryCode = RandomCodeGenerator.generateRandomCode()
  @Published var matchState = MatchState.waiting
  
  private let ref = Database.database().reference()
  
  
  // MARK: - Initializers
  
  deinit {
    removeMatchStateObserver()
  }
  
  
  // MARK: - Public
  
  public func generateRoom() {
    ref.child(entryCode)
      .child("test UserID")
      .setValue(["score" : 0, "state" : 0])
    
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
      .observe(.childAdded) { [weak self] snapshot in
        if snapshot.key != "test UserID" {
          self?.matchState = .matched
        }
      }
  }
  
  private func removeMatchStateObserver() {
    ref.child(entryCode)
      .removeAllObservers()
  }
}
