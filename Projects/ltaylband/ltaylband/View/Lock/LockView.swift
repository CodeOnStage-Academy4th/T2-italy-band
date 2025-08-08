//
//  LockView.swift
//  ltaylband
//
//  Created by 김재윤 on 8/8/25.
//

import Combine
import SwiftData
import SwiftUI

struct LockView: View {
    // MARK: - Properties
    let onTimeComplete: (TimeInterval) -> Void

    @State private var dragOffset: CGSize = .zero
    @State private var elapsedTime: TimeInterval = 0
    @State private var isTimerRunning = false
    @State private var timerCancellable: AnyCancellable?
    @State private var showingEndConfirm = false

    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext
    @EnvironmentObject var router: AppRouter

    @Query private var rocks: [Rock]

    // MARK: - Colors
    private let backgroundColor = ColorSet.lockBackground
    private let textColor = ColorSet.lockText


    @State private var currentIndex = 0
    @State private var scale: CGFloat = 1.0
    
    // Get images based on selected skin
    private var images: [String] {
        let skinName = rocks.first?.skin ?? "RockMotion4"
        return (1...10).map { index in
            "\(skinName)/RockMotion\(index)"
        }
    }

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
        .overlay(
            showingEndConfirm
                ? EndConfirmView(
                    onContinue: {
                        showingEndConfirm = false
                        startTimer()
                    },
                    onEnd: {
                        showingEndConfirm = false
                        pauseTimerAndGoToMain()
                    }
                )
                : nil
        )
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
            .jejudoldamFont(size: ._57, weight: .regular)
            .foregroundColor(ColorSet.rock100)
            .tracking(0)
            .multilineTextAlignment(.center)
    }

    @ViewBuilder
    private var rockComponent: some View {
        ZStack {
            Image(images[currentIndex])
                .resizable()
                .scaledToFit()
                .frame(width: 158 * scale, height: 244 * scale)
                .onAppear {
                    Timer.scheduledTimer(withTimeInterval: 0.3, repeats: true) {
                        _ in
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
                .fill(ColorSet.rock200)
                .frame(width: 101, height: 101)
            HStack(spacing: 13) {
                RoundedRectangle(cornerRadius: 20)
                    .fill(ColorSet.rock100)
                    .frame(width: 16, height: 48)

                RoundedRectangle(cornerRadius: 20)
                    .fill(ColorSet.rock100)
                    .frame(width: 16, height: 48)
            }
        }
        .onTapGesture {
            pauseTimer()
            showingEndConfirm = true 
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
        pauseTimer()
        showingEndConfirm = true
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
