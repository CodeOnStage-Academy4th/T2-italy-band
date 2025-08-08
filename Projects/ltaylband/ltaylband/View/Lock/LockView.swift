//
//  LockView.swift
//  ltaylband
//
//  Created by 김재윤 on 8/8/25.
//

import SwiftUI
import SwiftData
import Combine

struct LockView: View {
    // MARK: - Properties
    let onTimeComplete: (TimeInterval) -> Void
    
    @State private var dragOffset: CGSize = .zero
    @State private var elapsedTime: TimeInterval = 0
    @State private var isTimerRunning = false
    @State private var timerCancellable: AnyCancellable?
    
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext
    @EnvironmentObject var router: AppRouter
    
    @Query private var rocks: [Rock]
    
    // MARK: - Colors
    private let backgroundColor = Color(red: 0x1D/255.0, green: 0x1D/255.0, blue: 0x1D/255.0)
    private let textColor = Color.white

    let images = ["RockMotion1", "RockMotion2", "RockMotion3", "RockMotion4","RockMotion5","RockMotion6","RockMotion7","RockMotion8","RockMotion9","RockMotion10"]
        @State private var currentIndex = 0
        @State private var scale: CGFloat = 1.0

    
    var body: some View {
        ZStack {
            backgroundColor
                .ignoresSafeArea(.all)
            
            VStack(spacing: 0) {
                Spacer()
                    .frame(height: 0)
                timerComponent
                Spacer()
                    .frame(height: 120)
                rockComponent
                Spacer()
                    .frame(height: 90)
                pauseButtonComponent
            }
        }
        .onAppear {
            startTimer()
        }
        .onDisappear {
            stopTimer()
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
          Image(images[currentIndex])
                .resizable()
                .scaledToFit()
                .frame(width: 150 * scale, height: 150 * scale)  // 스케일 적용
                .onAppear {
                    Timer.scheduledTimer(withTimeInterval: 0.3, repeats: true) { _ in
                        currentIndex = (currentIndex + 1) % images.count
                        
                        scale += 0.0005
                        
                    }
                }
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
        guard !isTimerRunning else { return }
        
        isTimerRunning = true
        timerCancellable = Timer.publish(every: 1.0, on: .main, in: .common)
            .autoconnect()
            .sink { _ in
                elapsedTime += 1
            }
    }
    
    private func stopTimer() {
        isTimerRunning = false
        timerCancellable?.cancel()
        timerCancellable = nil
    }
    
    private func pauseTimer() {
        stopTimer()
    }
    
    private func pauseTimerAndGoToMain() {
        pauseTimer()
        saveTimeToRock()
        onTimeComplete(elapsedTime)
        dismiss()
    }
    
    private func saveTimeToRock() {
        let additionalSeconds = Int(elapsedTime)
        
        if let existingRock = rocks.first {
            
            existingRock.spentTime += additionalSeconds
            existingRock.grade = Grade.from(spentTime: existingRock.spentTime)
        } else {
            let newRock = Rock(
                id: UUID(),
                spentTime: additionalSeconds,
                grade: Grade.from(spentTime: additionalSeconds),
                skin: "RockMotion1"
            )
            modelContext.insert(newRock)
        }
        do {
            try modelContext.save()
        
        } catch {
        }
    }
}

#Preview {
    LockView { _ in
    }
}
