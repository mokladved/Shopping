//
//  ViewController.swift
//  Shopping
//
//  Created by Youngjun Kim on 7/25/25.
//

import UIKit
import SnapKit


final class ViewController: BaseViewController {
    private let goButton = {
        let button = UIButton()
        button.configuration = .filledStyle(title: "쇼핑하기")
        return button
    }()
    
    private func configureButtonAction() {
        goButton.addTarget(self, action: #selector(showHome), for: .touchUpInside)
    }
    
    @objc private func showHome() {
        let vc = HomeViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    override func configureHierarchy() {
        view.addSubview(goButton)
    }
    
    override func configureLayout() {
        goButton.snp.makeConstraints { make in
            make.width.equalTo(200)
            make.height.equalTo(100)
            make.center.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    override func configureView() {
        super.configureView()
        configureBackButtonUI()
        configureButtonAction()
    }
}


extension ViewController {
    func configureBackButtonUI() {
        navigationItem.backButtonTitle = ""
    }
}
