//
//  RepositoryViewController.swift
//  GitHub
//
//  Created by Andre Firmo on 14/03/23.
//  Copyright © 2023 Andre Jardim Firmo. All rights reserved.
//

import UIKit
 
final class RepositoryViewController: UIViewController {
    private var repository: Repository
    private var params: RepositoryParams
    private let maxPage = 10
    private var currentPage = 1

    private lazy var tableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.register(RepositoryTableViewCell.self, forCellReuseIdentifier: "Repos")
        table.delegate = self
        table.dataSource = self
        return table
    }()
    
    private var viewModel: RepositoryViewModel
    init(repository: Repository, params: RepositoryParams, viewModel: RepositoryViewModel = RepositoryViewModelConcrete()) {
        self.repository = repository
        self.params = params
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let languageName = repository.items.first?.language {
            title = "Language: \(languageName)"
        }

        self.view.backgroundColor = .white
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

extension RepositoryViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        repository.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Repos") as? RepositoryTableViewCell else {
            return UITableViewCell(style: .default, reuseIdentifier: "Fudeu")
        }
        
        let items = repository.items[indexPath.row]
        cell.setupCell(repositoryItem: items)
        return cell
    }
}

extension RepositoryViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        CGFloat(200)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let maxIndexPage = 33
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        
        if offsetY > contentHeight - scrollView.frame.height {
            if !viewModel.isLoadItems && params.page < maxIndexPage {
                params.page += 1
                viewModel.isLoadItems = true
                viewModel.fetchSelected(params: self.params) { repository in
                    self.repository.items.append(contentsOf: repository.items)
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                }
            }
        }
    }
}
