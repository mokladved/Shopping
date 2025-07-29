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
    
    func callShopItemRequest(target: URLs, success: @escaping (ShopItem) -> Void, failure: @escaping (NetworkError) -> Void) {
        guard let url = target.url else {
            return
        }
        
        let headers = target.headers
        
        AF.request(url, method: .get, headers: headers)
            .validate(statusCode: 200..<300)
            .responseDecodable(of: ShopItem.self) { response in
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
