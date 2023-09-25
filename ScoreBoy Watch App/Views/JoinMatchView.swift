//
//  JoinMatchView.swift
//  ScoreBoy Watch App
//
//  Created by 이승기 on 2023/09/25.
//

import SwiftUI

struct JoinMatchView: View {
  
  // MARK: - Properties
  
  @StateObject var viewModel: JoinMatchViewModel
  
  @State private var isShowingEntryCodeErrorAlert = false
  
  
  // MARK: - Views
  
  var body: some View {
    VStack(spacing: 9) {
      RoundedRectangle(cornerRadius: 8)
        .fill(Color.sbGray70)
        .overlay {
          ZStack {
            Text(viewModel.entryCode.isEmpty ? "입장코드" : viewModel.entryCode)
              .font(.system(size: 20, weight: .bold))
              .foregroundStyle(viewModel.entryCode.isEmpty ? Color.sbGray40 : Color.sbWhite)
            
            HStack {
              Spacer()
              
              Button {
                viewModel.deleteCode()
              } label: {
                Image(systemName: "delete.left.fill")
                  .padding()
                  .foregroundStyle(Color.sbGray20)
              }
              .buttonStyle(.plain)
            }
          }
        }
        .frame(height: 40)
        .padding(8)
      
      entryCodeKeyboard()
    }
    .edgesIgnoringSafeArea(.bottom)
    .frame(maxHeight: .infinity)
    .alert("5자리 입장코드를 모두 입력해 주세요", isPresented: $isShowingEntryCodeErrorAlert) {
      Button("확인", role: .cancel) { }
    }
  }
  
  private func entryCodeKeyboard() -> some View {
    GeometryReader { proxy in
      VStack(spacing: 4) {
        Spacer()
        
        HStack(spacing: 4) {
          ForEach(["A", "B", "C", "D"], id: \.self) { character in
            Button {
              viewModel.enterCode(character)
            } label: {
              RoundedRectangle(cornerRadius: 8)
                .fill(Color.sbGray70)
                .frame(maxWidth: .infinity, maxHeight: proxy.size.width / 4)
                .overlay {
                  Text(character)
                    .font(.system(size: 20, weight: .bold))
                    .foregroundStyle(Color.white)
                }
            }
            .buttonStyle(.plain)
          }
        }
        
        HStack(spacing: 4) {
          ForEach([1, 2, 3], id: \.self) { number in
            Button {
              viewModel.enterCode(number.description)
            } label: {
              RoundedRectangle(cornerRadius: 8)
                .fill(Color.sbGray70)
                .frame(maxWidth: .infinity, maxHeight: proxy.size.width / 4)
                .overlay {
                  Text(number.description)
                    .font(.system(size: 20, weight: .bold))
                    .foregroundStyle(Color.white)
                }
            }
            .buttonStyle(.plain)
          }
          
          Button {
            if viewModel.entryCode.count != 5 {
              // 입장코드 5자리 모두 입력하지 않았을 때 alert
              isShowingEntryCodeErrorAlert = true
            } else {
              // 입장 시도
              viewModel.enter()
            }
          } label: {
            RoundedRectangle(cornerRadius: 8)
              .fill(Color.sbGreen)
              .frame(maxWidth: .infinity, maxHeight: proxy.size.width / 4)
              .overlay {
                Image(systemName: "arrowshape.right.fill")
                  .bold()
              }
          }
          .buttonStyle(.plain)
        }
      }
      .padding(4)
    }
  }
}

#Preview {
  NavigationView(content: {
    JoinMatchView(viewModel: .init())
  })
}
