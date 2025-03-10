//
//  GitHubRepo.swift
//  GithubMVVM_CA
//
//  Created by Ravi on 10/03/25.
//

import Foundation

struct GitHubRepo: Decodable, Identifiable {
    let id: Int
    let name: String
    let description: String?
}
