//
//  GitHubViewController.swift
//  GithubMVVM_CA
//
//  Created by SwapnilKPatel on 10/03/25.
//

import UIKit
import Combine

class GitHubViewController: UIViewController {
    private var viewModel = GitHubViewModel()
    private var cancellables = Set<AnyCancellable>()
    
    private let tableView = UITableView()
    private let loadingIndicator = UIActivityIndicatorView(style: .large)

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bindViewModel()
        viewModel.fetchRepositories(for: "airbnb") // Example GitHub username
    }
    
    private func setupUI() {
        view.addSubview(tableView)
        view.addSubview(loadingIndicator)
        tableView.frame = view.bounds
        loadingIndicator.center = view.center
        tableView.dataSource = self
    }

    private func bindViewModel() {
        viewModel.$repositories
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.tableView.reloadData()
            }
            .store(in: &cancellables)
        
        viewModel.$loadingStatus
            .receive(on: DispatchQueue.main)
            .sink { [weak self] status in
                switch status {
                case .loading:
                    self?.loadingIndicator.startAnimating()
                case .success, .failed:
                    self?.loadingIndicator.stopAnimating()
                default:
                    break
                }
            }
            .store(in: &cancellables)
    }
}

// MARK: - TableView Data Source
extension GitHubViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.repositories.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)
        let repo = viewModel.repositories[indexPath.row]
        cell.textLabel?.text = repo.name
        cell.detailTextLabel?.text = repo.description
        return cell
    }
}
