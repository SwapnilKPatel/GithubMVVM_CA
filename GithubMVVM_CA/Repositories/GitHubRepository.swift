//
//  GitHubRepository.swift
//  GithubMVVM_CA
//
//  Created by Ravi on 10/03/25.
//

import Combine

protocol GitHubRepositoryProtocol {
    func getUserRepositories(username: String) -> AnyPublisher<[GitHubRepo], APIError>
}

class GitHubRepository: GitHubRepositoryProtocol {
    private let service: GitHubServiceProtocol

    init(service: GitHubServiceProtocol = GitHubService()) {
        self.service = service
    }

    func getUserRepositories(username: String) -> AnyPublisher<[GitHubRepo], APIError> {
        return service.fetchRepositories(username: username)
    }
}
