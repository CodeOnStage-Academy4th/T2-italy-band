//
//  ContentView.swift
//  ltaylband
//
//  Created by 김재윤 on 8/8/25.
//

import SwiftUI
import SwiftData

struct HomeView: View {

    @Query private var rocks: [Rock]
    @State private var isShowingLockView = false
    
    private var spentTime: Int {
        rocks.first?.spentTime ?? 0
    }
    @EnvironmentObject var router: AppRouter
    
    var currentGrade: Grade {
        Grade.from(spentTime: spentTime)
    }
    
    @State private var currentIndex = 0
    @State private var scale: CGFloat = 1.0
    
    private var images: [String] {
        let skinName = rocks.first?.skin ?? "RockMotion1"
        return ["\(skinName)/RockMotion1"]
    }
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 40) {
            HStack(spacing: 10) {
                Image(gradeIconName(for: currentGrade))
                    .resizable()
                    .frame(width: 32, height: 32)
                
                Text(formatTimeHMS(spentTime))
                    .jejudoldamFont(size: ._26, weight: .regular)
                    .fontWeight(.bold)
                    .foregroundColor(ColorSet.black80)
                
                Spacer()
            }
            .padding(.top, 60)
            .padding(.leading, 80)
            
            Spacer()
            ZStack {
                Image(images[currentIndex])
                      .resizable()
                      .scaledToFit()
                      .frame(width: 158 * scale, height: 244 * scale)
                      .onAppear {
                          Timer.scheduledTimer(withTimeInterval: 0.3, repeats: true) { _ in
                              currentIndex = (currentIndex + 1) % images.count
                              scale += 0.0005
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
            }
            .padding(.horizontal, 8)
            .padding(.bottom, 40)
            }
            .padding()
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
        case .joyakdol: return "icon_joyakdol"
        case .hawgangam: return "icon_hawgangam"
        case .jasujeong: return "icon_jasujeong"
        case .emerald: return "icon_emerald"
        case .diamond: return "icon_diamond"
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
    
}

#Preview {
    HomeView()
}
 
