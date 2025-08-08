import SwiftUI

enum Route: Hashable {
    case home
    case rock
    case rockGrade
    case lock
    case rockCustom
}

@MainActor
class AppRouter: ObservableObject {
    @Published var path = NavigationPath()
    
    func navigate(to route: Route) {
        path.append(route)
    }
    
    func navigateBack() {
        if !path.isEmpty {
            path.removeLast()
        }
    }
    
    func navigateToRoot() {
        path.removeLast(path.count)
    }
    
    func navigateToRootAndThen(to route: Route) {
        path.removeLast(path.count)
        path.append(route)
    }
} 