import SwiftUI

struct EmptyStateView: View {
    let title: String
    let message: String?
    let image: Image?
    let actionTitle: String?
    let action: (() -> Void)?
    
    init(
        title: String,
        message: String? = nil,
        image: Image? = Image(systemName: "tray"),
        actionTitle: String? = nil,
        action: (() -> Void)? = nil
    )
    {
        self.title = title
        self.message = message
        self.image = image
        self.actionTitle = actionTitle
        self.action = action
    }
    var body: some View {
        VStack{
            if let image = image {
                image
                    .resizable()
                    .scaledToFit()
                    .frame(width: 80, height: 80)
                    .foregroundColor(.gray.opacity(0.6))
            }
            Text(title)
                .textStyle(.title)
                .multilineTextAlignment(.center)
            if let message = message {
                Text(message)
                    .textStyle(.body)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
            }
            if let actionTitle = actionTitle, let action = action {
                Button(actionTitle, action: action)
                    .foregroundColor(.white)
                    .buttonStyle(.borderedProminent)
                    .padding(.top, 8)
            }
        }
    }
}
#Preview {
    Group {
        //Simple empty view
        EmptyStateView(
            title: "Empty List"
        )
        EmptyStateView(
            //New users
            title: "Welcome to BabbleBuddy",
            message: "Start by adding your baby's journal.",
            image: Image(systemName: "person.crop.circle.badge.plus"),
            actionTitle: "Get Started",
            action: {}
        )
    }
}
