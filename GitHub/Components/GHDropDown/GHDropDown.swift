//
//  GHDropDown.swift
//  GitHub
//
//  Created by Andre Firmo on 15/03/23.
//  Copyright © 2023 Andre Jardim Firmo. All rights reserved.
//

import UIKit

protocol GHDropDownActionDelegate {
    func ghDropDown(_ dropDown: GHDropDown, selectItem at: Int, nameItem: String)
    func ghDropDown(_ dropDown: GHDropDown, didChange index: Int)
}

extension GHDropDownActionDelegate {
    func ghDropDown(_ dropDown: GHDropDown, didChange index: Int) {
        
    }
}


final class GHDropDown: UIButton {
    private var ghDropDownConfigurator: GHDropDownConfiguration
    private var selectedItem: String = ""
    private var selectedItemIndex: Int = -1
    private var imageViewHorizontalConstraint: NSLayoutConstraint = .init()

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(ghDropDownConfigurator: GHDropDownConfiguration) {
        self.ghDropDownConfigurator = ghDropDownConfigurator
        super.init(frame: .zero)
        
        if ghDropDownConfigurator.selectedIndex >= 0 {
            dropDownView(index: ghDropDownConfigurator.selectedIndex)
        }
        
        self.translatesAutoresizingMaskIntoConstraints = false
        setConfiguration()
    }
}

extension GHDropDown: GHDropDownViewDelegate {
    func dropDownView(index: Int) {
        if index >= ghDropDownConfigurator.items.count { return }
        selectedItemIndex = index
        let item = ghDropDownConfigurator.items[index]
        selectedItem = item
        setTitle(item, for: .normal)
        ghDropDownConfigurator.delegate.ghDropDown(self, selectItem: index, nameItem: item)
        ghDropDownConfigurator.bottomSheetViewController.dismissCompletion()
        
        if !ghDropDownConfigurator.imageToTrailing {
            let textWidth = titleLabel?.intrinsicContentSize.width ?? 0
            imageViewHorizontalConstraint.constant = textWidth + 27
        }
        
        self.layoutIfNeeded()
        ghDropDownConfigurator.delegate.ghDropDown(self, didChange: index)

    }
    private func setupUI() {
        titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        setTitle(ghDropDownConfigurator.placeholder, for: .normal)
        setTitleColor(ghDropDownConfigurator.colorPlaceholder, for: .normal)
        layer.borderWidth = ghDropDownConfigurator.borderWidth
        layer.borderColor = ghDropDownConfigurator.borderColor
        layer.cornerRadius = 20
        let image = UIImage(systemName: "arrow.down")?.withRenderingMode(.alwaysTemplate)
        setImage(
            image,
            for: .normal
        )
    }
    private func setConfiguration() {
        setupUI()
        addTarget(self, action: #selector(showList), for: .touchUpInside)
        contentHorizontalAlignment = .left
        guard let imageView = self.imageView else { return }
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        if ghDropDownConfigurator.imageToTrailing {
            imageViewHorizontalConstraint = imageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -19)
        } else {
            titleLabel?.invalidateIntrinsicContentSize()
            let textWidth = titleLabel?.intrinsicContentSize.width ?? 0
            imageViewHorizontalConstraint = imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: textWidth + 27)
        }
        
        NSLayoutConstraint.activate([
            imageViewHorizontalConstraint,
            imageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 20),
            imageView.heightAnchor.constraint(equalToConstant: 16.38)
        ])
        
    }
    
    @objc private func showList(_ sender: UIButton) {
        if ghDropDownConfigurator.items.isEmpty { return }
        
        ghDropDownConfigurator.bottomSheetViewController = GHBottomSheetViewController(
            completion: {
                self.imageView?.transform = CGAffineTransform(scaleX: 1, y: 1)
            }
        )
        
        let contentView = GHDropDownView(title: self.ghDropDownConfigurator.title, list: self.ghDropDownConfigurator.items)
        contentView.delegate = self
        
        ghDropDownConfigurator.bottomSheetViewController.showBottomSheet(with: ghDropDownConfigurator.viewController, contentView: contentView, dismissType: .notDismissible)
        
        imageView?.transform = CGAffineTransform(scaleX: 1, y: -1)
    }
    
    public func getSelectedIndex() -> Int {
        return selectedItemIndex
    }
    
    public func getSelectedItem() -> String {
        return selectedItem
    }
    
    public func setItemList(_ items: [String]) {
        self.ghDropDownConfigurator.items = items
        
        if !items.isEmpty {
            dropDownView(index: 0)
        }
    }
}
