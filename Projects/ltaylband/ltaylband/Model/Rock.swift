import Foundation
import SwiftData

struct RockSkinInfo {
    let skin: String
    let title: String
    let sup: String
}

let rockSkinInfoList: [String: RockSkinInfo] = [
    "RockMotion1": RockSkinInfo(
        skin: "RockMotion1/RockMotion1",
        title: "초또로",
        sup: "이탈리아 출신의 깔끔하고 담백한 매력덩어리 돌"
    ),
    "RockMotion2": RockSkinInfo(
        skin: "RockMotion2/RockMotion1",
        title: "죄수돌",
        sup: "산만함을 훔쳐가는 죄수돌!"
    ),
    "RockMotion3": RockSkinInfo(
        skin: "RockMotion3/RockMotion1",
        title: "돌인블랙",
        sup: "외계 생명체로부터 세상을 지키는 비밀요원 돌"
    ),
    "RockMotion4": RockSkinInfo(
        skin: "RockMotion4/RockMotion1",
        title: "군도리",
        sup: "안전함을 보장하고 충성을 다하는 군돌"
    ),
    "RockMotion5": RockSkinInfo(
        skin: "RockMotion5/RockMotion1",
        title: "꿀빠리",
        sup: "나는 더이상 돌이 아니다. 행복을 위해 벌이된 돌"
    ),
    "RockMotion6": RockSkinInfo(
        skin: "RockMotion6/RockMotion1",
        title: "싼트아돌",
        sup: "집중력을 선물하러 온 산타돌"
    )
]

@Model
final class Rock: Identifiable {
    var id: UUID
    var spentTime: Int
    var grade: Grade
    var skin: String
    
    var title: String {
        rockSkinInfoList[skin]?.title ?? ""
    }
    
    var sup: String {
        rockSkinInfoList[skin]?.sup ?? ""
    }
    
    init(
        id: UUID,
        spentTime: Int,
        grade: Grade,
        skin: String
    ) {
        self.id = id
        self.spentTime = spentTime
        self.grade = grade
        self.skin = skin
    }
}
