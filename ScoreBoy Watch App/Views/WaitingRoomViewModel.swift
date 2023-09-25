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
  
  @Published var entryCode = RandomCodeGenerator.generateRandomCode()
  private let ref = Database.database().reference()
  
  // MARK: - Methods
  
  public func generateRoom() {
    ref.child(entryCode)
      .child("test UserID")
      .setValue(["score" : 0, "state" : 0])
  }
  
  public func removeRoom() {
    ref.child(entryCode)
      .child("test UserID")
      .removeValue()
  }
  
  public func observeMatchState() {
    ref.child(entryCode)
      .child(entryCode)
      .observe(.childAdded) { snapshot in
        print("🔥 matched")
      }
  }
}
