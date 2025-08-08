//
//  ltaylbandApp.swift
//  ltaylband
//
//  Created by 김재윤 on 8/8/25.
//

import SwiftUI
import SwiftData
import UIKit

@main
struct Main: App {
    
    init() {
        print("🎯 Starting font registration...")
        FontSet.registerFonts()
        print("🎯 Font registration completed")
        
        // 등록된 폰트 확인
        print("📱 Available fonts:")
        for family in UIFont.familyNames.sorted() {
            if family.contains("EF") || family.contains("jejudoldam") {
                print("   - \(family)")
                for font in UIFont.fontNames(forFamilyName: family) {
                    print("     * \(font)")
                }
            }
        }
    }
    
    var body: some Scene {
        WindowGroup {
            RootView()
        }
        .modelContainer(createInMemoryModelContainer())
    }
    
    private func createInMemoryModelContainer() -> ModelContainer {
        do {
            let schema = Schema([Rock.self])
            let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: true)
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }
}
