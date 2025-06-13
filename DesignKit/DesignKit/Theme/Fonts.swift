import SwiftUI

enum AppTextStyle {
    case title, subtitle, body, caption, button

    var font: Font {
        switch self {
        case .title:
            return .system(size: 28, weight: .bold, design: .rounded)
        case .subtitle:
            return .system(size: 22, weight: .semibold, design: .rounded)
        case .body:
            return .system(size: 17, weight: .regular, design: .default)
        case .caption:
            return .system(size: 13, weight: .regular, design: .default)
        case .button:
            return .system(size: 17, weight: .semibold, design: .rounded)
        }
    }
}

extension Text {
    func textStyle(_ style: AppTextStyle) -> some View {
        self.font(style.font)
    }
}
