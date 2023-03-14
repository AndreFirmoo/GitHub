//
//  RepositoryViewModelConcrete.swift
//  GitHub
//
//  Created by Andre Firmo on 14/03/23.
//  Copyright © 2023 Andre Jardim Firmo. All rights reserved.
//

import UIKit

final class RepositoryViewModelConcrete: RepositoryViewModel {
    private var service: Service
    
    init(service: Service = ServiceConcrete()) {
        self.service = service
    }
    
    func fetchSelected(language: String, page: Int, completion: @escaping(Repository)-> Void) {
        service.fetchData(from: language, currentPage: page) { result in
            switch result {
                case .success(let success):
                    completion(success)
                case .failure(let failure):
                    print(failure)
            }
        }
    }
    
    func downloadImage(url: String, completion: @escaping (UIImage?) -> Void) {
        
    }
}
