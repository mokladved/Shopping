//
//  HomeViewController.swift
//  Shopping
//
//  Created by Youngjun Kim on 7/26/25.
//

import UIKit
import Alamofire
import SnapKit

final class HomeViewController: BaseViewController {
    private let viewModel = HomeViewModel()
    
    private let searchBar = {
        let bar = UISearchBar()
        bar.backgroundColor = .black
        bar.backgroundImage = UIImage()
        bar.barTintColor = .clear
        
        let textField = bar.searchTextField
        textField.backgroundColor = .myBGDarkGray
        textField.textColor = .white
        textField.layer.cornerRadius = 8
        textField.clipsToBounds = true
        
        textField.attributedPlaceholder = NSAttributedString(
            string: Constants.Title.placeholder,
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.myFGLightGray]
        )
        
        if let leftView = textField.leftView as? UIImageView {
            leftView.tintColor = .myFGLightGray
        }

        return bar
    }()
    
    private let stackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 64
        return stackView
    }()
    
    private let backImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(resource: .shoppingMan)
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let descLabel = {
        let label = UILabel()
        label.textColor = .white
        label.text = Constants.Title.homeVCImageDescription
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 18, weight: .bold)
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindData()
    }
    
    override func configureHierarchy() {
        view.addSubview(stackView)
        view.addSubview(searchBar)
        stackView.addArrangedSubview(backImageView)
        stackView.addArrangedSubview(descLabel)
    }
    
    override func configureLayout() {
        stackView.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
            make.size.equalTo(300)
        }
        searchBar.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(16)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(8)
        }
    }
    
    override func configureView() {
        super.configureView()
        configureBackButtonUI()
        navigationItem.title = Constants.Title.navTitle
        searchBar.delegate = self
    }
    
    private func bindData() {
        viewModel.pushTrigger.bind { [weak self] in
            guard let self = self,
                  self.viewModel.pushTrigger.value != nil else {
                return
            }
            
            let vc = SearchResultViewController()
            vc.shoppingItems = self.viewModel.outputShoppingItems.value
            vc.keyword = self.viewModel.outputKeyword.value
            vc.total = self.viewModel.outputTotal.value
            self.navigationController?.pushViewController(vc, animated: true)
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
    }
}

extension HomeViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        viewModel.inputSearchQuery.value = searchBar.text
    }
}

extension HomeViewController {
    private func configureBackButtonUI() {
        navigationItem.backButtonTitle = ""
    }
}
