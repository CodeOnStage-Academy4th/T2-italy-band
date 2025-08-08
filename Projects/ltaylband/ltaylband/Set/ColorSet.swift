//
//  ColorSet.swift
//  ltaylband
//
//  Created by 광로 on 12/20/24.
//

import SwiftUI

enum ColorSet {
    // MARK: - Black Colors (Color.xcassets 기반)
    static var black50: Color { Color("Black50") }
    static var black60: Color { Color("Black60") }
    static var black70: Color { Color("Black70") }
    static var black75: Color { Color("Black75") }
    static var black80: Color { Color("Black80") }
    
    // MARK: - Rock Colors (Color.xcassets 기반)
    static var rock50: Color { Color("Rock50") }
    static var rock100: Color { Color("Rook100") }
    static var rock200: Color { Color("Rock200") }
}

// MARK: - LockView 전용 컬러들
extension ColorSet {
    static var lockBackground: Color { Color(red: 0x49/255.0, green: 0x49/255.0, blue: 0x49/255.0) }
    static var lockText: Color { .white }
    static var timerGreen: Color { Color(red: 0xB3/255.0, green: 0xCA/255.0, blue: 0x29/255.0) }
    static var pauseButtonBackground: Color { Color.gray.opacity(0.3) }
}
