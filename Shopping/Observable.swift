//
//  Observable.swift
//  Shopping
//
//  Created by Youngjun Kim on 8/13/25.
//

import Foundation

class Observable<T> {
    private var action: (() -> Void)?
    
    var value: T {
        didSet {
            action?()
        }
    }
    
    init(_ value: T) {
        self.value = value
    }
    
    func bind(action: @escaping () -> Void) {
        action()
        self.action = action
    }
}
