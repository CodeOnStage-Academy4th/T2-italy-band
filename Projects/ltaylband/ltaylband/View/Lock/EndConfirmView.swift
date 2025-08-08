//
//  EndConfirmView.swift
//  ltaylband
//
//  Created by 광로 on 12/20/24.
//

import SwiftUI

// 디버깅: 색상 테스트
private func testColors() {
    print("🎨 색상 테스트:")
    print("  - ColorSet.rock100: \(ColorSet.rock100)")
    print("  - Color(\"Rook100\"): \(Color("Rook100"))")
    print("  - 직접 RGB: \(Color(red: 0.702, green: 0.792, blue: 0.161))")
    print("  - Color.gray: \(Color.gray)")
}

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
                        .jejudoldamFont(size: ._20, weight: .regular)
                        .foregroundColor(ColorSet.black80)

                    VStack(spacing: 8) {
                        Text("돌이 더 춤추고 싶어해요!")
                            .jejudoldamFont(size: ._14, weight: .regular)
                            .foregroundColor(ColorSet.black60)

                        Text("돌을 슬프게 하지 말아주세요...")
                            .jejudoldamFont(size: ._14, weight: .regular)
                            .foregroundColor(ColorSet.black60)
                    }
                }
                HStack(spacing: 16) {
                    // 이어하기 버튼 (흰색 배경, 검은색 텍스트, 회색 테두리)
                    Button(action: onContinue) {
                        Text("이어하기")
                            .jejudoldamFont(size: ._16, weight: .regular)
                            .foregroundColor(ColorSet.black70)
                            .frame(maxWidth: .infinity)
                            .frame(height: 52)
                            .background(Color.white)
                            .overlay(
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(Color.gray.opacity(0.5), lineWidth: 1)
                            )
                            .cornerRadius(12)
                    }
                    
                    // 종료하기 버튼 (회색 배경, 흰색 텍스트)
                    Button(action: onEnd) {
                        Text("종료하기")
                            .jejudoldamFont(size: ._16, weight: .regular)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .frame(height: 52)
                            .background(ColorSet.rock100)
                            .cornerRadius(12)
                    }
                }
            }
            .padding(24)
            .background(Color.white)
            .cornerRadius(16)
            .padding(.horizontal, 32)
        }
        .onAppear {
            testColors()
        }
    }
}

#Preview {
    EndConfirmView(
        onContinue: { print("이어하기") },
        onEnd: { print("종료하기") }
    )
}
