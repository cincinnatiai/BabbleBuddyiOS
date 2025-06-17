import UIKit
import SwiftUI
import DesignKit

final class BabyTableViewCell: UITableViewCell {
    private var hostingController: UIHostingController<BabyCardView>?

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configureInfo(with baby: DisplayableBabyItem) {
        let view = BabyCardView(
            name: baby.title,
            imageURL: baby.imageURL ?? "",
            description: baby.details?.first ?? "N/A"
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
