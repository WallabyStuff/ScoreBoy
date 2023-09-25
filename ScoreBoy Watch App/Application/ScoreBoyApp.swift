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
  
  init() {
    FirebaseApp.configure()
  }
  
  var body: some Scene {
    WindowGroup {
      MainView()
    }
  }
}
