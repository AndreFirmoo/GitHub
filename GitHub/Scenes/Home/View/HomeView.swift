//
//  HomeView.swift
//  GitHub
//
//  Created by Andre Firmo on 14/03/23.
//  Copyright © 2023 Andre Jardim Firmo. All rights reserved.
//

import UIKit

final class HomeView: UIView {
    private var filterByItems = ["Favoritos", "Forks", "Procura de ajudas", "Atualizados"]
    private var orderByItems = ["Crescente", "Decrescente"]
    private var selectedFilter: String?
    private var selectedOrder: String?
    
    private var loadingIndicator: UIActivityIndicatorView = {
        let load = UIActivityIndicatorView(style: .large)
        load.translatesAutoresizingMaskIntoConstraints = false
        load.tintColor = .black
        return load
    }()
    
    private var logoImageView: UIImageView = {
        let image = UIImage(named: "Logo")
        let imageView = UIImageView(image: image)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        label.textColor = .black
        label.text = "Pesquise pela sua linguagem favorita"
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var searchTextField: GHTextField = {
        let textField = GHTextField()
        textField.translatesAutoresizingMaskIntoConstraints = false

        let attributedPlaceholder = NSAttributedString(string: "Exemplo: Swift", attributes: [
            NSAttributedString.Key.foregroundColor: UIColor.gray,
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16)
        ])
        textField.attributedPlaceholder = attributedPlaceholder
        return textField
    }()
    
    private lazy var goSearchButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Pesquisar", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector (searchLanguage), for: .touchUpInside)
        button.backgroundColor = .label
        button.layer.cornerRadius = 10
        return button
    }()
    
    private lazy var orderBy: GHDropDown = {
        let configuration = GHDropDownConfiguration(
            delegate: self,
            title: "Ordenar por:",
            placeholder: "Selecione a ordem",
            colorPlaceholder: .black,
            borderWidth: 1,
            borderColor: UIColor.black.cgColor,
            items: orderByItems,
            selectedIndex: -1,
            imageToTrailing: true,
            viewController: viewController,
            bottomSheetViewController: GHBottomSheetViewController()
        )
        let drop = GHDropDown(ghDropDownConfigurator: configuration)
        return drop
    }()
    
    private lazy var filterBy: GHDropDown = {
        let configuration = GHDropDownConfiguration(
            delegate: self,
            title: "Filtrar por:",
            placeholder: "Selecione um filtro",
            colorPlaceholder: .black,
            borderWidth: 1,
            borderColor: UIColor.black.cgColor,
            items: filterByItems,
            selectedIndex: -1,
            imageToTrailing: true,
            viewController: viewController,
            bottomSheetViewController: GHBottomSheetViewController()
        )
        let drop = GHDropDown(ghDropDownConfigurator: configuration)
        return drop
    }()
    
    var completionAction: ((RepositoryParams)->Void)?
    var viewController: UIViewController
    
    init(viewController: UIViewController) {
        self.viewController = viewController
        super.init(frame: .zero)
        self.backgroundColor = .cyan
        setup()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func searchLanguage() {
        guard let params = getInformation() else { return }
        completionAction?(params)
    }
    
    
    func showLoading() {
        self.loadingIndicator.startAnimating()
    }
    
    func stopLoading() {
        self.loadingIndicator.stopAnimating()
    }
    
    private func getInformation() -> RepositoryParams? {
        guard let language = searchTextField.text,
              let order = selectedOrder,
              let filter = selectedFilter
        else {
            displayError(title: "Oh! NÃO", message: "Por favor preencha o campo da sua linguagem e selecione os filtros corretamente.")
            return nil
        }
        if !language.isEmpty {
            return RepositoryParams(language: language, page: 1, order: order, sort: filter)
        }
        
        displayError(title: "Eita!", message: "O Campo de linguagem não pode ficar vazio, por gentileza preencha")
        return nil
    }
    
    func displayError(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        viewController.present(alert, animated: true)
    }
}

extension HomeView: GHDropDownActionDelegate {
    func ghDropDown(_ dropDown: GHDropDown, selectItem at: Int, nameItem: String) {
        if dropDown == orderBy {
            if let item = orderByItems.orderByItemFor(nameItem) {
                selectedOrder = item.rawValue
            }
        } else {
            if let item = filterByItems.filterItemForName(nameItem) {
                selectedFilter = item.rawValue
            }
        }
    }
}

extension HomeView: ViewCoded {
    func setupView() {
        addSubview(logoImageView)
        addSubview(titleLabel)
        addSubview(searchTextField)
        addSubview(orderBy)
        addSubview(filterBy)
        addSubview(goSearchButton)
        addSubview(loadingIndicator)
    }
    
    func addConstraints() {
        setupConstraintsLogoImageView()
        setupConstraintsGoSearchButton()
        setupConstraintsTitleLabel()
        setupConstraintsLoadingIndicatorView()
        setupConstraintsFilterByDropDown()
        setupConstraintsOrderByDropDown()
        setupConstraintsSearchTextField()
    }
    
    func setupConstraintsLoadingIndicatorView() {
        NSLayoutConstraint.activate([
            loadingIndicator.centerXAnchor.constraint(equalTo: centerXAnchor),
            loadingIndicator.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
    }
    
    func setupConstraintsLogoImageView() {
        NSLayoutConstraint.activate([
            self.logoImageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 50),
            self.logoImageView.widthAnchor.constraint(equalToConstant: 100),
            self.logoImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            self.logoImageView.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    func setupConstraintsTitleLabel() {
        NSLayoutConstraint.activate([
            self.titleLabel.topAnchor.constraint(equalTo: self.logoImageView.bottomAnchor, constant: 15),
            self.titleLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 32),
            self.titleLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -32)
        ])
    }
    
    func setupConstraintsSearchTextField() {
        NSLayoutConstraint.activate([
            self.searchTextField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 15),
            self.searchTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -32),
            self.searchTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32),
            self.searchTextField.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func setupConstraintsOrderByDropDown() {
        NSLayoutConstraint.activate([
            self.orderBy.topAnchor.constraint(equalTo: searchTextField.bottomAnchor, constant: 30),
            self.orderBy.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32),
            self.orderBy.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -32),
            self.orderBy.heightAnchor.constraint(equalToConstant: 50),
            
        ])
    }
    
    private func setupConstraintsFilterByDropDown() {
        NSLayoutConstraint.activate([
            self.filterBy.topAnchor.constraint(equalTo: orderBy.bottomAnchor, constant: 15),
            self.filterBy.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -32),
            self.filterBy.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32),
            self.filterBy.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    func setupConstraintsGoSearchButton() {
        let lowPriorityBottomAnchor = self.goSearchButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -15)
        lowPriorityBottomAnchor.priority = .defaultLow
        NSLayoutConstraint.activate([
            self.goSearchButton.bottomAnchor.constraint(equalTo: self.keyboardLayoutGuide.topAnchor, constant: -10),
            self.goSearchButton.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 32),
            self.goSearchButton.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -32),
            self.goSearchButton.heightAnchor.constraint(equalToConstant: 50),
            lowPriorityBottomAnchor
        ])
    }
}
