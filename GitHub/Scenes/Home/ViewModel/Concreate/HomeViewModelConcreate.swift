//
//  HomeViewModelConcrete.swift
//  GitHub
//
//  Created by Andre Firmo on 14/03/23.
//  Copyright © 2023 Andre Jardim Firmo. All rights reserved.
//

import Foundation
import UIKit

final class HomeViewModelConcrete: HomeViewModel {
    var viewStates: HomeViewStates = .loading {
        didSet {
            DispatchQueue.main.async {
                self.statesDidChange?(self.viewStates)
            }
        }
    }
    
    var statesDidChange: ((HomeViewStates) -> Void)?
    private var service: Service
    
    init(service: Service) {
        self.service = service
    }
    
    func fetchSelected(params: RepositoryParams) {
        viewStates = .loading
        service.fetchData(params: params) { result in
            switch result {
                case .success(let success):
                    self.viewStates = .loaded(success)
                case .failure(let failure):
                    self.viewStates = .error(failure)
            }
        }
    }
    
    func downloadImage(url: String, completion: @escaping(UIImage?)-> Void) {
        service.downloadImage(url: url, completion: completion)
    }
}
