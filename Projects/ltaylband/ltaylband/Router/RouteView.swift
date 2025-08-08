//
//  RouteView.swift
//  ltaylband
//
//  Created by 김재윤 on 8/8/25.
//

import SwiftUI

// MARK: - RouteView
// Route enum에 따라 적절한 뷰를 반환하는 스위처 뷰
// 새로운 화면을 추가할 때는:
// 1. Route enum에 case 추가
// 2. 이 switch문에 case 추가
// 3. 해당 뷰에 @EnvironmentObject var router: AppRouter 추가
struct RouteView: View {
    let route: Route
    @ObservedObject var router: AppRouter
    
    var body: some View {
        switch route {
        case .home:
            HomeView()
                .environmentObject(router)
        case .rock:
            RockView()
                .environmentObject(router)
        case .rockGrade:
            RockGradeView()
                .environmentObject(router)
        case .lock:
            LockView()
                .environmentObject(router)
        case .rockCustom:
            RockCoustomView()
                .environmentObject(router)
        }
    }
} 