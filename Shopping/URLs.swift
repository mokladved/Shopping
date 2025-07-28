//
//  Urls.swift
//  Shopping
//
//  Created by Youngjun Kim on 7/27/25.
//

import Foundation
import Alamofire


enum URLs {
    case shopping(query: String, display: Int, sort: Sorting, start: Int)
    
    static let baseURL = "https://openapi.naver.com/"
    static let path = "v1/search/shop.json"
    
    static func shopping(for query: String, display: Int = 100, sort: Sorting = .sim, start: Int = 1) -> Self {
        return .shopping(query: query, display: display, sort: sort, start: start)
    }
    
    var headers: HTTPHeaders {
        switch self {
        case .shopping:
            return [
                "X-Naver-Client-Id": APIKeys.clientID,
                "X-Naver-Client-Secret": APIKeys.clientSecret
            ]
        }
    }
    
    var url: URL? {
        switch self {
        case .shopping(let query, let display, let sort, let start):
            let url = "\(URLs.baseURL)\(URLs.path)"
            var components = URLComponents(string: url)
                components?.queryItems = [
                    URLQueryItem(name: "query", value: query),
                    URLQueryItem(name: "display", value: "\(display)"),
                    URLQueryItem(name: "sort", value: sort.rawValue),
                    URLQueryItem(name: "start", value: "\(start)")
                ]

            return components?.url
        }
    }
}
