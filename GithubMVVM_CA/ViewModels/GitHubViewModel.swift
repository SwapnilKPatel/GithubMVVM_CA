//
//  GitHubViewModel.swift
//  GithubMVVM_CA
//
//  Created by Ravi on 10/03/25.
//

import Combine
import Foundation

class GitHubViewModel: ObservableObject {
    private var cancellables = Set<AnyCancellable>()
    private let repository: GitHubRepositoryProtocol
    
    // Published properties for UI updates
    @Published var repositories: [GitHubRepo] = []
    @Published var loadingStatus: LoadStatus = .idle

    init(repository: GitHubRepositoryProtocol = GitHubRepository()) {
        self.repository = repository
    }

    // Load repositories
    func fetchRepositories(for username: String) {
        loadingStatus = .loading

        repository.getUserRepositories(username: username)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                guard let self = self else { return }
                switch completion {
                case .failure(let error):
                    self.loadingStatus = .failed(error.localizedDescription)
                case .finished:
                    break
                }
            } receiveValue: { [weak self] repos in
                guard let self = self else { return }
                self.repositories = repos
                self.loadingStatus = .success
            }
            .store(in: &cancellables)
    }

    // Cancel all ongoing requests
    func cancelRequests() {
        cancellables.forEach { $0.cancel() }
        cancellables.removeAll()
    }
}

// Enum to represent loading states
enum LoadStatus {
    case idle, loading, success, failed(String)
}
