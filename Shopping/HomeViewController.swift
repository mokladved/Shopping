//
//  HomeViewController.swift
//  Shopping
//
//  Created by Youngjun Kim on 7/26/25.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        configureHierarchy()
        configureLayout()
        
    }

}

extension HomeViewController: UIConfigurable {
    func configureHierarchy() {
        
    }
    
    func configureLayout() {
        
    }
    
    func configureView() {
        view.backgroundColor = .black
    }
    
    
}
