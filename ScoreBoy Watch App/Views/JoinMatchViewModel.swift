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
  
  @Published var entryCode = ""
  
  private let ref = Database.database().reference()
  
  
  // MARK: - Methods
  
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
    ref.child(entryCode)
      .child("test op UserID")
      .setValue(["score" : 0, "state" : 0])
  }
}
