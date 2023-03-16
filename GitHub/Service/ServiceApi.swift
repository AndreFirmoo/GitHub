//
//  ServiceApi.swift
//  GitHub
//
//  Created by Andre Firmo on 13/03/23.
//  Copyright © 2023 Andre Jardim Firmo. All rights reserved.
//

import UIKit

protocol Service {
    func fetchData(
        params: RepositoryParams,
        completion: @escaping (Result<Repository, RepositoryError>)-> Void
    )
    
    func fetchData(
        userName: String,
        loginName: String,
        pullRequests completion: @escaping (Result<[PullRequest], RepositoryError>)-> Void
    )
    
    func downloadImage(url: String, completion: @escaping (UIImage?) -> Void)
}
