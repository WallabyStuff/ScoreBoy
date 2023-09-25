//
//  WaitingRoomView.swift
//  ScoreBoy Watch App
//
//  Created by 이승기 on 2023/09/25.
//

import SwiftUI

struct WaitingRoomView: View {
  
  // MARK: - Properties
  
  @StateObject var viewModel: WaitingRoomViewModel
  
  
  // MARK: - Views
  
  var body: some View {
    VStack(spacing: 16) {
      Text(viewModel.entryCode)
        .font(.system(size: 28, weight: .bold))
        .foregroundStyle(Color.white)
      
      Text("상대 플레이어에게\n코드를 보여 주세요")
        .font(.system(size: 15))
        .foregroundStyle(Color.sbGray30)
    }
    .onAppear {
      viewModel.generateRoom()
      viewModel.observeMatchState()
    }
    .onDisappear {
      viewModel.removeRoom()
    }
  }
}

#Preview {
  WaitingRoomView(viewModel: .init())
}
