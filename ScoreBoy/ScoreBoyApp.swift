//
//  ScoreBoyApp.swift
//  ScoreBoy
//
//  Created by 이승기 on 2023/09/16.
//

import SwiftUI
import Firebase

@main
struct ScoreBoyApp: App {
  
  init() {
    FirebaseApp.configure()
  }
  
  var body: some Scene {
    WindowGroup {
      ContentView()
    }
  }
}
