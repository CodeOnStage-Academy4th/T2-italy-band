//
//  RockGradeView.swift
//  ltaylband
//
//  Created by 김재윤 on 8/8/25.
//

import SwiftUI

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
    
    //FIXME: 다이아몬드 다음 레벨이 없어서 남은 시간 계산 처리를 못할 예정(현재는 nil로 반환)
    func remainingHours(from hours: Int) -> Int? {
        guard let next else {
            return nil
        }
        let requiredTime = (next.range.lowerBound / 3600) - hours
        return max(0, requiredTime)
    }
    
}


//TODO: 돌멩이의 등급을 나타나는 뷰
//TODO: Model의 Grade를 이용해서 알아서 불러와서 쓰면 됌.
//TODO: 이거 어디에 넣을지 안정함.
struct RockGradeView: View {
    @State private var spentTime: Int = 36000
    @State private var progress: Float = 0.5
    @State private var rock = Rock(id: UUID(), spentTime: 36000, grade: .hawgangam, skin: "RockMotion1")
    
    private let gradeOrder: [Grade] = [.joyakdol, .hawgangam, .jasujeong, .emerald, .diamond]
    
    var body: some View {
        VStack {
            let hours = rock.spentTime / 3600
            let grade = rock.grade
            let progress = rock.grade.progress(for: rock.spentTime)
            let remaining = rock.grade.remainingHours(from: hours)
            let nextLevel = nextLevelIndex(from: grade)
            
            
            
            Image(systemName: "circle.fill")
                .resizable()
                .frame(width: 131, height: 131)
                .foregroundStyle(.gray)
                .padding(.bottom, 22)
            
            Text(grade.rawValue)
                .font(.system(size: 22))
                .padding(.bottom, 21)
            
            
            ProgressView(value: progress, total: 1.0)
                .progressViewStyle(.linear)
                .tint(.green)
                .padding(.horizontal, 26)
                .padding(.bottom, 22)
            
            if let remain = remaining, let nextLv = nextLevel {
                Text("\(nextLv)번째 스톤까지 \(remain)시간 남음")
                    .font(.system(size: 15))
                    .padding(.bottom, 40)
            } else {
                Text("최고 레벨 달성!")
                    .font(.system(size: 15))
                    .padding(.bottom, 40)
            }
            
                
            Divider()
                .padding(.bottom, 32)
            
            
            levelRow(grade: .joyakdol, title: "Lv1 : 조약돌", rangeText: "0 ~ 5시간")
            levelRow(grade: .hawgangam, title: "Lv2 : 화강암", rangeText: "5 ~ 20시간")
            levelRow(grade: .jasujeong, title: "Lv3 : 자수정", rangeText: "20 ~ 40시간")
            levelRow(grade: .emerald, title: "Lv4 : 에메랄드", rangeText: "40 ~ 70시간")
            levelRow(grade: .diamond, title: "Lv5 : 다이아몬드", rangeText: "70 ~ 100시간")
            
            
        }
        .onChange(of: rock.spentTime) {
        }
        
    }
    
    @ViewBuilder
    private func levelRow(grade: Grade, title: String, rangeText: String) -> some View {
        HStack {
            Image(systemName: "circle.fill")
                .resizable()
                .frame(width: 48, height: 48)
                .foregroundStyle(.gray)
                .padding(.trailing, 24)
            
            VStack(alignment: .leading) {
                Text(title)
                    .font(.system(size: 17))
                
                Text(rangeText)
                    .font(.system(size: 14))
                    .foregroundStyle(.secondary)
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
