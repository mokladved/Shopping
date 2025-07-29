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
    
    override func configureHierarchy() {
        view.addSubview(stackView)
        view.addSubview(searchBar)
        stackView.addArrangedSubview(backImageView)
        stackView.addArrangedSubview(descLabel)
        
    }
    
    override func configureLayout() {
        stackView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(40)
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
}


extension HomeViewController: Networkable {
    typealias Data = String
    
    func configure(for data: String) {
        let target = URLs.shopping(for: data, display: Constants.API.paginationStandards)
        
        NetworkManager.shared.callShopItemRequest(
            target: target,
            success: { shopItem in
                let vc = SearchResultViewController()
                vc.shoppingItems = shopItem.items
                vc.keyword = data
                vc.total = shopItem.total
                self.navigationController?.pushViewController(vc, animated: true)
            },
            failure: { error in
                self.showAlert(message: error.errorMessage)
            }
        )
    }
}


extension HomeViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let input = searchBar.searchTextField.text
        guard let keyword = isValid(of: input) else {
            return
        }
        configure(for: keyword)
    }
    
    private func isValid(of text: String?) -> String? {
        guard let text = text, !text.trimmingCharacters(in: .whitespaces).isEmpty, text.count >= 2 else {
            showAlert(message: "두 글자 이상 입력해 주세요")
            return nil
        }
        return text
    }
}

extension HomeViewController {
    private func configureBackButtonUI() {
        navigationItem.backButtonTitle = ""
    }
}
