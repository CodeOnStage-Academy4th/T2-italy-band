//
//  ContentView.swift
//  ltaylband
//
//  Created by 김재윤 on 8/8/25.
//

import SwiftUI

//TODO: 타이머와 잠금버튼 함께 구현
//TODO: RockView 여기에 들어가야 함.
struct HomeView: View {
    @EnvironmentObject var router: AppRouter
    
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
            
            // LockView로 이동하는 버튼
            Button("Lock View로 이동") {
                router.navigate(to: .lock)
            }
            .buttonStyle(.borderedProminent)
        }
        .padding()
        .navigationTitle("Home")
    }
}

#Preview {
    HomeView()
}
 
