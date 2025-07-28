//
//  UIViewController+Extension.swift
//  Shopping
//
//  Created by Youngjun Kim on 7/29/25.
//

import UIKit

extension UIViewController {
    func showAlert(message: String) {
        let alert = UIAlertController(
            title: "알림",
            message: message,
            preferredStyle: .alert
        )
        
        let confirmAction = UIAlertAction(title: "확인", style: .default)
        alert.addAction(confirmAction)
        
        present(alert, animated: true)
    }
    
}

