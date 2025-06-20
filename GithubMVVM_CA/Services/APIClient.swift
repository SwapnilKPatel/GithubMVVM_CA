//
//  APIClient.swift
//  GithubMVVM_CA
//
//  Created by SwapnilKPatel on 10/03/25.
//

import Foundation
import Alamofire
import Combine

class APIClient {
    static let shared = APIClient()
    
    private init() {}
    
    /// Generic API Request
    func request<T: Decodable>(_ url: String) -> AnyPublisher<T, APIError> {
        return AF.request(url)
            .validate()
            .publishDecodable(type: T.self)
            .tryMap { response in
                guard let value = response.value else {
                    throw APIError.network(error: response.error)
                }
                return value
            }
            .mapError { APIError.network(error: $0) }
            .eraseToAnyPublisher()
    }
}

/// API Errors
enum APIError: Error, LocalizedError {
    case network(error: Error?)
    case unknown

    var errorDescription: String {
        switch self {
        case .network(let error):
            return error?.localizedDescription ?? "Network Error"
        case .unknown:
            return "Unknown Error"
        }
    }
}
