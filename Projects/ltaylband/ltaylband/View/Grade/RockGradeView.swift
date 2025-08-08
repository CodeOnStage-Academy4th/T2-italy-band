//
//  RockGradeView.swift
//  ltaylband
//
//  Created by 김재윤 on 8/8/25.
//

import SwiftUI
import SwiftData

extension Grade {
    var range: Range<Int> {
        switch self {
        case .joyakdol:
            return 0..<18000
        case .hawgangam:
            return 18000..<72000
        case .jasujeong:
            return 72000..<144000
        case .emerald:
            return 144000..<252000
        case .diamond:
            return 252000..<360000
        }
    }
    
    var imageName: String {
        switch self {
        case .joyakdol:
            return "joyakdolImage"
        case .hawgangam:
            return "hawgangamImage"
        case .jasujeong:
            return "jasujeongImage"
        case .emerald:
            return "emeraldImage"
        case .diamond:
            return "diamondImage"
        }
    }
    
    
    var next: Grade? {
        switch self {
        case .joyakdol:
            return .hawgangam
        case .hawgangam:
            return .jasujeong
        case .jasujeong:
            return .emerald
        case .emerald:
            return .diamond
        case .diamond:
            return nil
        }
    }
    
    func progress(for seconds: Int) -> Double {
        let lower = range.lowerBound
        let upper = range.upperBound
        
        let progressRate = Double(seconds - lower) / Double(upper - lower)
        
        return min(max(progressRate, 0.0), 1.0)
    }
    
    func remainingHours(from hours: Int) -> Int? {
        guard let next else {
            return nil
        }
        let requiredTime = (next.range.lowerBound / 3600) - hours
        return max(0, requiredTime)
    }
    
}


struct RockGradeView: View {
    
    @Query private var rocks: [Rock]
    @EnvironmentObject var router: AppRouter
    
    private var currentRock: Rock? {
        rocks.first
    }
    
    private let gradeOrder: [Grade] = [.joyakdol, .hawgangam, .jasujeong, .emerald, .diamond]
    
    var body: some View {
        NavigationView {
            VStack {
                let seconds = currentRock?.spentTime ?? 0
            let hours = seconds / 3600
            let grade = Grade.from(spentTime: seconds)
            let progress = grade.progress(for: seconds)
            let remaining = grade.remainingHours(from: hours)
            let nextLevel = nextLevelIndex(from: grade)
            
            
            
            Image(grade.imageName)
                .resizable()
                .frame(width: 129, height: 129)
                .padding(.bottom, 22)
            
            Text(grade.rawValue)
                .jejudoldamFont(size: ._22)
                .foregroundStyle(.black80)
                .padding(.bottom, 21)
            
            ProgressView(value: progress, total: 1.0)
                .progressViewStyle(.linear)
                .tint(.rook100)
                .padding(.horizontal, 26)
                .padding(.bottom, 22)
            
            if let remain = remaining, let nextLv = nextLevel {
                Text("\(nextLv)번째 스톤까지 \(remain)시간 남음")
                    .jejudoldamFont(size: ._15)
                    .foregroundStyle(.black70)
                    .padding(.bottom, 40)
            } else {
                Text("당신은 모든 돌을 수집하였습니다.")
                    .jejudoldamFont(size: ._15)
                    .foregroundStyle(.black70)
                    .padding(.bottom, 40)
            }
            
                
            Divider()
                .padding(.bottom, 32)
            
            
            levelRow(grade: .joyakdol, title: "Lv1 : 조약돌", rangeText: "0 ~ 4시간")
            levelRow(grade: .hawgangam, title: "Lv2 : 화강암", rangeText: "5 ~ 19시간")
            levelRow(grade: .jasujeong, title: "Lv3 : 자수정", rangeText: "20 ~ 39시간")
            levelRow(grade: .emerald, title: "Lv4 : 에메랄드", rangeText: "40 ~ 69시간")
            levelRow(grade: .diamond, title: "Lv5 : 다이아몬드", rangeText: "70 ~ 100시간")
            
            
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    router.navigateBack()
                } label: {
                    Image(systemName: "chevron.left")
                        .foregroundColor(.black)
                        .font(.system(size: 18, weight: .medium))
                }
            }
        }
        }
    }
    
    @ViewBuilder
    private func levelRow(grade: Grade, title: String, rangeText: String) -> some View {
        HStack {
            Image(grade.imageName)
                .resizable()
                .frame(width: 50, height: 50)
                .padding(.trailing, 24)
            
            VStack(alignment: .leading) {
                Text(title)
                    .jejudoldamFont(size: ._17)
                    .foregroundStyle(.black80)
                    .padding(.bottom, 4)
                
                Text(rangeText)
                    .jejudoldamFont(size: ._14)
                    .foregroundStyle(.black60)
            }
            
            Spacer()
        }
        .padding(.leading, 60)
        .padding(.bottom, 22)
    }
    
    private func nextLevelIndex(from grade: Grade) -> Int? {
        guard let idx = gradeOrder.firstIndex(of: grade), idx + 1 < gradeOrder.count else { return nil
        }
        return idx + 2
    }
    
}

#Preview {
    RockGradeView()
}
