//
//  SearchResultCollectionViewCell.swift
//  Shopping
//
//  Created by Youngjun Kim on 7/27/25.
//

import UIKit
import Kingfisher

class SearchResultCollectionViewCell: UICollectionViewCell {
    static let identifier = Title.SearchResultCVCIdentifier

    var data: ShopItem?
    
    let viewWrappedImageView = {
        let view = UIView()
        return view
    }()
    
    let favoriteButton = {
        let button = UIButton()
        button.configuration = .circleStyle(from: "heart")
        return button
    }()
    
    let imageView = {
        let imaageView = UIImageView()
        imaageView.image = UIImage(systemName: "heart")
        return imaageView
    }()
    
    
    
    let mallNameLabel = {
        let label = UILabel()
        label.text = "상점명"
        return label
    }()
    
    let productNameLabel = {
        let label = UILabel()
        label.text = "상품명"
        label.numberOfLines = 2
        return label
    }()
    
    let priceLabel = {
        let label = UILabel()
        label.text = "가격"
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
        contentView.addSubview(viewWrappedImageView)
        viewWrappedImageView.addSubview(imageView)
        viewWrappedImageView.addSubview(favoriteButton)
        contentView.addSubview(mallNameLabel)
        contentView.addSubview(productNameLabel)
        contentView.addSubview(priceLabel)
    }
    
    func configureLayout() {
        
    }
    
    func configureView() {
        contentView.backgroundColor = .clear
    }
    
    
}
