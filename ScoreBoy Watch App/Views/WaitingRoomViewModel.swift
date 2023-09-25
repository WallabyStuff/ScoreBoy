//
//  WaitingRoomViewModel.swift
//  ScoreBoy Watch App
//
//  Created by 이승기 on 2023/09/25.
//

import SwiftUI

final class WaitingRoomViewModel: ObservableObject {
  
  // MARK: - Properties
  
  @Published var entryCode = RandomCodeGenerator.generateRandomCode()
  
  
  // MARK: - Methods
  
  public func generateEntryCode() {
//    entryCode =
  }
}
