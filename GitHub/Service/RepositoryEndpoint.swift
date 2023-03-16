//
//  RepositoryEndpoint.swift
//  GitHub
//
//  Created by Andre Firmo on 15/03/23.
//  Copyright © 2023 Andre Jardim Firmo. All rights reserved.
//

import Foundation

struct RepositoryParams {
    var language: String
    var page: Int
    var order: String
    var sort: String
}

enum RepositoriesEndpoint {
    private var baseURL: String { return "https://api.github.com/" }
    case language(RepositoryParams)
    
    private var fullPath: String {
        var endpoint: String
        switch self {
            case .language(let params):
                endpoint = "search/repositories?q=language:\(params.language)&sort=\(params.sort)&order=\(params.order)&page=\(params.page)"
        }
        
        return baseURL + endpoint
    }
    
    var url: URL {
        guard let url = URL(string: fullPath) else {
            preconditionFailure("URL NOT VALID")
        }
        return url
    }
}
