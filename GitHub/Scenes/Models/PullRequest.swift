//
//  PullRequest.swift
//  GitHub
//
//  Created by Andre Jardim Firmo on 30/08/19.
//  Copyright © 2019 Andre Jardim Firmo. All rights reserved.
//

import Foundation

struct PullRequest: Decodable {
    let title: String
    let body: String
    let head : Head
}

struct Head: Decodable {
    let repo: Repo
}

struct Repo: Decodable {
    let owner : Owner
}
