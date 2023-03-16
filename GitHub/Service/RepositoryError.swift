//
//  RepositoryError.swift
//  GitHub
//
//  Created by Andre Firmo on 15/03/23.
//  Copyright © 2023 Andre Jardim Firmo. All rights reserved.
//

import Foundation
enum RepositoryError: Error {
    case errorRequest
    case errorStatusCode
    case errorDecode
}
