//
//  NetworkError.swift
//  Shopping
//
//  Created by Youngjun Kim on 7/29/25.
//

import Foundation

enum NetworkError: Error {
    case badRequest
    case unauthorized
    case forbidden
    case notFound
    case tooManyRequests
    case serverError
    case serviceUnavailable
    
    var errorMessage: String {
        switch self {
        case .badRequest:
            return "400: 잘못된 요청입니다."
        case .unauthorized:
            return "401: 인증 정보가 유효하지 않습니다."
        case .forbidden:
            return "403: 접근 권한이 없습니다."
        case .notFound:
            return "404: 페이지를 찾을 수 없습니다."
        case .tooManyRequests:
            return "429: 요청 횟수를 초과했습니다. 잠시 후 다시 시도해주세요."
        case .serverError:
            return "500: 서버에 문제가 발생했습니다."
        case .serviceUnavailable:
            return "503: 서비스 점검 중입니다. 잠시 후 다시 시도해주세요."
        }
    }
}
