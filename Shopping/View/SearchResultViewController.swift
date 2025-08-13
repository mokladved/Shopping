//
//  ResultViewController.swift
//  Shopping
//
//  Created by Youngjun Kim on 7/27/25.
//

import UIKit
import Alamofire
import SnapKit

final class SearchResultViewController: UIViewController {
    var viewModel: SearchResultViewModel!
    
    private lazy var collectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = Constants.UI.Vertical.spacing * 2
        layout.minimumInteritemSpacing = Constants.UI.Vertical.spacing

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
                
        collectionView.delegate = self
        collectionView.dataSource = self
                
        collectionView.register(SearchResultCollectionViewCell.self, forCellWithReuseIdentifier: SearchResultCollectionViewCell.identifier)
        
        return collectionView
    }()
    
    private lazy var recommendCollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = Constants.UI.Horizontal.spacing

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear

        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(RecommendCollectionViewCell.self, forCellWithReuseIdentifier: RecommendCollectionViewCell.identifier)
        collectionView.showsHorizontalScrollIndicator = false
        
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
        button.setTitle(Constants.Title.simSortButton, for: .normal)
        return button
    }()
    
    private let dateSortButton = {
        let button = UIButton()
        button.configuration = .unselectedSortButton()
        button.setTitle(Constants.Title.dateSortButton, for: .normal)
        return button
    }()
    
    private let highPriceSortButton = {
        let button = UIButton()
        button.configuration = .unselectedSortButton()
        button.setTitle(Constants.Title.highPriceSortButton, for: .normal)
        return button
    }()
    
    private let lowPriceSortButton = {
        let button = UIButton()
        button.configuration = .unselectedSortButton()
        button.setTitle(Constants.Title.lowPriceSortButton, for: .normal)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureHierarchy()
        configureLayout()
        configureView()
        configureButtonActions()
        
        bindData()
        
        viewModel.viewDidLoad()
    }
    
    private func bindData() {
        viewModel.outputShoppingItems.bind { [weak self] in
            guard let self = self else {
                return
            }
            self.collectionView.reloadData()
        }
        
        viewModel.outputRecommendedItems.bind { [weak self] in
            guard let self = self else {
                return
            }
            self.recommendCollectionView.reloadData()
        }
        
        viewModel.outputTotalCountText.bind { [weak self] in
            guard let self = self else {
                return
            }
            self.countLabel.text = self.viewModel.outputTotalCountText.value
        }
        
        viewModel.outputSelectedSortOption.bind { [weak self] in
            guard let self = self else {
                return
            }
            
            let selectedOption = self.viewModel.outputSelectedSortOption.value
            self.configureSortButtonUI(selected: selectedOption)
        }
        
        viewModel.outputErrorMessage.bind { [weak self] in
            guard let self = self else {
                return
            }
            
            guard let message = self.viewModel.outputErrorMessage.value else {
                return
            }
            
            self.showAlert(message: message)
        }
        
        viewModel.scrollTrigger.bind { [weak self] in
            guard let self = self,
                  self.viewModel.scrollTrigger.value != nil else {
                return
            }
            self.collectionView.scrollToItem(at: IndexPath(row: 0, section: 0), at: .top, animated: false)
        }
        
        viewModel.ouputTitle.bind { [weak self] in
            guard let self = self else {
                return
            }
            self.navigationItem.title = title
        }
    }
    
    
    private func configureButtonActions() {
        simSortButton.addTarget(self, action: #selector(sortButtonTapped), for: .touchUpInside)
        dateSortButton.addTarget(self, action: #selector(sortButtonTapped), for: .touchUpInside)
        highPriceSortButton.addTarget(self, action: #selector(sortButtonTapped), for: .touchUpInside)
        lowPriceSortButton.addTarget(self, action: #selector(sortButtonTapped), for: .touchUpInside)
    }
    
    @objc private func sortButtonTapped(_ sender: UIButton) {
        var option: Sorting = .sim
        switch sender {
        case simSortButton:
            option = .sim
        case dateSortButton:
            option = .date
        case highPriceSortButton:
            option = .highPrice
        case lowPriceSortButton:
            option = .lowPrice
        default:
            break
        }
        
        viewModel.sortOptionTrigger.value = option
    }
}


extension SearchResultViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
            viewModel.lastPageTrigger.value = indexPath.row
        }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.collectionView {
            return viewModel.outputShoppingItems.value.count
        } else {
            return min(Constants.API.maxDisplayRecommendItem, viewModel.outputRecommendedItems.value.count)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == self.collectionView {
            let width = Constants.UI.Vertical.cellWidth
            let height = width * 1.6
            return CGSize(width: width, height: height)
        } else {
            let width = Constants.UI.Horizontal.cellWidth
            let height = width
            return CGSize(width: width, height: height)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.collectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchResultCollectionViewCell.identifier, for: indexPath) as! SearchResultCollectionViewCell
            let item = viewModel.outputShoppingItems.value[indexPath.item]
            let viewMdoel = SearchResultCellViewModel(item: item)
            cell.configure(from: viewMdoel)
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecommendCollectionViewCell.identifier, for: indexPath) as! RecommendCollectionViewCell
            let item = viewModel.outputRecommendedItems.value[indexPath.item]
            let viewModel = RecommendCellViewModel(item: item)
            cell.configure(from: viewModel)
            return cell
        }
    }
}


extension SearchResultViewController: UIConfigurable {
    
    func configureHierarchy() {
        view.addSubview(countLabel)
        view.addSubview(collectionView)
        view.addSubview(recommendCollectionView)
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
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(12)
        }
        
        recommendCollectionView.snp.makeConstraints { make in
            make.top.equalTo(collectionView.snp.bottom).offset(24)
            make.horizontalEdges.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(12)
            make.height.equalTo(Constants.UI.Horizontal.cellWidth)
        }
    }
    
    func configureView() {
        view.backgroundColor = .black
    }
    
    private func configureSortButtonUI(selected: Sorting) {
        simSortButton.configureButton(isSelected: selected == .sim)
        dateSortButton.configureButton(isSelected: selected == .date)
        highPriceSortButton.configureButton(isSelected: selected == .highPrice)
        lowPriceSortButton.configureButton(isSelected: selected == .lowPrice)
    }
}
