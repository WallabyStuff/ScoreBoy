//
//  GoalScoreView.swift
//  ScoreBoy Watch App
//
//  Created by 이승기 on 2023/09/16.
//

import SwiftUI

struct GoalScoreView: View {
  
  // MARK: - Properties
  
  @StateObject var viewModel: GoalScoreViewModel
  
  
  // MARK: - Views
  
  var body: some View {
    VStack(spacing: 12) {
      HStack {
        Spacer()
        
        VStack(spacing: 8) {
          Text("목표 점수")
            .font(.system(size: 13, weight: .medium))
          
          Text(viewModel.goalScore.description)
            .font(.system(size: 44, weight: .bold))
        }
        
        Spacer()
        
        VStack(spacing: 5) {
          Button {
            viewModel.increaseScore()
          } label: {
            Image(systemName: "plus")
              .font(.system(size: 24, weight: .medium))
              .frame(maxWidth: 54, maxHeight: .infinity)
              .background(Color.sbGray70)
              .clipShape(RoundedRectangle(cornerRadius: 8))
          }
          .buttonStyle(.plain)
          
          Button {
            viewModel.decreaseScore()
          } label: {
            Image(systemName: "minus")
              .font(.system(size: 24, weight: .medium))
              .frame(maxWidth: 54, maxHeight: .infinity)
              .background(Color.sbGray70)
              .clipShape(RoundedRectangle(cornerRadius: 8))
          }
          .buttonStyle(.plain)
        }
        .frame(maxHeight: .infinity)
      }
      .frame(maxWidth: .infinity, maxHeight: .infinity)
      .padding(8)
      
      NavigationLink {
        let viewModel = CreateMatchViewModel(goalScore: viewModel.goalScore)
        CreateMatchView(viewModel: viewModel)
      } label: {
        Text("다음")
          .font(.system(size: 15, weight: .bold))
          .foregroundStyle(Color.white)
          .frame(maxWidth: .infinity, maxHeight: 44)
          .background(Color.sbBlue)
          .clipShape(RoundedRectangle(cornerRadius: 8))
      }
      .buttonStyle(.plain)
      .padding(.bottom, 8)
    }
    .padding(.horizontal, 8)
    .edgesIgnoringSafeArea(.bottom)
  }
}


// MARK: - Preview

#Preview {
  NavigationView(content: {
    GoalScoreView(viewModel: .init())
  })
}
