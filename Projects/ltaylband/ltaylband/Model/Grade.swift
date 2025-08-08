import Foundation

enum Grade: String, CaseIterable, Codable {
    case joyakdol = "조약돌"
    case hawgangam = "화강암"
    case jasujeong = "자수정"
    case emerald = "에메랄드"
    case diamond = "다이아몬드"
}

extension Grade {
    static func from(spentTime: Int) -> Grade {
        switch spentTime {
        case 0..<18000:
            return .joyakdol
        case 18000..<72000:
            return .hawgangam
        case 72000..<144000:
            return .jasujeong
        case 144000..<252000:
            return .emerald
        case 252000..<360000:
            return .diamond
        default:
            return .joyakdol
        }
    }
    
    var backgroundImageName: String {
        switch self {
        case .joyakdol: return "bg_joyakdol"
        case .hawgangam: return "bg_hawgangam"
        case .jasujeong: return "bg_jasujeong"
        case .emerald: return "bg_emerald"
        case .diamond: return "bg_diamond"
        }
    }
}
