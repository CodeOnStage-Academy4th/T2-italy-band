//
//  EndConfirmView.swift
//  ltaylband
//
//  Created by Assistant on 12/20/24.
//

import SwiftUI

struct EndConfirmView: View {
    let onContinue: () -> Void
    let onEnd: () -> Void
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.4)
                .ignoresSafeArea()
                .onTapGesture {
                    onContinue()
                }
            VStack(spacing: 32) {
                VStack(spacing: 16) {
                    Text("집중을 종료하시겠습니까?")
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(.black)
                    
                    VStack(spacing: 8) {
                        Text("돌이 더 춤추고 싶어해요!")
                            .font(.system(size: 16, weight: .medium))
                            .foregroundColor(.gray)
                        
                        Text("돌을 슬프게 하지 말아주세요...")
                            .font(.system(size: 16, weight: .medium))
                            .foregroundColor(.gray)
                    }
                }
                HStack(spacing: 16) {
                  
                    Button(action: onContinue) {
                        Text("이어하기")
                            .font(.system(size: 16, weight: .medium))
                            .foregroundColor(.black)
                            .frame(maxWidth: .infinity)
                            .frame(height: 52)
                            .background(Color.white)
                            .overlay(
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                            )
                            .cornerRadius(12)
                    }
                    Button(action: onEnd) {
                        Text("종료하기")
                            .font(.system(size: 16, weight: .medium))
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .frame(height: 52)
                            .background(Color.gray)
                            .cornerRadius(12)
                    }
                }
            }
            .padding(24)
            .background(Color.white)
            .cornerRadius(16)
            .padding(.horizontal, 32)
        }
    }
}

#Preview {
    EndConfirmView(
        onContinue: { print("이어하기") },
        onEnd: { print("종료하기") }
    )
} 
