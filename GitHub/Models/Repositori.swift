//
//  Repositori.swift
//  GitHub
//
//  Created by Andre Jardim Firmo on 28/08/19.
//  Copyright © 2019 Andre Jardim Firmo. All rights reserved.
//

import Foundation

struct LanguageItem: Decodable {
    let items : [Items]
}
    
struct Items: Decodable {
    let name : String
    let owner: Owner
    let description:String
    let stargazers_count:Int
    let forks: Int
    let language: String
}

struct Language: Decodable {
    let language : String
    
}

struct Owner: Decodable {
    let login: String
    let avatar_url: String
}
