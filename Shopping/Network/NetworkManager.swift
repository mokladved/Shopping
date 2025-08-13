//
//  NetworkManager.swift
//  Shopping
//
//  Created by Youngjun Kim on 7/30/25.
//

import Foundation
import Alamofire

final class NetworkManager {

    static let shared = NetworkManager()

    private init() { }
    
    func callRequest<T: Decodable>(api: ShoppingRouter, type: T.Type, success: @escaping (T) -> Void, failure: @escaping (NetworkError) -> Void) {
        let endpoint = api.endpoint
        guard let url = endpoint else {
            return
        }

        let headers = api.headers
        
        AF.request(url, method: api.method, headers: headers)
            .validate(statusCode: 200..<300)
            .responseDecodable(of: T.self) { response in
                switch response.result {
                case .success(let value):
                    success(value)
                    
                case .failure:
                    guard let statusCode = response.response?.statusCode else {
                        return
                    }
                    if let error = NetworkError(rawValue: statusCode) {
                        failure(error)
                    } else {
                        failure(.unknown)
                    }
                }
            }
    }
}
