//
//  HomeViewController.swift
//  Shopping
//
//  Created by Youngjun Kim on 7/26/25.
//

import UIKit
import Alamofire
import SnapKit

class HomeViewController: UIViewController {
    let searchBar = {
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
            string: Title.placeholder,
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.myFGLightGray]
        )
        
        if let leftView = textField.leftView as? UIImageView {
            leftView.tintColor = .myFGLightGray
        }

        return bar
    }()
    
    let stackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 64
        return stackView
    }()
    
    let backImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(resource: .shoppingMan)
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    let descLabel = {
        let label = UILabel()
        label.textColor = .white
        label.text = Title.homeVCImageDescription
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 18, weight: .bold)
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureHierarchy()
        configureLayout()
        configureView()
    }

}

extension HomeViewController: UIConfigurable {
    func configureHierarchy() {
        view.addSubview(stackView)
        view.addSubview(searchBar)
        stackView.addArrangedSubview(backImageView)
        stackView.addArrangedSubview(descLabel)
    }
    
    func configureLayout() {
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
    
    func configureView() {
        view.backgroundColor = .black
        navigationItem.title = Title.navTitle
    }
}

