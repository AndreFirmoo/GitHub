//
//  GHBottomSheetViewController.swift
//  GitHub
//
//  Created by Andre Firmo on 15/03/23.
//  Copyright © 2023 Andre Jardim Firmo. All rights reserved.
//

import UIKit

final class GHBottomSheetViewController: UIViewController {
    // MARK: - Properties
    private lazy var mainView: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private var contentView = UIView()
    private var heightConstraint: NSLayoutConstraint!
    var completion: (() -> Void)?
    var viewAlphaComponent: CGFloat = 0.7
    private var swipeDownGesture: UIPanGestureRecognizer?
    private var mainViewTranslation = CGPoint.zero
    var dismissType: DismissType = .gestureDismissible
    
    enum DismissType {
        case gestureDismissible
        case notDismissible
    }
    
    // MARK: - Initializers
    init() {
        super.init(nibName: nil, bundle: nil)
        layoutView()
        mainView.layer.cornerRadius = 20
        modalPresentationStyle = .overFullScreen
        modalTransitionStyle = .crossDissolve
        backgroundShadow(with: UIColor.black.withAlphaComponent(self.viewAlphaComponent))
    }
    
    public convenience init(completion: @escaping (() -> Void)) {
        self.init()
        self.completion = completion
    }
    
    @available(*, unavailable)
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View's Life Cycle
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        backgroundShadow(with: UIColor.black.withAlphaComponent(self.viewAlphaComponent))
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        backgroundShadow(with: .clear)
    }
    
    
    /// Set animated background in view
    /// - Parameters:
    ///     - Color: change current color background view
    private func backgroundShadow(with color: UIColor) {
        UIView.animate(
            withDuration: 0.15,
            animations: {
                self.view.backgroundColor = color
            }
        )
    }
    
    /// Show bottom sheet viewController
    /// - Parameters:
    ///     - CurrentViewController: viewController to present a bottom sheet
    ///     - ContentView: The ConteView to show when appears bottom sheet
    ///     - DismissType: It's enum to choose dismiss type bottom sheet
    func showBottomSheet(
        with currentViewController: UIViewController,
        contentView: UIView,
        dismissType: DismissType
    ) {
        self.dismissType = dismissType
        currentViewController.present(self, animated: true) { [weak self] in
            self?.setupContentView(contentView)
        }
    }
    
    /// Configure contentView when appears bottom sheet
    /// - Parameters:
    ///     - ContentView: A Custom View to appears when show up bottom sheet
    private func setupContentView(_ contentView: UIView) {
        self.contentView = contentView
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        mainView.subviews.forEach {
            $0.removeFromSuperview()
        }
        
        self.mainView.addSubview(contentView)
        
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(
                equalTo: self.mainView.topAnchor
            ),
            contentView.leadingAnchor.constraint(
                equalTo: self.mainView.leadingAnchor
            ),
            contentView.bottomAnchor.constraint(
                equalTo: self.mainView.bottomAnchor
            ),
            contentView.trailingAnchor.constraint(
                equalTo: self.mainView.trailingAnchor
            )
        ])
        
        heightConstraint.constant = UIScreen.main.bounds.height / 2
        configureDismiss()
    }
    
    /// Setup main view of bottom sheet
    private func layoutView() {
        self.view.addSubview(mainView)
        
        NSLayoutConstraint.activate([
            mainView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            mainView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            mainView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
        ])
        
        heightConstraint = NSLayoutConstraint(
            item: mainView,
            attribute: .height,
            relatedBy: .equal,
            toItem: nil,
            attribute: .notAnAttribute,
            multiplier: 1,
            constant: 0
        )
        
        mainView.addConstraint(heightConstraint)
        mainView.transform = .identity
    }
    
    /// Custom completion when dismiss bottom sheet
    @objc func dismissCompletion() {
        dismiss(animated: true, completion: completion)
    }
    
    /// Configuration dismiss type
    func configureDismiss() {
        if dismissType == .gestureDismissible {
            swipeDownGesture = UIPanGestureRecognizer(target: self,
                                                      action: #selector(swipeDownAction))
            self.mainView.addGestureRecognizer(swipeDownGesture!)
        }
    }
    
    /// Configure swipe down with UIPanGestureRecognizer
    /// - Parameters:
    ///     - Gesture: A gesture recognizer to setup action
    @objc private func swipeDownAction(_ gesture: UIPanGestureRecognizer) {
        switch gesture.state {
            case .changed:
                mainViewTranslation = gesture.translation(in: mainView)
                
                UIView.animate(
                    withDuration: 0.5,
                    delay: 0,
                    usingSpringWithDamping: 0.7,
                    initialSpringVelocity: 1,
                    options: .curveEaseOut,
                    animations: {
                        if self.mainViewTranslation.y >= 0 {
                            self.mainView.transform = CGAffineTransform(translationX: 0,
                                                                        y: self.mainViewTranslation.y)
                        }
                    }
                )
            case .ended:
                if mainViewTranslation.y < 200 {
                    UIView.animate(
                        withDuration: 0.5,
                        delay: 0,
                        usingSpringWithDamping: 0.7,
                        initialSpringVelocity: 1,
                        options: .curveEaseOut,
                        animations: {
                            self.mainView.transform = .identity
                        }
                    )
                } else {
                    dismissCompletion()
                }
            default:
                break
        }
    }
}
