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
    let searchBar = UISearchBar()
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
        stackView.addArrangedSubview(backImageView)
        stackView.addArrangedSubview(descLabel)
    }
    
    func configureLayout() {
        stackView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(40)
            make.centerX.centerY.equalToSuperview()
            make.size.equalTo(300)
        }
        
    }
    
    func configureView() {
        view.backgroundColor = .black
        navigationItem.title = Title.navTitle
    }
}

