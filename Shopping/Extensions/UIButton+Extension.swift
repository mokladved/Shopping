//
//  UIButton+Extension.swift
//  Shopping
//
//  Created by Youngjun Kim on 7/25/25.
//

import UIKit

extension UIButton {
    func configureButton(isSelected: Bool) {
        self.configuration = isSelected ? .selectedSortButton() : .unselectedSortButton()
    }
}

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
    
    @available(iOS 15.0, *)
    static func selectedSortButton() -> UIButton.Configuration {
        var configuration = UIButton.Configuration.filled()
        configuration.baseBackgroundColor = .white
        configuration.baseForegroundColor = .black
        configuration.cornerStyle = .capsule
        
        configuration.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer({ title in
            var title = title
            title.font = .systemFont(ofSize: 14, weight: .bold)
            return title
        })
        configuration.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 4, bottom: 2, trailing: 4)

        return configuration
    }
    
    @available(iOS 15.0, *)
    static func unselectedSortButton() -> UIButton.Configuration {
        var configuration = UIButton.Configuration.plain()
        configuration.baseForegroundColor = .white
        configuration.background.strokeColor = .white
        configuration.background.strokeWidth = 1.0
        
        configuration.cornerStyle = .fixed
        configuration.background.cornerRadius = 5
        
        configuration.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer({ title in
            var title = title
            title.font = .systemFont(ofSize: 14, weight: .bold)
            return title
        })
        configuration.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 4, bottom: 2, trailing: 4)

        return configuration
    }
}
