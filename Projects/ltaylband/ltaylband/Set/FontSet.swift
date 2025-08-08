import SwiftUI

enum FontSet {
    enum Name: String, CaseIterable {
        case system
        case jejudoldam = "EF_jejudoldam"
        
        var displayName: String {
            switch self {
            case .system: return "System"
            case .jejudoldam: return "제주돌담"
            }
        }
    }
    
    enum Size: CGFloat, CaseIterable {
        case _14 = 14
        case _15 = 15
        case _16 = 16
        case _17 = 17
        case _18 = 18
        case _20 = 20
        case _22 = 22
        case _26 = 26
        case _40 = 40
        case _57 = 57
    }
    
    enum Weight: String, CaseIterable {
        case regular = "Regular"
        case medium = "Medium"
        case semibold = "SemiBold"
        case bold = "Bold"
        
        var fontWeight: Font.Weight {
            switch self {
            case .regular: return .regular
            case .medium: return .medium
            case .semibold: return .semibold
            case .bold: return .bold
            }
        }
    }
}

extension FontSet {
        static func font(name: Name, size: Size, weight: Weight) -> Font {
        switch name {
        case .system:
            return .system(size: size.rawValue, weight: weight.fontWeight)
        case .jejudoldam:
         
            return .custom("EF_jejudoldam", size: size.rawValue)
        }
    }
    
    static func jejudoldam(size: Size) -> Font {
        return .custom("EF_jejudoldam", size: size.rawValue)
    }
    
    static func system(size: Size, weight: Weight = .medium) -> Font {
        return font(name: .system, size: size, weight: weight)
    }
}

extension View {
    /// 제주돌담체 폰트 적용
    func jejudoldamFont(size: FontSet.Size, weight: FontSet.Weight = .regular) -> some View {
        self.font(FontSet.jejudoldam(size: size))
    }
}


extension FontSet {
    static var lockTimer: Font {
        jejudoldam(size: ._57)
    }
    
    static var modalTitle: Font {
        jejudoldam(size: ._20)
    }
    
    static var modalContent: Font {
        jejudoldam(size: ._14)
    }
    
    static var buttonText: Font {
        jejudoldam(size: ._16)
    }
}

extension FontSet {
    private struct CustomFont {
        let name: Name
        
        var fileName: String {
            name.rawValue
        }
        var fileExtension: String {
            "ttf"
        }
    }
    
    private static var customFonts: [CustomFont] {
        [CustomFont(name: .jejudoldam)]
    }
    
    static func registerFonts() {
        customFonts.forEach { font in
            registerFont(font)
        }
    }
    
    private static func registerFont(_ customFont: CustomFont) {
      
        if let fontURL = Bundle.main.url(forResource: "EF_jejudoldam(TTF)", withExtension: "ttf") {
            registerFontFromURL(fontURL, name: "EF_jejudoldam(TTF)")
        }
        if let fontURL = Bundle.main.url(forResource: "EF_jejudoldam(OTF)", withExtension: "otf") {
            registerFontFromURL(fontURL, name: "EF_jejudoldam(OTF)")
        }
        if let fontURL = Bundle.main.url(forResource: "EF_jejudoldam", withExtension: "ttf") {
            registerFontFromURL(fontURL, name: "EF_jejudoldam")
        }
    }
    
    private static func registerFontFromURL(_ fontURL: URL, name: String) {
        guard let fontDataProvider = CGDataProvider(url: fontURL as CFURL),
              let cgFont = CGFont(fontDataProvider) else {
            debugPrint("Failed to create font from: \(name)")
            return
        }
        
        var error: Unmanaged<CFError>?
        if !CTFontManagerRegisterGraphicsFont(cgFont, &error) {
            if let error = error?.takeRetainedValue() {
                debugPrint("Font registration failed for \(name): \(error)")
            }
        } else {
            if let postScriptName = cgFont.postScriptName {
                debugPrint("   PostScript Name: \(postScriptName)")
            }
        }
    }
} 
