//
//  SearchResultCellViewModel.swift
//  Shopping
//
//  Created by Youngjun Kim on 8/13/25.
//

import Foundation

final class SearchResultCellViewModel {
    
    let imageURL: URL?
    let mallName: String
    let productName: String
    let price: String
    
    init(item: Item) {
        self.imageURL = URL(string: item.image)
        self.mallName = item.mallName
        self.productName = item.title.removedTags
        
        if let priceValue = Int(item.lprice) {
            self.price = priceValue.formatted()
        } else {
            self.price = item.lprice
        }
    }
}
