//
//  ResultViewController.swift
//  Shopping
//
//  Created by Youngjun Kim on 7/27/25.
//

import UIKit

class SearchResultViewController: UIViewController {
    var shoppingItems: [Item] = []
    var keyword: String?
    
    lazy var collectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = UIConstants.spacing * 2
        layout.minimumInteritemSpacing = UIConstants.spacing

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
            
        collectionView.delegate = self
        collectionView.dataSource = self
            
        collectionView.register(SearchResultCollectionViewCell.self, forCellWithReuseIdentifier: SearchResultCollectionViewCell.identifier)
        
        return collectionView
    }()
    
    let viewWrappedStackView = {
        let view = UIView()
        return view
    }()
    
    let stackViewWrapeedButton = {
        let stackView = UIStackView()
        return stackView
    }()
    
    let simSortButton = {
        let button = UIButton()
        return button
    }()
    
    let dateSortButton = {
        let button = UIButton()
        return button
    }()
    
    let highPriceSortButton = {
        let button = UIButton()
        return button
    }()
    
    let lowPriceSortButton = {
        let button = UIButton()
        return button
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

}

extension SearchResultViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 0, height: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchResultCollectionViewCell.identifier, for: indexPath) as! SearchResultCollectionViewCell
        return cell
    }
}

extension SearchResultViewController: UIConfigurable {
    func configureHierarchy() {
        view.addSubview(viewWrappedStackView)
        viewWrappedStackView.addSubview(stackViewWrapeedButton)
        stackViewWrapeedButton.addSubview(simSortButton)
        stackViewWrapeedButton.addSubview(dateSortButton)
        stackViewWrapeedButton.addSubview(highPriceSortButton)
        stackViewWrapeedButton.addSubview(lowPriceSortButton)
    }
    
    func configureLayout() {
        
    }
    
    func configureView() {
        view.backgroundColor = .black
        navigationItem.title = keyword
    }
}
