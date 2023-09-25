//
//  JoinMatchViewModel.swift
//  ScoreBoy Watch App
//
//  Created by 이승기 on 2023/09/26.
//

import SwiftUI

final class JoinMatchViewModel: ObservableObject {
  
  // MARK: - Properties
  
  @Published var entryCode = ""
  
  
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
}
