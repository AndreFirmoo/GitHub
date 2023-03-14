//
//  HomeViewModel.swift
//  GitHub
//
//  Created by Andre Firmo on 14/03/23.
//  Copyright © 2023 Andre Jardim Firmo. All rights reserved.
//
import UIKit

protocol HomeViewModel {
    var viewStates: HomeViewStates { get }
    var statesDidChange: ((HomeViewStates) -> Void)? { get set}
    func fetchSelected(language: String, page: Int)
    func downloadImage(url: String, completion: @escaping(UIImage?)-> Void)
}

enum HomeViewStates {
    case loading
    case loaded(Repository)
    case error(Error)
}
