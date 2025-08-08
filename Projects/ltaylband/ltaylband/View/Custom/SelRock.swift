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
                .jejudoldamFont(size: ._20, weight: .regular)
                .foregroundColor(ColorSet.black80)
                .padding(.bottom, 20)

            Text(rock.sup)
                .jejudoldamFont(size: ._16, weight: .regular)
                .foregroundColor(ColorSet.black60)
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
