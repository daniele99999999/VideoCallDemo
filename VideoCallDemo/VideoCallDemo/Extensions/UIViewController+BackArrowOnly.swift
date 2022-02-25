//
//  UIViewController+BackArrowOnly.swift
//  VideoCallDemo
//
//  Created by Daniele Salvioni on 19/02/22.
//

import Foundation
import UIKit

extension UIViewController {
    func showBackArrowOnly() {
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
}
