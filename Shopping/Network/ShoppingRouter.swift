//
//  ShoppingRouter.swift
//  Shopping
//
//  Created by Youngjun Kim on 8/14/25.
//

import Foundation
import Alamofire

enum ShoppingRouter {
    case keyword(query: String, display: Int, sort: Sorting, start: Int)
    
    static func keyword(for query: String, display: Int = 100, sort: Sorting = .sim, start: Int = 1) -> Self {
        return .keyword(query: query, display: display, sort: sort, start: start)
    }
    
    var headers: HTTPHeaders {
        switch self {
        case .keyword:
            return [
                "X-Naver-Client-ID": APIKeys.clientID,
                "X-Naver-Client-Secret": APIKeys.clientSecret
            ]
        }
    }
    
    var baseURL: String {
        return Constants.API.baseURL
    }
    
    var endpoint: URL? {
        switch self {
        case .keyword(let query, let display, let sort, let start):
            let url = "\(baseURL)\(Constants.API.path)"
            var components = URLComponents(string: url)
            components?.queryItems = [
                URLQueryItem(name: "query", value: query),
                URLQueryItem(name: "display", value: "\(display)"),
                URLQueryItem(name: "sort", value: sort.rawValue),
                URLQueryItem(name: "start", value: "\(start)"),
            ]
            
            return components?.url
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .keyword:
            return .get
        }
    }
}


