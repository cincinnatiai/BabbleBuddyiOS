//
//  BabyCustomTableViewCell.swift
//  babiesList
//
//  Created by Trainee on 4/8/25.
//

import Foundation
import UIKit

class BabyTableViewCell: UITableViewCell {
    private let localizedStrings = BabiesListLocalizedStringKeys.self
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: SizeConstants.CGFSize20, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var verticalStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = SizeConstants.CGFSize4
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
        
    }()
    
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError(localizedStrings.FatalErrorMessage)
    }
}

extension BabyTableViewCell {
    private func setupViews() {
        verticalStack.addArrangedSubview(nameLabel)
        verticalStack.addArrangedSubview(descriptionLabel)
        contentView.addSubview(verticalStack)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            verticalStack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: ConstraintConstants.constraintConstantCG12),
            verticalStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: ConstraintConstants.constraintConstantCG16),
            verticalStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: ConstraintConstants.contstraintConstantNegativeCG16),
            verticalStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: ConstraintConstants.contstraintConstantNegativeCG12)
        ])
    }
    
    func configureInfo(with baby: DisplayableBaby) {
        nameLabel.text = baby.name
        descriptionLabel.text = " \(localizedStrings.BabyTableViewCellDescriptionLabel) \(baby.description)"
    }
}
