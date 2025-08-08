//
//  LockView.swift
//  ltaylband
//
//  Created by 김재윤 on 8/8/25.
//

import SwiftUI

//TODO: 정지버튼 누르면 여태까지 진행된 시간 RockModel에 저장
struct LockView: View {
    // MARK: - Properties
    @State private var dragOffset: CGSize = .zero
    @State private var elapsedTime: TimeInterval = 0
    @State private var isTimerRunning = false
    @State private var timer: Timer?
    @Environment(\.dismiss) private var dismiss
    
    // MARK: - Colors
    private let backgroundColor = Color(red: 0x1D/255.0, green: 0x1D/255.0, blue: 0x1D/255.0)
    private let textColor = Color.white
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                backgroundColor
                    .ignoresSafeArea(.all)
                VStack(spacing: 0) {
                    Spacer()
                        .frame(height: geometry.size.height * 0.1)
                    timerComponent
                    Spacer()
                        .frame(height: geometry.size.height * 0.08)
                    rockComponent
                    Spacer()
                        .frame(height: geometry.size.height * 0.08)
                    pauseButtonComponent
                    Spacer()
                }
            }
        }
        .onAppear {
            startTimer()
        }
        .onDisappear {
            timer?.invalidate()
            timer = nil
        }
    }
    
    // MARK: - Components
    @ViewBuilder
    private var timerComponent: some View {
        Text(formattedTime)
            .font(.system(size: 57, weight: .semibold, design: .default))
            .foregroundColor(textColor)
            .tracking(0)
            .multilineTextAlignment(.center)
    }
    
    @ViewBuilder
    private var rockComponent: some View {
        ZStack {
            Image("rock_image")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 320, height: 320)
                .clipShape(Ellipse())
                .offset(dragOffset)
                .gesture(
                    DragGesture()
                        .onChanged { value in
                            dragOffset = value.translation
                        }
                        .onEnded { value in
                            if abs(value.translation.height) > 100 {
                                handleUnlock()
                            } else {
                                withAnimation(.spring(response: 0.6, dampingFraction: 0.8)) {
                                    dragOffset = .zero
                                }
                            }
                        }
                )
        }
    }
    
    @ViewBuilder
    private var pauseButtonComponent: some View {
        ZStack {
            Circle()
                .fill(Color.gray.opacity(0.3))
                .frame(width: 101, height: 101)
            HStack(spacing: 13) {
                RoundedRectangle(cornerRadius: 20)
                    .fill(textColor)
                    .frame(width: 16, height: 48)
                
                RoundedRectangle(cornerRadius: 20)
                    .fill(textColor)
                    .frame(width: 16, height: 48)
            }
        }
        .onTapGesture {
            pauseTimerAndGoToMain()
        }
    }
    private var formattedTime: String {
        let hours = Int(elapsedTime) / 3600
        let minutes = (Int(elapsedTime) % 3600) / 60
        let seconds = Int(elapsedTime) % 60
        return String(format: "%02d:%02d:%02d", hours, minutes, seconds)
    }
    private func handleUnlock() {
        withAnimation(.easeInOut(duration: 0.3)) {
            dragOffset = .zero
        }
        pauseTimerAndGoToMain()
    }
    
    private func startTimer() {
        isTimerRunning = true
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            elapsedTime += 1
        }
    }
    
    private func pauseTimer() {
        isTimerRunning = false
        timer?.invalidate()
        timer = nil
    }
    
    private func pauseTimerAndGoToMain() {
        pauseTimer()
        
        // MARK: 시간을 RockModel에 저장하는 로직 추가
        print("저장된 시간: \(formattedTime) (\(elapsedTime)초)")
        dismiss()
    }
}

#Preview {
    LockView()
}
