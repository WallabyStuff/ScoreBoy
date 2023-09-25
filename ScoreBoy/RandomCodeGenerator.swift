//
//  RandomCodeGenerator.swift
//  ScoreBoy
//
//  Created by 이승기 on 2023/09/25.
//

import Foundation

struct RandomCodeGenerator {
  static func generateRandomCode() -> String {
    let characters = "abcd1234"
    var randomString = ""
    
    // 8자리 조합 생성
    for _ in 0..<5 {
      let randomIndex = Int(arc4random_uniform(UInt32(characters.count)))
      let randomCharacter = characters[characters.index(characters.startIndex, offsetBy: randomIndex)]
      randomString.append(randomCharacter)
    }
    
    return randomString
  }
}
