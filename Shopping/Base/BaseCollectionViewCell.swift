//
//  BaseCollectionViewCell.swift
//  Shopping
//
//  Created by Youngjun Kim on 7/29/25.
//

import UIKit

class BaseCollectionViewCell: UICollectionViewCell, DataConfigurable, UIConfigurable {
    typealias Data = Item
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureHierarchy()
        configureLayout()
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(from data: Item) {

    }
    
    func configureHierarchy() {
        
    }
    
    func configureLayout() {
        
    }
    
    func configureView() {
        contentView.backgroundColor = .clear
    }
     
}
