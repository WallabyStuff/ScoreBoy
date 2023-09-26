//
//  ScoreBoyApp.swift
//  ScoreBoy Watch App
//
//  Created by 이승기 on 2023/09/16.
//

import SwiftUI
import Firebase

@main
struct ScoreBoy_Watch_AppApp: App {
  
  // MARK: - Initializers
  
  init() {
    FirebaseApp.configure()
    UserIdManager.shared.generateIdIfNotExists()
  }
  

  // MARK: - Views
  
  var body: some Scene {
    WindowGroup {
      MainView()
    }
  }
}
