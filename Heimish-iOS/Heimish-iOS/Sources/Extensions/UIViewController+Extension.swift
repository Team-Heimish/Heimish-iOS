//
//  UIViewController+Extension.swift
//  Heimish-iOS
//
//  Created by Wonseok Lee on 2021/06/09.
//

import UIKit

extension UIViewController {
    func basicAlert(title: String?, message: String?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "확인",style: .default)
        alert.addAction(okAction)
        present(alert, animated: true)
    }
}
