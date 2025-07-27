//
//  ShopItem.swift
//  Shopping
//
//  Created by Youngjun Kim on 7/27/25.
//

import Foundation

struct ShopItem: Decodable {
    let total: Int
    let items: [Item]
}

struct Item: Decodable {
    let title: String
    let image: String
    let mallName: String
    let lprice: String
}
