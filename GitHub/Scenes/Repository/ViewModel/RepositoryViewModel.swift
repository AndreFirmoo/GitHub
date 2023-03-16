//
//  RepositoryViewModel.swift
//  GitHub
//
//  Created by Andre Firmo on 14/03/23.
//  Copyright © 2023 Andre Jardim Firmo. All rights reserved.
//

import UIKit

protocol RepositoryViewModel {
    var isLoadItems: Bool {get set}
    func fetchSelected(params: RepositoryParams, completion: @escaping(Repository)-> Void)
    func downloadImage(url: String, completion: @escaping(UIImage?)-> Void)
}
