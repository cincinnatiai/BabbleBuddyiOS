import UIKit
import SwiftUI
import DesignKit

final class BabyTableViewCell: UITableViewCell {
    private var hostingController: UIHostingController<BBCardView>?

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(with item: BabyCardDisplayModel) {
        let view = BBCardView(
            name: item.baby.title,
            description: item.baby.details?.first ?? "N/A",
            imageURL: item.baby.imageURL,
            type: .baby(gender: item.gender)
        )

        let hosting = UIHostingController(rootView: view)
        hosting.view.translatesAutoresizingMaskIntoConstraints = false

        hostingController?.view.removeFromSuperview()
        hostingController?.removeFromParent()

        contentView.addSubview(hosting.view)
        hostingController = hosting

        NSLayoutConstraint.activate([
            hosting.view.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            hosting.view.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            hosting.view.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            hosting.view.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
        ])
    }
}
