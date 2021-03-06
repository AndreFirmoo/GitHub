//
//  GetRepositori.swift
//  GitHub
//
//  Created by Andre Jardim Firmo on 28/08/19.
//  Copyright © 2019 Andre Jardim Firmo. All rights reserved.
//

import Foundation

func loadDataApi(currentPage: Int,Language: String ,onComplete: @escaping (_ repositories:[Item])-> Void) {
  
    let urlApi = URL(string: "https://api.github.com/search/repositories?q=language:\(Language)&sort=stars&page=\(String(currentPage))")
    guard let url = urlApi  else { return }
    URLSession.shared.dataTask(with: url) {(data, response, err)in
        guard let data = data else {return}
        do {
            let course = try JSONDecoder().decode(Itens.self, from: data)
            let infos = course.items
            onComplete(infos)
        } catch  {
            print(error.localizedDescription)
        }
        }.resume()
}
func loadPulls(login: String, name: String, onComplete: @escaping (_ pulls: [Pulls]) -> Void){
    let urlApi = URL(string: "https://api.github.com/repos/\(login)/\(name)/pulls")
    print(urlApi)
    guard let url = urlApi  else { return }
    URLSession.shared.dataTask(with: url) {(data, response, err)in
        guard let data = data else {return}
        do {
            let pullsRequest = try JSONDecoder().decode([Pulls].self, from: data)
            print(pullsRequest)
            
            onComplete(pullsRequest)
        } catch  {
            print(error.localizedDescription)
        }
        }.resume()
}
