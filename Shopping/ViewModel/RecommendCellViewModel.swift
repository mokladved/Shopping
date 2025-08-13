//
//  RecommendCellViewModel.swift
//  Shopping
//
//  Created by Youngjun Kim on 8/13/25.
//

import Foundation

final class RecommendCellViewModel {
    let imageURL: URL?
    
    init(item: Item) {
        self.imageURL = URL(string: item.image)
    }
}
