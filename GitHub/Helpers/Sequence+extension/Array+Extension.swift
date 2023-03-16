//
//  Array+Extension.swift
//  GitHub
//
//  Created by Andre Firmo on 16/03/23.
//  Copyright © 2023 Andre Jardim Firmo. All rights reserved.
//

import Foundation
extension Array where Element == String {
    func filterItemForName(_ name: String) -> FilterItems? {
        switch name {
            case "Favoritos":
                return .stars
            case "Forks":
                return .forks
            case "Procura de ajudas":
                return .helpIssues
            case "Atualizados":
                return .updated
            default:
                return nil
        }
    }
    
    func orderByItemFor(_ name: String) -> OrderByItems? {
        switch name {
            case "Crescente":
                return .asc
            case "Decrescente":
                return .desc
            default:
                return nil
        }
    }
}
