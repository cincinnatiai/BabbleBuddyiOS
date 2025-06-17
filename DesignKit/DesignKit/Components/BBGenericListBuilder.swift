//
//  BBGeneriListBuilder.swift
//  DesignKit
//
//  Created by Noel Hiram Pat Angulo on 6/16/25.
//

import UIKit
import Combine

public class BBGenericListBuilder<T, Cell>: UIView, UITableViewDataSource, UITableViewDelegate where Cell: UITableViewCell {


    public var items: [T] = [] {
        didSet {
            tableView.reloadData()
        }
    }

    public var configureCell: ((Cell, T) -> Void)?
    public var didSelectItem: ((T) -> Void)?
    private let cellIdentifier: String

    private lazy var tableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.dataSource = self
        table.delegate = self
        table.register(Cell.self, forCellReuseIdentifier: cellIdentifier)
        return table
    }()

    public init(cellIdentifier: String = UUID().uuidString) {
        self.cellIdentifier = cellIdentifier
        super.init(frame: .zero)
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupView() {
        addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: topAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        items.count
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? Cell else {
            return UITableViewCell()
        }

        let item = items[indexPath.row]
        configureCell?(cell, item)

        return cell
    }

    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        didSelectItem?(items[indexPath.row])
    }
}
