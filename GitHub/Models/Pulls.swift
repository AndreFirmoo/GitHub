//
//  Pulls.swift
//  GitHub
//
//  Created by Andre Jardim Firmo on 30/08/19.
//  Copyright © 2019 Andre Jardim Firmo. All rights reserved.
//

import Foundation
class Pulls: Codable {
    let title: String
    let body: String
    let head : Head
    
    init(title: String, body:String, head:Head) {
        self.title = title
        self.body = body
        self.head = head
    }
}

class Head: Codable {
    let repo: Repo
    
    init(repo: Repo) {
        self.repo = repo
    }
}
class Repo: Codable {
    let owner : Owner
    
    init(owner: Owner) {
        self.owner = owner
    }
}
