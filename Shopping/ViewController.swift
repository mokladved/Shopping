//
//  ViewController.swift
//  Shopping
//
//  Created by Youngjun Kim on 7/25/25.
//

import UIKit
import SnapKit


class ViewController: UIViewController {
    let goButton = {
        let button = UIButton()
        button.configuration = .filledStyle(title: "쇼핑하기")
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureHierarchy()
        configureLayout()
        configureView()
    }


}

extension ViewController: UIConfigurable {
    func configureHierarchy() {
        view.addSubview(goButton)
    }
    
    func configureLayout() {
        goButton.snp.makeConstraints { make in
            make.width.equalTo(200)
            make.height.equalTo(100)
            make.center.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    func configureView() {
        view.backgroundColor = .black
    }
}
