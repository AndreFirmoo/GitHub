//
//  GHDropDownView.swift
//  GitHub
//
//  Created by Andre Firmo on 15/03/23.
//  Copyright © 2023 Andre Jardim Firmo. All rights reserved.
//

import UIKit

protocol GHDropDownViewDelegate: AnyObject {
    func dropDownView(index: Int)
}

final class GHDropDownView: UIView {
    weak var delegate: GHDropDownViewDelegate?
    private var items: [String] = []
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.backgroundColor = .white
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 30, weight: .medium)
        label.textColor = .black
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    convenience init(title: String, list: [String]) {
        self.init(frame: .zero)
        items = list
        titleLabel.text = title
        layoutView()
    }
}

// MARK: - View Lifecycle.
extension GHDropDownView {
    func layoutView() {
        addSubview(titleLabel)
        addSubview(tableView)
        
        tableView.dataSource = self
        tableView.delegate = self
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(
                equalTo: self.leadingAnchor,
                constant: 10
            ),
            titleLabel.trailingAnchor.constraint(
                equalTo: self.trailingAnchor,
                constant: -10
            ),
            titleLabel.topAnchor.constraint(
                equalTo:  self.topAnchor,
                constant: 5
            ),
            tableView.topAnchor.constraint(
                equalTo: titleLabel.bottomAnchor,
                constant: 17
            ),
            tableView.leadingAnchor.constraint(
                equalTo: self.leadingAnchor
            ),
            tableView.trailingAnchor.constraint(
                equalTo: self.trailingAnchor
            ),
            tableView.bottomAnchor.constraint(
                equalTo: self.bottomAnchor
            )
        ])
    }
}

// MARK: - UITableViewDataSource
extension GHDropDownView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        items.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 56.0;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = items[indexPath.row]
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)

        cell.layer.backgroundColor = UIColor.lightGray.cgColor
        cell.backgroundColor = .clear
        cell.textLabel?.text = item
        cell.textLabel?.textColor = .black
        cell.textLabel?.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        return cell
    }
}

// MARK: - UITableViewDelegate
extension GHDropDownView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.dropDownView(index: indexPath.row)
    }
}
