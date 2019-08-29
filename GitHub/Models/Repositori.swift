//
//  Repositori.swift
//  GitHub
//
//  Created by Andre Jardim Firmo on 28/08/19.
//  Copyright © 2019 Andre Jardim Firmo. All rights reserved.
//

import Foundation
class Itens: Codable {
    let items : [Item]
    init(items: [Item]) {
        self.items = items
    }
   
}
class Item: Codable {
    let name : String
    let owner: Owner
    let description:String
    let stargazers_count:Int
    let forks: Int
    let language: String
    init(name: String, owner: Owner, description: String,stargazers_count: Int, forks: Int, language: String) {
        self.name = name
        self.owner = owner
        self.description = description
        self.stargazers_count = stargazers_count
        self.forks = forks
        self.language = language
    }
}
class Language: Codable {
    let language : String
    init(lang: String) {
        self.language = lang
    }
}
class Owner: Codable {
    let login: String
    let avatar_url: String
    
    init(login: String, avatar_url: String) {
        self.avatar_url = avatar_url
        self.login = login
    }
}
