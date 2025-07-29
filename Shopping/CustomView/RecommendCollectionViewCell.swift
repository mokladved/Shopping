//
//  RecommendCollectionViewCell.swift
//  Shopping
//
//  Created by Youngjun Kim on 7/29/25.
//

import UIKit
import Kingfisher
import SnapKit

class RecommendCollectionViewCell: BaseCollectionViewCell {
    let identifier = Title.recommendCVCIdentifier
    
    let imageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    override func configure(from data: Item) {
        
    }
    
    override func configureHierarchy() {
        contentView.addSubview(imageView)
    }
    
    override func configureLayout() {
        
    }
    
    override func configureView() {
        super.configureView()
    }
}
