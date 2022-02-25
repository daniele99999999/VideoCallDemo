//
//  UIViewController+Alert.swift
//  VideoCallDemo
//
//  Created by Daniele Salvioni on 19/02/22.
//

import Foundation
import UIKit

extension UIViewController {
    func showErrorAlert(title: String?, message: String?, okTitle: String = "Ok") {
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .alert)
        alert.addAction(.init(title: okTitle, style: .default))
        self.present(alert, animated: true)
    }
}
