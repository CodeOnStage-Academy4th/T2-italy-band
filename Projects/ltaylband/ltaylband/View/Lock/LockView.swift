//
//  LockView.swift
//  ltaylband
//
//  Created by 김재윤 on 8/8/25.
//

import SwiftUI

//TODO: 메인의 잠금 버튼 누르면 나오는 뷰
//TODO: 00:00:00부터 멈춤 누르기 전까지 타이머가 진행되고 정지버튼
//TODO: 정지버튼 누르면 여태까지 진행된 시간 RockModel에 저장
struct LockView: View {
    @EnvironmentObject var router: AppRouter
    
    let images = ["RockMotion1", "RockMotion2", "RockMotion3", "RockMotion4","RockMotion5","RockMotion6","RockMotion7","RockMotion8","RockMotion9","RockMotion10"]  // 연속재생할 이미지 이름들
        @State private var currentIndex = 0                     // 현재 보여줄 이미지 인덱스
        @State private var scale: CGFloat = 1.0                 // 이미지 크기 상태값

        var body: some View {
            Image(images[currentIndex])
                .resizable()
                .scaledToFit()
                .frame(width: 150 * scale, height: 150 * scale)  // 스케일 적용
                .onAppear {
                    Timer.scheduledTimer(withTimeInterval: 0.3, repeats: true) { _ in
                        currentIndex = (currentIndex + 1) % images.count
                        
                        scale += 0.0005
                        
                    }
                }
        }
    
   
}

#Preview {
    LockView()
}
