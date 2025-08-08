//
//  AppRouter.swift
//  ltaylband
//
//  Created by 김재윤 on 8/8/25.
//

import SwiftUI

// MARK: - Route Enum
// 앱의 모든 화면을 여기에 정의합니다.
// 새로운 화면을 추가할 때는 이 enum에 case를 추가하고 RouteView에서도 처리해야 합니다.
enum Route: Hashable {
    case home
    case rock
    case rockGrade
    case lock
    case rockCustom
}

// MARK: - AppRouter
// SwiftUI에서 화면 간 이동을 관리하는 Router 클래스
// @MainActor: UI 업데이트는 메인 스레드에서만 실행되도록 보장
// ObservableObject: SwiftUI 뷰가 상태 변화를 감지할 수 있도록 함
@MainActor
class AppRouter: ObservableObject {
    // NavigationStack에서 사용할 경로 스택
    @Published var path = NavigationPath()
    
    // MARK: - Navigation Methods
    
    /// 특정 화면으로 이동합니다.
    /// - Parameter route: 이동할 화면
    /// 사용법: router.navigate(to: .rock)
    func navigate(to route: Route) {
        path.append(route)
    }
    
    /// 이전 화면으로 돌아갑니다.
    /// 사용법: router.navigateBack()
    func navigateBack() {
        if !path.isEmpty {
            path.removeLast()
        }
    }
    
    /// 홈 화면으로 돌아갑니다 (스택을 모두 비움).
    /// 사용법: router.navigateToRoot()
    func navigateToRoot() {
        path.removeLast(path.count)
    }
    
    /// 특정 화면으로 이동하되, 현재 스택을 모두 비우고 이동합니다.
    /// - Parameter route: 이동할 화면
    /// 사용법: router.navigateToRootAndThen(to: .rock)
    func navigateToRootAndThen(to route: Route) {
        path.removeLast(path.count)
        path.append(route)
    }
} 