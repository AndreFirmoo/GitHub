//
//  RepositoryTableViewCell.swift
//  GitHub
//
//  Created by Andre Firmo on 14/03/23.
//  Copyright © 2023 Andre Jardim Firmo. All rights reserved.
//

import UIKit

final class RepositoryTableViewCell: UITableViewCell {
    private lazy var userNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 25, weight: .thin)
        label.textColor = .red
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var descriptionUserLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20, weight: .thin)
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var repositoryNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20, weight: .thin)
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var languageLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var starCountLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20, weight: .thin)
        label.textColor = .red
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var starImageView: UIImageView = {
        let image = UIImage(systemName: "star")
        image?.withTintColor(.black, renderingMode: .alwaysOriginal)
        let imageView = UIImageView(image: image)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var forkCountLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20, weight: .thin)
        label.textColor = .red
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var forkImageView: UIImageView = {
        let image = UIImage(named: "fork")
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var avatarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 25
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private var viewModel = HomeViewModelConcrete(service: ServiceConcrete())
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupCell(repositoryItem: Items) {
        self.userNameLabel.text = repositoryItem.owner.login
        self.descriptionUserLabel.text = repositoryItem.description
        self.repositoryNameLabel.text = repositoryItem.name
        self.languageLabel.text = repositoryItem.language
        self.starCountLabel.text = String(repositoryItem.stargazersCount)
        self.forkCountLabel.text = String(repositoryItem.forks)
        self.viewModel.downloadImage(url: repositoryItem.owner.avatarUrl) { image in
            self.avatarImageView.image = image ?? UIImage(systemName: "person")
        }
    }
}

extension RepositoryTableViewCell: ViewCoded {
    func setupView() {
        contentView.addSubview(userNameLabel)
        contentView.addSubview(descriptionUserLabel)
        contentView.addSubview(repositoryNameLabel)
        contentView.addSubview(languageLabel)
        contentView.addSubview(starCountLabel)
        contentView.addSubview(forkCountLabel)
        contentView.addSubview(avatarImageView)
        contentView.addSubview(forkImageView)
        contentView.addSubview(starImageView)
    }
    
    func addConstraints() {
        setupConstraintsUserNameLabel()
        setupConstraintsDescriptionUserLabel()
        setupConstraintsRepositoryNameLabel()
        setupConstraintsLanguageLabel()
        setupConstraintsStarCountLabel()
        setupConstraintsForkCountLabel()
        setupConstraintsAvatarImageView()
        setupConstraintsForkImageView()
        setupConstraintsStarImageView()
    }
    
    private func setupConstraintsUserNameLabel() {
        NSLayoutConstraint.activate([
            userNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            userNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 32),
            userNameLabel.trailingAnchor.constraint(equalTo: avatarImageView.leadingAnchor, constant: -72)
        ])
    }
    
    private func setupConstraintsDescriptionUserLabel() {
        NSLayoutConstraint.activate([
            descriptionUserLabel.topAnchor.constraint(equalTo: userNameLabel.bottomAnchor, constant: 10),
            descriptionUserLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 32),
            descriptionUserLabel.widthAnchor.constraint(equalToConstant: 170),
            descriptionUserLabel.heightAnchor.constraint(lessThanOrEqualToConstant: 150)
        ])
    }
    
    private func setupConstraintsAvatarImageView() {
        NSLayoutConstraint.activate([
            avatarImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            avatarImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -32),
            avatarImageView.heightAnchor.constraint(equalToConstant: 50),
            avatarImageView.widthAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func setupConstraintsLanguageLabel() {
        NSLayoutConstraint.activate([
            languageLabel.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 10),
            languageLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -32)
        ])
    }
    
    private func setupConstraintsRepositoryNameLabel() {
        NSLayoutConstraint.activate([
            repositoryNameLabel.topAnchor.constraint(equalTo: languageLabel.bottomAnchor, constant: 10),
            repositoryNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -32)
        ])
    }
    
    private func setupConstraintsStarImageView() {
        NSLayoutConstraint.activate([
            starImageView.topAnchor.constraint(equalTo: descriptionUserLabel.bottomAnchor, constant: 10),
            starImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 32),
            starImageView.heightAnchor.constraint(equalToConstant: 25),
            starImageView.widthAnchor.constraint(equalToConstant: 25)
        ])
    }
    
    private func setupConstraintsStarCountLabel() {
        NSLayoutConstraint.activate([
            starCountLabel.topAnchor.constraint(equalTo: descriptionUserLabel.bottomAnchor, constant: 10),
            starCountLabel.leadingAnchor.constraint(equalTo: starImageView.trailingAnchor, constant: 16)
        ])
    }
    
    private func setupConstraintsForkImageView() {
        NSLayoutConstraint.activate([
            forkImageView.topAnchor.constraint(equalTo: starImageView.bottomAnchor, constant: 10),
            forkImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 32),
            forkImageView.heightAnchor.constraint(equalToConstant: 25),
            forkImageView.widthAnchor.constraint(equalToConstant: 25),
            forkImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5)
        ])
    }
    
    private func setupConstraintsForkCountLabel() {
        NSLayoutConstraint.activate([
            forkCountLabel.topAnchor.constraint(equalTo: starImageView.bottomAnchor, constant: 10),
            forkCountLabel.leadingAnchor.constraint(equalTo: forkImageView.trailingAnchor, constant: 16),
            forkCountLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5)
        ])
    }
}
