//
//  ContentView.swift
//  ltaylband
//
//  Created by 김재윤 on 8/8/25.
//

import SwiftUI
import SwiftData

struct HomeView: View {

    @Environment(\.modelContext) private var modelContext
    @State private var isShowingLockView = false
    @State private var rockManager: RockDataManager?
    
    @EnvironmentObject var router: AppRouter
    
    @State private var currentIndex = 0
    @State private var scale: CGFloat = 1.0
    
    private var images: [String] {
        let skinName = rockManager?.currentSkin ?? "RockMotion1"
        return ["\(skinName)/RockMotion1"]
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                Image(backgroundImageName(for: rockManager?.currentGrade ?? .joyakdol))
                    .resizable()
                    .ignoresSafeArea(.all)
                
                VStack(spacing: 40) {
            VStack(spacing: 10) {
                Button {
                    router.navigate(to: .rockGrade)
                } label: {
                    Image(gradeIconName(for: rockManager?.currentGrade ?? .joyakdol))
                        .resizable()
                        .frame(width: 42, height: 42)
                }
                
                Text(formatTimeHMS(rockManager?.spentTime ?? 0))
                    .jejudoldamFont(size: ._26, weight: .regular)
                    .fontWeight(.bold)
                    .foregroundColor(ColorSet.black80)
            }
            .padding(.top, 60)
            .onAppear {
                // 실제 ModelContext로 RockDataManager 업데이트
                updateRockManager()
            }
            
            Spacer()
            ZStack {
                Button {
                    router.navigate(to: .rockCustom)
                } label: {
                    Image(images[currentIndex])
                          .resizable()
                          .scaledToFit()
                          .frame(width: 158 * scale, height: 244 * scale)
                          .onAppear {
                              Timer.scheduledTimer(withTimeInterval: 0.3, repeats: true) { _ in
                                  currentIndex = (currentIndex + 1) % images.count
                              }
                          }
                }

            }
            
            Spacer()
          
            Button(action: {
                isShowingLockView = true
            }) {
                Text("집중하기")
                    .jejudoldamFont(size: ._22, weight: .regular)
                    .fontWeight(.bold)
                    .foregroundColor(ColorSet.black80)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 18)
                    .background(ColorSet.rock100)
                    .cornerRadius(25)
            }
            .padding(.horizontal, 8)
            .padding(.bottom, 40)
                }
                .padding()
            }
        }
        .fullScreenCover(isPresented: $isShowingLockView) {
            LockView { _ in
            }
        }
    }
          
    private func formatTimeHMS(_ seconds: Int) -> String {
        let hours = seconds / 3600
        let minutes = (seconds % 3600) / 60
        let secs = seconds % 60
        return String(format: "%02d:%02d:%02d", hours, minutes, secs)
    }
    
    private func gradeIconName(for grade: Grade) -> String {
        switch grade {
        case .joyakdol: return "joyakdolImage"
        case .hawgangam: return "hawgangamImage"
        case .jasujeong: return "jasujeongImage"
        case .emerald: return "emeraldImage"
        case .diamond: return "diamondImage"
        }
    }
    
    private func gradeColor(for grade: Grade) -> Color {
        switch grade {
        case .joyakdol: return .gray
        case .hawgangam: return .brown
        case .jasujeong: return .purple
        case .emerald: return .green
        case .diamond: return .cyan
        }
    }
    
    private func backgroundImageName(for grade: Grade) -> String {
        switch grade {
        case .joyakdol: return "joyakdolBackground"
        case .hawgangam: return "hawgangamBackground"
        case .jasujeong: return "jasujeongBackground"
        case .emerald: return "emeraldBackground"
        case .diamond: return "diamondBackground"
        }
    }
    
    private func updateRockManager() {
        if rockManager == nil {
            rockManager = RockDataManager(modelContext: modelContext)
        } else {
            rockManager?.updateModelContext(modelContext)
        }
    }
    
}

#Preview {
    HomeView()
}
 
