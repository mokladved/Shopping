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
    
    static func circleStyle(from name: String) -> UIButton.Configuration {
        var configuration = UIButton.Configuration.filled()
        configuration.cornerStyle = .capsule
        configuration.baseBackgroundColor = .white
        configuration.baseForegroundColor = .black
        
        configuration.image = UIImage(systemName: name)
        
        return configuration
    }
    
    static func selectedSortButton(title: String) -> UIButton.Configuration {
        var configuration = UIButton.Configuration.filled()
        configuration.title = title
        configuration.baseBackgroundColor = .white
        configuration.baseForegroundColor = .black
        configuration.cornerStyle = .capsule
        
        configuration.attributedTitle?.font = .systemFont(ofSize: 14, weight: .bold)
        
        return configuration
    }
    
    static func unselectedSortButton(title: String) -> UIButton.Configuration {
        var configuration = UIButton.Configuration.plain()
        configuration.title = title
        configuration.baseForegroundColor = .white
        
        configuration.background.strokeColor = .white
        configuration.background.strokeWidth = 1.0
        
        configuration.cornerStyle = .fixed
        configuration.background.cornerRadius = 5
        
        configuration.attributedTitle?.font = .systemFont(ofSize: 14)

        return configuration
    }
    
}
