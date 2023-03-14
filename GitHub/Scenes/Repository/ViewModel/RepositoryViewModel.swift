//
//  RepositoryViewModel.swift
//  GitHub
//
//  Created by Andre Firmo on 14/03/23.
//  Copyright © 2023 Andre Jardim Firmo. All rights reserved.
//

import UIKit

protocol RepositoryViewModel {
    func fetchSelected(language: String, page: Int, completion: @escaping(Repository)-> Void)
    func downloadImage(url: String, completion: @escaping(UIImage?)-> Void)
}
