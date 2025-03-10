//
//  GitHubService.swift
//  GithubMVVM_CA
//
//  Created by Ravi on 10/03/25.
//

import Combine

protocol GitHubServiceProtocol {
    func fetchRepositories(username: String) -> AnyPublisher<[GitHubRepo], APIError>
}

class GitHubService: GitHubServiceProtocol {
    func fetchRepositories(username: String) -> AnyPublisher<[GitHubRepo], APIError> {
        let url = "https://api.github.com/users/\(username)/repos"
        return APIClient.shared.request(url)
    }
}
