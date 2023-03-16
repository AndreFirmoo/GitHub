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
    init(repository: Repository, viewModel: RepositoryViewModel = RepositoryViewModelConcrete()) {
        self.repository = repository
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
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let tableHeight = scrollView.frame.size.height

        if offsetY > contentHeight - tableHeight {
            if currentPage <= maxPage {
                self.currentPage += 1
                viewModel.fetchSelected(language: repository.items.first!.language ?? "C", page: currentPage) { repositoryRefrash in
                    DispatchQueue.main.async {
                        
                        self.repository.items.append(contentsOf: repositoryRefrash.items)
                        self.tableView.reloadData()
                    }
                }
            }
        }
    }
}
