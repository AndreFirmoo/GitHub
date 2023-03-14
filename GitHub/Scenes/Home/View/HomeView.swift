//
//  HomeView.swift
//  GitHub
//
//  Created by Andre Firmo on 14/03/23.
//  Copyright © 2023 Andre Jardim Firmo. All rights reserved.
//

import UIKit

final class HomeView: UIView {
    
    private var loadingIndicator: UIActivityIndicatorView = {
        let load = UIActivityIndicatorView(style: .large)
        load.translatesAutoresizingMaskIntoConstraints = false
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
        label.text = "Escolha uma linguagem dentro da lista"
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var languagePicker: UIPickerView = {
        let pikerView = UIPickerView()
        pikerView.translatesAutoresizingMaskIntoConstraints = false
        pikerView.delegate = self
        pikerView.dataSource = self
        return pikerView
    }()
    
    private lazy var goSearchButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Ir", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector (searchLanguage), for: .touchUpInside)
        return button
    }()
    
    private var selectedLanguages = ""
    private var languages: [String]
    var completionAction: ((String)->Void )?
    
    init(languages:[String]) {
        self.languages = languages
        super.init(frame: .zero)
        self.backgroundColor = .cyan
        setup()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func searchLanguage() {
        completionAction?(selectedLanguages)
    }
    
    
    func showLoading() {
        self.loadingIndicator.startAnimating()
    }
    
    func stopLoading() {
        self.loadingIndicator.stopAnimating()
    }
}

extension HomeView: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        languages.count
    }
}

extension HomeView: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        selectedLanguages = languages[row]
        return selectedLanguages
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedLanguages = languages[row]
    }
}

extension HomeView: ViewCoded {
    func setupView() {
        addSubview(logoImageView)
        addSubview(titleLabel)
        addSubview(languagePicker)
        addSubview(goSearchButton)
        addSubview(loadingIndicator)
    }
    
    func addConstraints() {
        setupConstraintsLogoImageView()
        setupConstraintsLanguagePicker()
        setupConstraintsGoSearchButton()
        setupConstraintsTitleLabel()
        setupConstraintsLoadingIndicatorView()
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
    
    func setupConstraintsLanguagePicker() {
        NSLayoutConstraint.activate([
            self.languagePicker.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 30),
            self.languagePicker.leadingAnchor.constraint(equalTo: leadingAnchor),
            self.languagePicker.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
    func setupConstraintsGoSearchButton() {
        NSLayoutConstraint.activate([
            self.goSearchButton.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -5),
            self.goSearchButton.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 32),
            self.goSearchButton.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -32)
        ])
    }
}
