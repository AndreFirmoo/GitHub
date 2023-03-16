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
    var isLoadItems = false
    init(service: Service = ServiceConcrete()) {
        self.service = service
    }
    
    func fetchSelected(params: RepositoryParams, completion: @escaping(Repository)-> Void) {
        service.fetchData(params: params) { result in
            switch result {
                case .success(let success):
                    self.isLoadItems = false
                    completion(success)
                case .failure(let failure):
                    print(failure)
            }
        }
    }
    
    func downloadImage(url: String, completion: @escaping (UIImage?) -> Void) {
        
    }
}
