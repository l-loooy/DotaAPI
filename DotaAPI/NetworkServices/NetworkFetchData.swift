//
//  NetworkFetchData.swift
//  DotaAPI
//
//  Created by admin on 10.09.2022.
//  Copyright © 2022 Sergey Lolaev. All rights reserved.
//

import Foundation

class NetworkFetchData {
    
    static let shared = NetworkFetchData()
    //было func fetchHeroWith(_ urlString: String, response: @escaping (HeroModel?, Error?) -> Void)
    func fetchHeroWith(_ urlString: String, response: @escaping ([HeroModel]?, Error?) -> Void) {
        
        NetworkRequest.shared.requestDataWith(urlString) { result in
            
            switch result {
            case .success(let data):
                //parse JSON here:
                do {
                    //было let hero = try JSONDecoder().decode(HeroModel.self, from: data)
                    let hero = try JSONDecoder().decode([HeroModel].self, from: data)
                    response(hero, nil)
                } catch let jsonError {
                    print("Failed to decode with Json, reason:", jsonError)
                }
            case .failure(let error):
                response(nil, error)
                print("Fail with error to request data: \(error.localizedDescription)")
            }
        }
    }
}
