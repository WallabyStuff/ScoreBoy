//
//  MatchHistoryManager.swift
//  ScoreBoy Watch App
//
//  Created by 이승기 on 2023/10/01.
//

import Foundation

final class MatchHistoryManager {
  
  // MARK: - Properties
  
  private var matchHistories = [MatchHistory]()
  
  
  // MARK: - Initializers
  
  init() {
    matchHistories = loadMatchHistories()
  }
  
  
  // MARK: - Public
  
  public func save(matchHistory: MatchHistory) {
    do {
      matchHistories.append(matchHistory)
      let data = try JSONEncoder().encode(matchHistories)
      let url = getDocumentDirectory()
      try data.write(to: url)
    } catch {
      print("fail to save data", error)
    }
  }
  
  public func loadMatchHistories() -> [MatchHistory] {
    do {
      let url = getDocumentDirectory()
      let data = try Data(contentsOf: url)
      let matchHistories = try JSONDecoder().decode([MatchHistory].self, from: data)
      return matchHistories.sorted(by: {$0.date > $1.date})
    } catch {
      print("fail to load data", error)
      return []
    }
  }
  
  
  // MARK: - Private
  
  private func getDocumentDirectory() -> URL {
    let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    return path[0].appendingPathComponent("MatchHistory")
  }
}
