//
//  UIConstants.swift
//  Shopping
//
//  Created by Youngjun Kim on 7/28/25.
//

import UIKit

enum Constants {
    enum UI {
        enum Vertical {
            static let spacing: CGFloat = 12
            static let columns: CGFloat = 2
            static var cellWidth: CGFloat {
                let deviceWidth = UIScreen.main.bounds.width
                return (deviceWidth - spacing * (columns + 1)) / columns
            }
            
        }
        enum Horizontal {
            static let spacing: CGFloat = 2
            static let columns: CGFloat = 4
            static var cellWidth: CGFloat {
                let deviceWidth = UIScreen.main.bounds.width
                return (deviceWidth - spacing * (columns + 1)) / columns
            }
        }
    }
    
    enum Title {
        static let homeVCImageDescription = "쇼핑하구팡"
        static let navTitle = "영캠러의 쇼핑쇼핑"
        static let placeholder = "브랜드, 상품, 프로필, 태그 등"
        static let SearchResultCVCIdentifier = "SearchResultCollectionViewCell"
        static let simSortButton = "정확도"
        static let dateSortButton = "날짜순"
        static let highPriceSortButton = "가격높은순"
        static let lowPriceSortButton = "가격낮은순"
        static let recommendCVCIdentifier = "RecommendCollectionViewCell"
    }
    
    enum API {
        static let baseURL = "https://openapi.naver.com/"
        static let path = "v1/search/shop.json"
        static let paginationStandards = 30
    }
}
