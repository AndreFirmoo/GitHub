//
//  Repository.swift
//  GitHub
//
//  Created by Andre Jardim Firmo on 28/08/19.
//  Copyright © 2019 Andre Jardim Firmo. All rights reserved.
//

import Foundation

struct Repository: Decodable {
    var items : [Items]
}
    
struct Items: Decodable {
    var name : String?
    var owner: Owner?
    var description:String?
    var stargazersCount:Int?
    var forks: Int?
    var language: String?
}

struct Language: Decodable {
    let language : String?
}

struct Owner: Decodable {
    let login: String?
    let avatarUrl: String?
}
