import SwiftUI
import SwiftData

struct RootView: View {
    @StateObject private var router = AppRouter()
    @Environment(\.modelContext) private var modelContext
    
    var body: some View {
        NavigationStack(path: $router.path) {
            HomeView()
                .environmentObject(router)
                .navigationDestination(for: Route.self) { route in
                    RouteView(route: route, router: router)
                }
        }
        .onAppear {
            initializeDefaultRock()
        }
    }
    
    private func initializeDefaultRock() {
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
            } else {
                print("기존 Rock 데이터 발견: \(existingRocks.count)개")
                for (index, rock) in existingRocks.enumerated() {
                    print("   - Rock \(index): spentTime=\(rock.spentTime), skin=\(rock.skin)")
                }
            }
        } catch {
            print("Rock 데이터 초기화 중 오류: \(error)")
        }
    }
}

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
