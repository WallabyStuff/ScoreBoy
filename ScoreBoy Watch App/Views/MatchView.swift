//
//  MatchView.swift
//  ScoreBoy Watch App
//
//  Created by 이승기 on 2023/09/16.
//

import SwiftUI

struct MatchView: View {
  
  // MARK: - Properties
  
  @StateObject var viewModel: MatchViewModel
  
  
  // MARK: - Views
  
  var body: some View {
    HStack(spacing: 4) {
      VStack(spacing: 4) {
        Button {
          viewModel.adjustMy(score: 1)
        } label: {
          Image(systemName: "plus")
            .font(.system(size: 24, weight: .medium))
            .frame(maxWidth: .infinity, maxHeight: 40)
            .background(Color.sbGray70)
            .clipShape(RoundedRectangle(cornerRadius: 8))
        }
        .buttonStyle(.plain)
        
        VStack {
          Text("나")
            .font(.system(size: 13))
            .opacity(0.6)
          
          Text(viewModel.myScore.description)
            .font(.system(size: 44, weight: .bold))
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(4)
        .background(Color.sbBlue.opacity(0.6))
        .clipShape(RoundedRectangle(cornerRadius: 8))
        
        Button {
          viewModel.adjustMy(score: -1)
        } label: {
          Image(systemName: "minus")
            .font(.system(size: 24, weight: .medium))
            .frame(maxWidth: .infinity, maxHeight: 40)
            .background(Color.sbGray70)
            .clipShape(RoundedRectangle(cornerRadius: 8))
        }
        .buttonStyle(.plain)
      }
      
      VStack(spacing: 4) {
        Button {
          viewModel.adjustOp(score: 1)
        } label: {
          Image(systemName: "plus")
            .font(.system(size: 24, weight: .medium))
            .frame(maxWidth: .infinity, maxHeight: 40)
            .background(Color.sbGray70)
            .clipShape(RoundedRectangle(cornerRadius: 8))
        }
        .buttonStyle(.plain)
        
        VStack {
          Text("상대")
            .font(.system(size: 13))
            .opacity(0.6)
          
          Text(viewModel.opScore.description)
            .font(.system(size: 44, weight: .bold))
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(4)
        .background(Color.sbGreen.opacity(0.6))
        .clipShape(RoundedRectangle(cornerRadius: 8))
        
        Button {
          viewModel.adjustOp(score: -1)
        } label: {
          Image(systemName: "minus")
            .font(.system(size: 24, weight: .medium))
            .frame(maxWidth: .infinity, maxHeight: 40)
            .background(Color.sbGray70)
            .clipShape(RoundedRectangle(cornerRadius: 8))
        }
        .buttonStyle(.plain)
      }
    }
    .edgesIgnoringSafeArea(.bottom)
  }
}


// MARK: - Preview

#Preview {
  MatchView(viewModel: .init(key: "22D11"))
}
