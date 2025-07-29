//
//  BaseViewController.swift
//  Shopping
//
//  Created by Youngjun Kim on 7/29/25.
//

import UIKit

class BaseViewController: UIViewController, UIConfigurable {

    override func viewDidLoad() {
        super.viewDidLoad()
        configureHierarchy()
        configureLayout()
        configureView()
    }
    
    func configureHierarchy() {
        
    }
    
    func configureLayout() {
        
    }
    
    func configureView() {
        view.backgroundColor = .black
    }
}
