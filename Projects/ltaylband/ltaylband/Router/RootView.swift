//
//  RootView.swift
//  ltaylband
//
//  Created by 김재윤 on 8/8/25.
//

import SwiftUI
import SwiftData

// MARK: - RootView
// 앱의 메인 네비게이션 컨테이너
// NavigationStack을 사용하여 화면 간 이동을 관리
// 모든 하위 뷰에 router를 environmentObject로 주입
struct RootView: View {
    // Router 인스턴스를 생성하고 상태로 관리
    @StateObject private var router = AppRouter()
    @Environment(\.modelContext) private var modelContext
    
    var body: some View {
        NavigationStack(path: $router.path) {
            // 시작 화면 (HomeView)
            HomeView()
                .environmentObject(router)
                // Route enum에 정의된 화면들로 이동할 때 사용할 destination
                .navigationDestination(for: Route.self) { route in
                    RouteView(route: route, router: router)
                }
        }
        .onAppear {
            initializeDefaultRock()
        }
    }
    
    private func initializeDefaultRock() {
        print("🎯 앱 시작 - 기본 Rock 데이터 초기화")
        do {
            let descriptor = FetchDescriptor<Rock>()
            let existingRocks = try modelContext.fetch(descriptor)
            
            if existingRocks.isEmpty {
                let defaultRock = Rock(
                    id: UUID(),
                    spentTime: 0,
                    grade: .joyakdol,
                    skin: "RockMotion1"
                )
                modelContext.insert(defaultRock)
                try modelContext.save()
                print("🎯 기본 Rock 데이터 생성 완료: spentTime=0, skin=RockMotion1")
            } else {
                print("🎯 기존 Rock 데이터 발견: \(existingRocks.count)개")
                for (index, rock) in existingRocks.enumerated() {
                    print("   - Rock \(index): spentTime=\(rock.spentTime), skin=\(rock.skin)")
                }
            }
        } catch {
            print("❌ Rock 데이터 초기화 중 오류: \(error)")
        }
    }
}

// MARK: - Route Identifiable Extension
// Route를 Identifiable로 만들어서 SwiftUI에서 사용할 수 있도록 함
// (현재는 NavigationStack에서 사용하지 않지만, 향후 확장성을 위해 유지)
extension Route: Identifiable {
    var id: String {
        switch self {
        case .home:
            return "home"
        case .rock:
            return "rock"
        case .rockGrade:
            return "rockGrade"
        case .lock:
            return "lock"
        case .rockCustom:
            return "rockCustom"
        }
    }
} 