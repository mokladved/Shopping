//
//  SearchResultCollectionViewCell.swift
//  Shopping
//
//  Created by Youngjun Kim on 7/27/25.
//

import UIKit
import Kingfisher
import SnapKit

class SearchResultCollectionViewCell: UICollectionViewCell {
    static let identifier = Title.SearchResultCVCIdentifier
    
    let favoriteButton = {
        let button = UIButton()
        button.configuration = .circleStyle(from: "heart")
        return button
    }()
    
    let imageView = {
        let imaageView = UIImageView()
        return imaageView
    }()
    
    
    
    let mallNameLabel = {
        let label = UILabel()
        label.textColor = .white
        return label
    }()
    
    let productNameLabel = {
        let label = UILabel()
        label.textColor = .white
        label.numberOfLines = 2
        return label
    }()
    
    let priceLabel = {
        let label = UILabel()
        label.textColor = .white
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureHierarchy()
        configureLayout()
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension SearchResultCollectionViewCell: UIConfigurable {
    func configureHierarchy() {
        contentView.addSubview(imageView)
        imageView.addSubview(favoriteButton)
        contentView.addSubview(mallNameLabel)
        contentView.addSubview(productNameLabel)
        contentView.addSubview(priceLabel)
    }
    
    func configureLayout() {
        imageView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalToSuperview()
            make.height.equalTo(imageView.snp.width)
        }
        favoriteButton.snp.makeConstraints { make in
            make.trailing.bottom.equalToSuperview().inset(8)
            make.size.equalTo(30)
        }
        
        mallNameLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(8)
            make.horizontalEdges.equalToSuperview().inset(8)
        }
        
        productNameLabel.snp.makeConstraints { make in
            make.top.equalTo(mallNameLabel.snp.bottom).offset(4)
            make.horizontalEdges.equalToSuperview().inset(8)
        }
        
        priceLabel.snp.makeConstraints { make in
            make.top.equalTo(productNameLabel.snp.bottom).offset(8)
            make.horizontalEdges.equalToSuperview().inset(8)
            make.bottom.equalToSuperview().inset(8)
        }
    }
    
    func configureView() {
        contentView.backgroundColor = .clear
    }
}


extension SearchResultCollectionViewCell: DataConfigurable {
    typealias Data = Item
    
    func configure(from data: Item) {
        guard let imageUrl = URL(string: data.image) else {
            return
        }
        
        imageView.kf.setImage(
            with: imageUrl,
            placeholder: nil,
            options: [
                .processor(DownsamplingImageProcessor(size: imageView.bounds.size)),
                .scaleFactor(UIScreen.main.scale),
                .cacheOriginalImage
            ]
        )
        mallNameLabel.text = data.mallName
        priceLabel.text = data.lprice
        productNameLabel.text = data.title
    }
}
