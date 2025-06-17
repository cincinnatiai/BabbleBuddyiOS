import SwiftUI
import DesignKit

struct BabyCardView: View {
    let name: String
    let imageURL: String
    let description: String

    var body: some View {
        BBCardSectionViewContainer(title: name, icon: iconView) {
            Text(description)
                .textStyle(.body)
                .foregroundColor(AppColor.textSecondary)
        }
    }

    private var iconView: Image? {
        if let url = URL(string: imageURL),
           let data = try? Data(contentsOf: url),
           let uiImage = UIImage(data: data) {
            return Image(uiImage: uiImage)
        } else {
            return Image(systemName: "person.crop.circle")
        }
    }
}
