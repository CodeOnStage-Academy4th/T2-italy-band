//
//  RockCoustomView.swift
//  ltaylband
//
//  Created by 김재윤 on 8/8/25.
//

import SwiftUI

// TODO: 메인에서 돌멩이 누르면 돌멩이가 커스텀 되도록 하는 뷰
// TODO: 에셋 불러와서 적용되는지 확인.
struct RockCoustomView: View {
    var body: some View {
        VStack(spacing: 0) {
            Circle()
                .fill(Color.gray)
                .frame(width: 130, height: 130)
                .padding(.top, 53)
                .padding(.bottom, 43)
            
            ZStack(alignment: .topLeading) {
                RoundedRectangle(cornerRadius: 20)
                    .stroke(Color.gray, lineWidth: 1)
                    .frame(width: .infinity, height: .infinity)
                    .padding(.horizontal, 21)
                
                VStack {
                    ZStack{
                        Rectangle()
                            .fill(Color.gray)
                            .frame(width: .infinity, height: 57)
                            .cornerRadius(15)
                            .padding(.horizontal, 36)
                        
                        HStack(spacing: 36) {
                            ForEach(0 ..< 4) { _ in
                                Circle()
                                    .fill(Color.red)
                                    .frame(width: 43, height: 43)
                            }
                        }
                        
                    }
                    .padding(.top, 15)
                    .padding(.bottom, 49)
                    
                    ForEach(0 ..< 3) { _ in
                        HStack(spacing: 36) {
                            ForEach(0 ..< 3) { _ in
                                Circle()
                                    .fill(Color.red)
                                    .frame(width: 70, height: 70)
                            }
                        }
                        .padding(.bottom, 39)
                    }
                    
                }
            }
            
            Spacer()
        }
    }
}

#Preview {
    RockCoustomView()
}
