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
    static let identifier = Constants.Title.recommendCVCIdentifier
    
    let imageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    override func configure(from data: Item) {
        let imageURL = URL(string: data.image)
        guard let url = imageURL else {
            return
        }
        imageView.kf.setImage(
            with: url,
            placeholder: nil,
            options: [
                .processor(DownsamplingImageProcessor(size: imageView.bounds.size)),
                .scaleFactor(UIScreen.main.scale),
                .cacheOriginalImage
            ])
    }
    
    override func configureHierarchy() {
        contentView.addSubview(imageView)
    }
    
    override func configureLayout() {
        imageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(16)
            make.top.bottom.equalToSuperview()
            make.height.equalTo(imageView.snp.width)
        }
    }
    
    override func configureView() {
        super.configureView()
    }
}
