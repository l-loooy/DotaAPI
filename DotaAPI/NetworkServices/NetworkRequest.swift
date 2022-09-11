//
//  NetworkRequest.swift
//  DotaAPI
//
//  Created by admin on 09.09.2022.
//  Copyright © 2022 Sergey Lolaev. All rights reserved.
//

import Foundation

protocol NetworkRequestProtocol {
    func requestDataWith(_ urlString: String, completion: @escaping (Result<Data, Error>) -> Void)
}

class NetworkRequest: NetworkRequestProtocol {
    
    static let shared = NetworkRequest()
    
    func requestDataWith(_ urlString: String, completion: @escaping (Result<Data, Error>) -> Void) {
        guard let url = URL(string: urlString) else {
            return
        }
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            DispatchQueue.main.async {
                if let error = error {
                    completion(.failure(error))
                }
                guard let safeData = data else {
                    return
                }
                completion(.success(safeData))
//                let stringData = String(data: safeData, encoding: .utf8)
//                print(stringData!)
            }
        }
        task.resume()
    }
}



