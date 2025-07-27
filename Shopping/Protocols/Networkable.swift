//
//  Networkable.swift
//  Shopping
//
//  Created by Youngjun Kim on 7/27/25.
//

import Foundation

protocol Networkable {
    associatedtype Data
    func configure(for data: Data)
}
