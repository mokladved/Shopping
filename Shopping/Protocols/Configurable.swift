//
//  Configurable.swift
//  Shopping
//
//  Created by Youngjun Kim on 7/27/25.
//

import Foundation

protocol Configurable {
    associatedtype Data
    func configure(from data: Data)
}
