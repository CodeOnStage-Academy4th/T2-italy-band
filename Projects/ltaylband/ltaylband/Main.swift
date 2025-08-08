//
//  ltaylbandApp.swift
//  ltaylband
//
//  Created by 김재윤 on 8/8/25.
//

import SwiftUI
import SwiftData

@main
struct Main: App {
    var body: some Scene {
        WindowGroup {
            HomeView()
        }
        .modelContainer(for: Rock.self)
    }
}
