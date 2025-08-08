//
//  RockCoustomView.swift
//  ltaylband
//
//  Created by 김재윤 on 8/8/25.
//

import SwiftData
import SwiftUI

// TODO: 메인에서 돌멩이 누르면 돌멩이가 커스텀 되도록 하는 뷰
// TODO: 에셋 불러와서 적용되는지 확인.
struct RockCoustomView: View {
    @EnvironmentObject var router: AppRouter
    @Environment(\.modelContext) private var modelContext
    @Query private var rocks: [Rock]

    @State private var pageIndex: Int = 0
    private let skins: [String] = [
        "RockMotion1","RockMotion2","RockMotion3","RockMotion4","RockMotion5","RockMotion6"
    ]
    
    var body: some View {
        VStack(spacing: 0) {
            // Pager
            TabView(selection: $pageIndex) {
                ForEach(Array(skins.enumerated()), id: \.offset) { idx, skin in
                    SelRock(rock: Rock(id: UUID(), spentTime: 0, grade: .joyakdol, skin: skin))
                        .tag(idx)
//                        .padding(.top, 53)
//                        .padding(.bottom, 43) 
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            .frame(maxWidth: .infinity, maxHeight: .infinity)

            // Custom page control dots
            HStack(spacing: 8) {
                ForEach(0..<skins.count, id: \.self) { i in
                    Circle()
                        .fill(i == pageIndex ? Color.green.opacity(0.9) : Color.gray.opacity(0.3))
                        .frame(width: 10, height: 10)
                }
            }
            .padding(.bottom, 16)

            // Apply button
            Button {
                applySelectedSkin()
            } label: {
                Text("적용하기")
                    .foregroundStyle(Color.black)
                    .frame(maxWidth: .infinity)
                    .frame(height: 39)
                    .padding(.vertical, 9)
                    .background(
                        RoundedRectangle(cornerRadius: 18)
                            .fill(Color.gray)
                    )
            }
            .padding(.horizontal, 16)
            .padding(.top, 21)
        }
        .navigationBarTitle("옷장", displayMode: .inline)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    router.navigateToRoot()
                } label: {
                    Image(systemName: "chevron.left")
                        .foregroundColor(.black)
                }
            }
        }
        .overlay(
            Divider(),
            alignment: .top
        )
    }
    
    private func applySelectedSkin() {
        let selectedSkin = skins[pageIndex]
        if let rock = rocks.first {
            rock.skin = selectedSkin
            do { try modelContext.save() } catch { }
        }
    }
}

#Preview {
    RockCoustomView()
}
