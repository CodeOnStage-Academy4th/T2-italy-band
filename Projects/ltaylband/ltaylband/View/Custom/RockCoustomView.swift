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
    @State private var rockManager: RockDataManager?

    @State private var pageIndex: Int = 0
    private let skins: [String] = [
        "RockMotion1","RockMotion2","RockMotion3","RockMotion4","RockMotion5","RockMotion6"
    ]
    
    var body: some View {
        VStack(spacing: 0) {
            TabView(selection: $pageIndex) {
                ForEach(Array(skins.enumerated()), id: \.offset) { idx, skin in
                    SelRock(rock: Rock(id: UUID(), spentTime: 0, grade: .joyakdol, skin: skin))
                        .tag(idx)
                        .padding(.bottom, 43)
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .overlay(
                HStack(spacing: 10) {
                    ForEach(0..<skins.count, id: \.self) { i in
                        Circle()
                            .fill(i == pageIndex ? ColorSet.rock100 : ColorSet.rock50)
                            .frame(width: 10, height: 10)
                    }
                }
                    .padding(.bottom, 100),
                alignment: .bottom
            )
            
            Button {
                applySelectedSkin()
            } label: {
                Text("적용하기")
                    .jejudoldamFont(size: ._26, weight: .regular)
                    .foregroundStyle(Color.black)
                    .frame(maxWidth: .infinity)
                    .frame(height: 39)
                    .padding(.vertical, 9)
                    .background(
                        RoundedRectangle(cornerRadius: 18)
                            .fill(ColorSet.rock100)
                    )
            }
            .padding(.horizontal, 22)
            .padding(.top, 21)
        }
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    router.navigateToRoot()
                } label: {
                    Image(systemName: "chevron.left")
                        .foregroundStyle(ColorSet.black80)
                }
            }
            ToolbarItem(placement: .principal) {
                Text("옷장")
                    .jejudoldamFont(size: ._18, weight: .regular)
                    .foregroundStyle(ColorSet.black80)
            }
        }
        .overlay(
            Divider(),
            alignment: .top
        )
        .onAppear {
            if rockManager == nil {
                rockManager = RockDataManager(modelContext: modelContext)
            } else {
                rockManager?.updateModelContext(modelContext)
            }
        }
    }
    
    private func applySelectedSkin() {
        let selectedSkin = skins[pageIndex]
        rockManager?.updateRockSkin(selectedSkin)
        
        // UI 업데이트를 위해 강제로 새로고침
        DispatchQueue.main.async {
            // 적용 완료 후 메인 화면으로 돌아가기
            router.navigateToRoot()
        }
    }
}





#Preview {
    RockCoustomView()
}
