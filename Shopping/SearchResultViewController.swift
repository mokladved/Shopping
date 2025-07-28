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
        collectionView.backgroundColor = .clear
            
        collectionView.delegate = self
        collectionView.dataSource = self
            
        collectionView.register(SearchResultCollectionViewCell.self, forCellWithReuseIdentifier: SearchResultCollectionViewCell.identifier)
        
        return collectionView
    }()
    
    let countLabel = {
        let label = UILabel()
        label.textColor = .systemGreen
        label.font = .systemFont(ofSize: 14, weight: .bold)
        label.text = "1111111"
        return label
    }()
    
    let stackViewWrapeedButton = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 8
        return stackView
    }()
    
    let simSortButton = {
        let button = UIButton()
        button.configuration = .unselectedSortButton(title: Title.simSortButton)
        return button
    }()
    
    let dateSortButton = {
        let button = UIButton()
        button.configuration = .unselectedSortButton(title: Title.dateSortButton)
        return button
    }()
    
    let highPriceSortButton = {
        let button = UIButton()
        button.configuration = .unselectedSortButton(title: Title.highPriceSortButton)
        return button
    }()
    
    let lowPriceSortButton = {
        let button = UIButton()
        button.configuration = .unselectedSortButton(title: Title.lowPriceSortButton)
        return button
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureHierarchy()
        configureLayout()
        configureView()
        
    }

}

extension SearchResultViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return shoppingItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = UIConstants.cellWidth()
        let height = width * 1.6
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchResultCollectionViewCell.identifier, for: indexPath) as! SearchResultCollectionViewCell
        let item = shoppingItems[indexPath.item]
        cell.configure(from: item)
        
        return cell
    }
}

extension SearchResultViewController: UIConfigurable {
    func configureHierarchy() {
        view.addSubview(countLabel)
        view.addSubview(collectionView)
            
        view.addSubview(stackViewWrapeedButton)
        
        stackViewWrapeedButton.addArrangedSubview(simSortButton)
        stackViewWrapeedButton.addArrangedSubview(dateSortButton)
        stackViewWrapeedButton.addArrangedSubview(highPriceSortButton)
        stackViewWrapeedButton.addArrangedSubview(lowPriceSortButton)
    }
    
    func configureLayout() {
        countLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(16)
            make.leading.equalTo(view.safeAreaLayoutGuide).inset(16)
        }
        
        stackViewWrapeedButton.snp.makeConstraints { make in
            make.top.equalTo(countLabel.snp.bottom).offset(8)
            make.leading.equalTo(view.safeAreaLayoutGuide).inset(16)
            make.height.equalTo(36)
        }

        collectionView.snp.makeConstraints { make in
            make.top.equalTo(stackViewWrapeedButton.snp.bottom).offset(16)
            make.horizontalEdges.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    func configureView() {
        view.backgroundColor = .black
        navigationItem.title = keyword
    }
}
