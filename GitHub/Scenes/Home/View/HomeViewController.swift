//
//  HomeViewController.swift
//  GitHub
//
//  Created by Andre Firmo on 14/03/23.
//  Copyright © 2023 Andre Jardim Firmo. All rights reserved.
//

import UIKit

final class HomeViewController: UIViewController {
    
    var sharedView: HomeView?
    private var viewModel: HomeViewModel
    
    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.statesDidChange = { [weak self] state in
            self?.updateUI(for: state)
        }
        sharedView?.completionAction = {[weak self] params in
            self?.viewModel.fetchSelected(params: params)
        }

    }
    
    override func loadView() {
        super.loadView()
        sharedView = HomeView(viewController: self)
        view = sharedView
    }

    func updateUI(for state: HomeViewStates) {
        switch state {
            case .loading:
                sharedView?.showLoading()
            case .loaded(let repository):
                sharedView?.stopLoading()
                let repo = RepositoryViewController(repository: repository)
                navigationController?.pushViewController(repo, animated: true)
            case .error(let error):
                sharedView?.stopLoading()
                fatalError()
                // TODO: - Fazer a logica de mostrar o error
        }
    }
    
}

