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
    
    var currentGrade: Grade {
        Grade.from(spentTime: spentTime)
    }
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 40) {
            HStack(spacing: 10) {
                Image(gradeIconName(for: currentGrade))
                    .resizable()
                    .frame(width: 32, height: 32)
                
                Text(formatTimeHMS(spentTime))
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.primary)
                
                Spacer()
            }
            .padding(.top, 60)
            .padding(.leading, 80)
            
            Spacer()
            
            ZStack {
                Circle()
                    .fill(Color.gray.opacity(0.1))
                    .stroke(Color.gray.opacity(0.3), lineWidth: 2)
                    .frame(width: 300, height: 300)
            }
            
            Spacer()
            
            Button(action: {
                isShowingLockView = true
            }) {
                Text("집중하기")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 18)
                    .background(
                        RoundedRectangle(cornerRadius: 16)
                            .fill(Color(red: 179/255, green: 202/255, blue: 41/255))
                            .shadow(color: Color(red: 179/255, green: 202/255, blue: 41/255).opacity(0.3), 
                                   radius: 8, x: 0, y: 4)
                    )
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
 
