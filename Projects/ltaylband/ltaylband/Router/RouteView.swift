import SwiftUI

struct RouteView: View {
    let route: Route
    @ObservedObject var router: AppRouter
    @Environment(\.modelContext) private var modelContext
    
    var body: some View {
        switch route {
        case .home:
            HomeView()
                .environmentObject(router)
                .environment(\.modelContext, modelContext)
        case .rock:
            RockView()
                .environmentObject(router)
                .environment(\.modelContext, modelContext)
        case .rockGrade:
            RockGradeView()
                .environmentObject(router)
                .environment(\.modelContext, modelContext)
                .navigationBarHidden(true)
        case .lock:
            LockView { timeSpent in
            }
            .environmentObject(router)
            .environment(\.modelContext, modelContext)
        case .rockCustom:
            RockCoustomView()
                .environmentObject(router)
                .environment(\.modelContext, modelContext)
        }
    }
} 
