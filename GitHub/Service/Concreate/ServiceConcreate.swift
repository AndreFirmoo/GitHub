//
//  ServiceConcrete.swift
//  GitHub
//
//  Created by Andre Firmo on 13/03/23.
//  Copyright © 2023 Andre Jardim Firmo. All rights reserved.
//

import Foundation
import UIKit

final class ServiceConcrete {
    private let urlSession = URLSession.shared
    private let baseUrl = URL(string: "https://api.github.com/")
    private let cache = NSCache<NSString, UIImage>()
    
    private var jsonDecoder: JSONDecoder = {
        let jsonDecoder = JSONDecoder()
        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-mm-yyyy"
        jsonDecoder.dateDecodingStrategy = .formatted(dateFormatter)
        return jsonDecoder
    }()
    
    enum RepositoriesEndpoint {
        private var baseURL: String {return "https://api.github.com/"}
        case language(String, Int)
        case pullRequests(String, String)
        
        private var fullPath: String {
            var endpoint: String
            switch self {
                case .language(let language, let page):
                    endpoint = "search/repositories?q=language:\(language)&sort=stars&page=\(page)"
                case .pullRequests(let loginName, let userName):
                    endpoint = "repos/\(loginName)/\(userName)/pulls"
                default:
                    break
            }
            
            return baseURL + endpoint
        }
        
        var url: URL {
            guard let url = URL(string: fullPath) else {
                preconditionFailure("URL NOT VALID")
            }
            return url
        }
    }
    
    private func requestGH<T: Decodable>(url: URL, completion: @escaping (Result<T, Error>) -> Void) {
        let urlRequest = URLRequest(url: url)
        urlSession.dataTask(with: urlRequest) { [weak self] data, response, error in
            guard let strongSelf = self else { return }
            if error != nil {
                completion(.failure(error!))
                return
            }
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode, 200..<299 ~= statusCode else {
                print("Fudeu")
                return
            }
            if let data = data {
                do {
                    let values = try strongSelf.jsonDecoder.decode(T.self,  from: data)
                    completion(.success(values))
                } catch {
                    return
                }
            }
            
        }.resume()
    }
}

extension ServiceConcrete: Service {
    func downloadImage(url: String, completion: @escaping (UIImage?) -> Void) {
        let cacheKey = NSString(string: url)
        if let image = cache.object(forKey: cacheKey) {
            completion(image)
            return
        }
        
        guard let url = URL(string: url) else {
            completion(nil)
            return
        }
        
        urlSession.dataTask(with: URLRequest(url: url)) { [weak self] data, response, error in
            guard let data = data, let image = UIImage(data: data) else {
                completion(nil)
                return
            }
            
            DispatchQueue.main.async {
                self?.cache.setObject(image, forKey: cacheKey)
                completion(image)
            }
        }.resume()
    }
    
    func fetchData(userName: String, loginName: String, pullRequests completion: @escaping (Result<[PullRequest], Error>) -> Void) {
        let url = RepositoriesEndpoint.pullRequests(loginName, userName).url
        requestGH(url: url, completion: completion)
    }
    
    func fetchData(from language: String, currentPage: Int, completion: @escaping (Result<Repository, Error>) -> Void) {
        let url = RepositoriesEndpoint.language(language, currentPage).url
        requestGH(url: url, completion: completion)
    }
}
