//
//  SelRock.swift
//  ltaylband
//
//  Created by Hwnag Seyeon on 8/9/25.
//

import SwiftUI

struct SelRock: View {
    let rock: Rock
    
    var body: some View {
        VStack(spacing: 0) {
            Text(rock.title)
                .font(.system(size: 20))
                .padding(.bottom, 16)

            Text(rock.sup)
                .font(.system(size: 16))
                .padding(.bottom, 40)

            Image(rockSkinInfoList[rock.skin]?.skin ?? rock.skin)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 340, height: 340)
                .padding(.vertical, 20)
                .padding(.bottom, 22)
        }
    }
}

#Preview {
    SelRock(rock: Rock(id: UUID(), spentTime: 0, grade: .joyakdol, skin: "RockMotion1"))
}
