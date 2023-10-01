//
//  MainView.swift
//  ScoreBoy Watch App
//
//  Created by 이승기 on 2023/09/16.
//

import SwiftUI

struct MainView: View {
  
  // MARK: - Properties
  
  @StateObject var viewModel = MainViewModel()
  
  
  // MARK: - Views
  
  var body: some View {
    NavigationStack {
      ZStack {
        if viewModel.matchHistories.isEmpty == false {
          ScrollView {
            LazyVStack(spacing: 6, content: {
              ForEach(viewModel.matchHistories, id: \.id) { history in
                historyListItem(history)
              }
            })
            .padding(.horizontal, 4)
            .padding(.bottom, 80)
          }
        }
        
        VStack(spacing: 0) {
          if viewModel.matchHistories.isEmpty {
            Text("아직 경기 기록이\n없습니다.")
              .multilineTextAlignment(.center)
              .font(.system(size: 15, weight: .semibold))
              .foregroundStyle(Color.sbGray50)
              .frame(maxWidth: .infinity, maxHeight: .infinity)
              .padding(.top, 32)
          } else {
            Spacer()
          }
          
          ZStack {
            LinearGradient(colors: [.clear, .black, .black, .black], startPoint: .top, endPoint: .bottom)
              .ignoresSafeArea()
            
            HStack(spacing: 4) {
              NavigationLink {
                let viewModel = GoalScoreViewModel()
                GoalScoreView(viewModel: viewModel)
              } label: {
                Text("새 게임")
                  .font(.system(size: 15, weight: .bold))
                  .frame(maxWidth: .infinity, maxHeight: 44)
                  .background(Color.sbBlue)
                  .clipShape(RoundedRectangle(cornerRadius: 8))
              }
              .buttonStyle(.plain)
              
              NavigationLink {
                JoinMatchView(viewModel: .init())
              } label: {
                Text("참가")
                  .font(.system(size: 15, weight: .bold))
                  .frame(width: 52, height: 44)
                  .background(Color.sbGreen)
                  .clipShape(RoundedRectangle(cornerRadius: 8))
              }
              .buttonStyle(.plain)
            }
            .padding(4)
          }
          .frame(height: 68)
        }
      }
      .navigationTitle("경기 기록")
      .edgesIgnoringSafeArea(.bottom)
      .onAppear {
        viewModel.loadMatchHistories()
      }
    }
  }
  
  private func historyListItem(_ history: MatchHistory) -> some View {
    HStack(spacing: 12) {
      Rectangle()
        .fill(history.myScore > history.opScore ? Color.sbGreen : Color.sbRed)
        .frame(width: 4)
      
      Text("\(history.myScore) : \(history.opScore)")
        .font(.system(size: 20, weight: .bold))
        .foregroundStyle(Color.sbWhite)
      
      Spacer()
      
      VStack {
        Text(history.date.formatted())
          .font(.system(size: 10))
          .foregroundStyle(Color.sbGray20)
        
        Spacer()
      }
      .padding(.vertical, 6)
      .padding(.trailing, 6)
    }
    .frame(height: 40)
    .background(Color.sbGray70)
    .clipShape(RoundedRectangle(cornerRadius: 8))
  }
}


// MARK: - Preview

struct MainView_Previews: PreviewProvider {
  static var previews: some View {
    MainView()
  }
}
