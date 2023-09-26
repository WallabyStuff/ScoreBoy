//
//  UserIdManager.swift
//  ScoreBoy Watch App
//
//  Created by 이승기 on 2023/09/26.
//

import UIKit

class UserIdManager {
  
  // MARK: - Properties
  
  static var shared = UserIdManager()
  private let key = "USER_ID"
  
  
  // MARK: - Initializers
  
  private init() { }
  
  
  // MARK: - Methods
  
  public func generateIdIfNotExists() {
    // 기존에 생성한 유저 아이디가 없으면 생성
    if UserDefaults.standard.value(forKey: key) == nil {
      UserDefaults.standard.set(UUID().uuidString, forKey: key)
    }
  }
  
  public func getUserId() -> String {
    return UserDefaults.standard.value(forKey: key) as! String
  }
}
