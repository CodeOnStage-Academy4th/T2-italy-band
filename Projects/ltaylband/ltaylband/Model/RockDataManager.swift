//
//  RockDataManager.swift
//  ltaylband
//
//  Created by 김재윤 on 8/8/25.
//

import SwiftUI
import SwiftData
import Combine

@MainActor
class RockDataManager: ObservableObject {
    @Published var rocks: [Rock] = []
    private var modelContext: ModelContext
    
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
        loadRocks()
    }
    
    func loadRocks() {
        do {
            let descriptor = FetchDescriptor<Rock>()
            rocks = try modelContext.fetch(descriptor)
            print("📱 Rock 데이터 로드 완료: \(rocks.count)개")
            if rocks.count > 0 {
                print("   - 첫 번째 Rock: spentTime=\(rocks[0].spentTime), skin=\(rocks[0].skin), grade=\(rocks[0].grade)")
            }
        } catch {
            print("❌ Rock 데이터 로드 중 오류: \(error)")
        }
    }
    
    func saveRock(_ rock: Rock) {
        print("💾 Rock 저장 시작: spentTime=\(rock.spentTime), skin=\(rock.skin)")
        modelContext.insert(rock)
        do {
            try modelContext.save()
            print("💾 Rock 저장 성공")
            loadRocks() // 데이터 다시 로드
        } catch {
            print("❌ Rock 저장 중 오류: \(error)")
        }
    }
    
    func updateRockSkin(_ skin: String) {
        print("🎨 스킨 업데이트 시작: \(skin)")
        print("   - 현재 rocks.count: \(rocks.count)")
        
        if let rock = rocks.first {
            print("   - 기존 Rock 발견: spentTime=\(rock.spentTime), 현재 skin=\(rock.skin)")
            rock.skin = skin
            do {
                try modelContext.save()
                print("   - 스킨 저장 성공")
                loadRocks() // 데이터 다시 로드
                print("🎨 스킨 업데이트 완료: \(skin)")
            } catch {
                print("❌ 스킨 업데이트 중 오류: \(error)")
            }
        } else {
            print("   - Rock이 없음, 새로 생성")
            // Rock이 없으면 새로 생성
            let newRock = Rock(
                id: UUID(),
                spentTime: 0,
                grade: .joyakdol,
                skin: skin
            )
            saveRock(newRock)
        }
    }
    
    func updateRockTime(_ additionalSeconds: Int) {
        if let rock = rocks.first {
            rock.spentTime += additionalSeconds
            rock.grade = Grade.from(spentTime: rock.spentTime)
            do {
                try modelContext.save()
                loadRocks() // 데이터 다시 로드
                print("⏰ 시간 업데이트 완료: +\(additionalSeconds)초")
            } catch {
                print("❌ 시간 업데이트 중 오류: \(error)")
            }
        } else {
            // Rock이 없으면 새로 생성
            let newRock = Rock(
                id: UUID(),
                spentTime: additionalSeconds,
                grade: Grade.from(spentTime: additionalSeconds),
                skin: "RockMotion1"
            )
            saveRock(newRock)
        }
    }
    
    var currentRock: Rock? {
        rocks.first
    }
    
    var spentTime: Int {
        currentRock?.spentTime ?? 0
    }
    
    var currentGrade: Grade {
        Grade.from(spentTime: spentTime)
    }
    
    var currentSkin: String {
        currentRock?.skin ?? "RockMotion1"
    }
    
    func updateModelContext(_ newContext: ModelContext) {
        print("🔄 ModelContext 업데이트")
        self.modelContext = newContext
        loadRocks()
    }
}
