//
//  SearchResultCollectionViewCell.swift
//  Shopping
//
//  Created by Youngjun Kim on 7/27/25.
//

import UIKit
import Kingfisher
import SnapKit

final class SearchResultCollectionViewCell: UICollectionViewCell {
    static let identifier = Constants.Title.SearchResultCVCIdentifier
    
    var viewModel: SearchResultCellViewModel?
    
    private let favoriteButton = {
        let button = UIButton()
        button.configuration = .circleStyle(from: "heart")
        return button
    }()
    
    private let imageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let mallNameLabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12)
        label.textColor = .systemGray
        return label
    }()
    
    private let productNameLabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textColor = .white
        label.numberOfLines = 2
        return label
    }()
    
    private let priceLabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .bold)
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
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    
    func configure(from data: SearchResultCellViewModel) {
        self.viewModel = data

        mallNameLabel.text = data.mallName
        productNameLabel.text = data.productName
        priceLabel.text = data.price
        
        imageView.kf.setImage(
            with: data.imageURL,
            placeholder: nil,
            options: [
                .processor(DownsamplingImageProcessor(size: imageView.bounds.size)),
                .scaleFactor(UIScreen.main.scale),
                .cacheOriginalImage
            ]
        )
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
