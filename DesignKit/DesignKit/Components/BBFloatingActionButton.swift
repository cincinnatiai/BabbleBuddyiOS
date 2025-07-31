import SwiftUI

public struct BBFloatingActionButton: View {
    private let iconName: String
    private let action: () -> Void
    private let accessibilityLabel: String

    public init(
        iconName: String = "plus",
        accessibilityLabel: String = "Floating action button",
        action: @escaping () -> Void
    ) {
        self.iconName = iconName
        self.accessibilityLabel = accessibilityLabel
        self.action = action
    }

    public var body: some View {
        Button(action: action) {
            Image(systemName: iconName)
                .font(.title)
                .padding()
                .background(Circle().fill(Color.accentColor))
                .foregroundColor(.white)
                .shadow(radius: 4)
        }
        .accessibilityLabel(Text(accessibilityLabel))
    }
}
