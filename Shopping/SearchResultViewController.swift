//
//  ResultViewController.swift
//  Shopping
//
//  Created by Youngjun Kim on 7/27/25.
//

import UIKit
import Alamofire

final class SearchResultViewController: UIViewController {
    var shoppingItems: [Item] = []
    var keyword: String?
    private var selectedSortOption: Sorting = .sim
    var total = 0
    private var start = 1
    private let paginationStandard = 30
    
    private lazy var collectionView = {
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
    
    private let countLabel = {
        let label = UILabel()
        label.textColor = .systemGreen
        label.font = .systemFont(ofSize: 14, weight: .bold)
        return label
    }()
    
    private let stackViewWrapeedButton = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 8
        return stackView
    }()
    
    private let simSortButton = {
        let button = UIButton()
        button.configuration = .unselectedSortButton()
        button.setTitle(Title.simSortButton, for: .normal)
        return button
    }()
    
    private let dateSortButton = {
        let button = UIButton()
        button.configuration = .unselectedSortButton()
        button.setTitle(Title.dateSortButton, for: .normal)
        return button
    }()
    
    private let highPriceSortButton = {
        let button = UIButton()
        button.configuration = .unselectedSortButton()
        button.setTitle(Title.highPriceSortButton, for: .normal)
        return button
    }()
    
    private let lowPriceSortButton = {
        let button = UIButton()
            button.configuration = .unselectedSortButton()
            button.setTitle(Title.lowPriceSortButton, for: .normal)
        return button
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureHierarchy()
        configureLayout()
        configureView()
        configureButtonActions()
        configureSortButtonUI()
    }
    
    private func configureButtonActions() {
        simSortButton.addTarget(self, action: #selector(sortButtonTapped), for: .touchUpInside)
        dateSortButton.addTarget(self, action: #selector(sortButtonTapped), for: .touchUpInside)
        highPriceSortButton.addTarget(self, action: #selector(sortButtonTapped), for: .touchUpInside)
        lowPriceSortButton.addTarget(self, action: #selector(sortButtonTapped), for: .touchUpInside)
    }
    
    @objc private func sortButtonTapped(_ sender: UIButton) {
        switch sender {
        case simSortButton:
            selectedSortOption = .sim
        case dateSortButton:
            selectedSortOption = .date
        case highPriceSortButton:
            selectedSortOption = .highPrice
        case lowPriceSortButton:
            selectedSortOption = .lowPrice
        default:
            break
        }
        
        self.start = 1
        self.shoppingItems.removeAll()
        self.collectionView.reloadData()
        
        configureSortButtonUI()
        callRequest(sort: selectedSortOption)
    }
    
    private func configureSortButtonUI() {
        simSortButton.configureButton(isSelected: selectedSortOption == .sim)
        dateSortButton.configureButton(isSelected: selectedSortOption == .date)
        highPriceSortButton.configureButton(isSelected: selectedSortOption == .highPrice)
        lowPriceSortButton.configureButton(isSelected: selectedSortOption == .lowPrice)
    }

}

extension SearchResultViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == (shoppingItems.count - 3) && shoppingItems.count < total  {
            callRequest(sort: selectedSortOption)
        }
    }
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
            make.leading.equalTo(view.safeAreaLayoutGuide).inset(12)
        }
        
        stackViewWrapeedButton.snp.makeConstraints { make in
            make.top.equalTo(countLabel.snp.bottom).offset(8)
            make.leading.equalTo(view.safeAreaLayoutGuide).inset(12)
            make.height.equalTo(36)
        }

        collectionView.snp.makeConstraints { make in
            make.top.equalTo(stackViewWrapeedButton.snp.bottom).offset(16)
            make.horizontalEdges.bottom.equalTo(view.safeAreaLayoutGuide).inset(12)
        }
    }
    
    func configureView() {
        view.backgroundColor = .black
        navigationItem.title = keyword
        countLabel.text = "\(total.formatted())개의 검색 결과"

    }
}


extension SearchResultViewController {
    private func callRequest(sort: Sorting) {
        guard let keyword = keyword else {
            return
        }
        
        let target = URLs.shopping(for: keyword, display: paginationStandard, sort: sort)
        
        guard let url = target.url else {
            return
        }
        
        let headers = target.headers
        AF.request(url, method: .get, headers: headers)
            .validate(statusCode: 200..<300)
            .responseDecodable(of: ShopItem.self) { response in
                switch response.result {
                case .success(let value):
                    self.shoppingItems.append(contentsOf: value.items)
                    self.start += value.items.count
                    self.collectionView.reloadData()
                    self.countLabel.text = "\(value.total.formatted()) 개의 검색 결과"
                    
                    if self.start == 1 {
                        self.collectionView.scrollToItem(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
                    }
                case .failure(let error):
                    print(error)
                }
            }
    }
}
