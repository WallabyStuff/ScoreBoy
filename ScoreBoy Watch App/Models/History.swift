//
//  History.swift
//  ScoreBoy Watch App
//
//  Created by 이승기 on 2023/09/16.
//

import Foundation

struct History: Identifiable {
  let id = UUID()
  let myScore: Int
  let opScore: Int
  let date: Date
}
