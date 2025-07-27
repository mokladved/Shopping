//
//  UIConstants.swift
//  Shopping
//
//  Created by Youngjun Kim on 7/28/25.
//

import UIKit

struct UIConstants {
    static let spacing: CGFloat = 8
    static let columns: CGFloat = 2
    static func cellWidth() -> CGFloat {
        let deviceWidth = UIScreen.main.bounds.width
        return (deviceWidth - spacing * (columns + 1)) / columns
    }
}
