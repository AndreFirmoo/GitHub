//
//  GHBottomSheetViewController.swift
//  GitHub
//
//  Created by Andre Firmo on 15/03/23.
//  Copyright © 2023 Andre Jardim Firmo. All rights reserved.
//

import UIKit

final class GHBottomSheetViewController: UIViewController {
    private lazy var mainView: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private var contentView = UIView()
    private var heightConstraint: NSLayoutConstraint!
    var completion: (() -> Void)?
    public var viewAlphaComponent: CGFloat = 0.7
    private var swipeDownGesture: UIPanGestureRecognizer?
    private var mainViewTranslation = CGPoint.zero
    public var hasRoundedCorners: Bool = true
    public var dismissType: DismissType = .gestureDismissible
    
    enum DismissType {
        case gestureDismissible
        case notDismissible
    }
    
    init() {
        super.init(nibName: nil, bundle: nil)
        layoutView()
    }
    
    public convenience init(completion: @escaping (() -> Void)) {
        self.init()
        self.completion = completion
        
        mainView.layer.cornerRadius = 20
        modalPresentationStyle = .overFullScreen
        modalTransitionStyle = .crossDissolve
        makeBackgroundShadow(with: UIColor.black.withAlphaComponent(self.viewAlphaComponent))
    }
    
    @available(*, unavailable)
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        makeBackgroundShadow(with: UIColor.black.withAlphaComponent(self.viewAlphaComponent))
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        makeBackgroundShadow(with: .clear)
    }
    
    private func makeBackgroundShadow(with color: UIColor) {
        UIView.animate(
            withDuration: 0.15,
            animations: {
                self.view.backgroundColor = color
            }
        )
    }
    
    
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
    
    @objc func dismissCompletion() {
        dismiss(animated: true, completion: completion)
    }
    
    func configureDismiss() {
        if dismissType == .gestureDismissible {
            swipeDownGesture = UIPanGestureRecognizer(target: self,
                                                      action: #selector(swipeDownAction))
            self.mainView.addGestureRecognizer(swipeDownGesture!)
        }
    }
    
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
