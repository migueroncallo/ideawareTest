//
//  API.swift
//  Ideaware Test
//
//  Created by Miguel Roncallo on 5/27/19.
//  Copyright © 2019 Miguel Roncallo. All rights reserved.
//

import Foundation
import Alamofire

class MainAPI{
    static let shared = MainAPI()
    
    
    func getPosts(page: Int, _ cb: @escaping([Post]?, Error?)->()){
        guard let url = URL(string: "\(baseURL)\(page).json") else { return }
        
        Alamofire.request(url, method: .get)
        .validate()
            .responseJSON { (response) in
                switch response.result{
                case .success:
                    let decoder = JSONDecoder()
                    let posts = try! decoder.decode([Post].self, from: response.data!)
                    
                    cb(posts,nil)
                case .failure(let e):
                    cb(nil, e)
                }
                
        }
    }
}
