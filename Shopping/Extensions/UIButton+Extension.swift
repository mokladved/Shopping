//
//  UIButton+Extension.swift
//  Shopping
//
//  Created by Youngjun Kim on 7/25/25.
//

import UIKit

extension UIButton.Configuration {
    static func filledStyle(title: String) -> UIButton.Configuration {
        var configuration = UIButton.Configuration.filled()
        configuration.cornerStyle = .large
        configuration.baseBackgroundColor = .white
        configuration.baseForegroundColor = .black
        
        var attributedTitle = AttributedString(title)
        attributedTitle.font = .systemFont(ofSize: 17, weight: .bold)
        configuration.attributedTitle = attributedTitle
        return configuration
    }
    
}
