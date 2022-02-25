//
//  UIStackView+Helper.swift
//  VideoCallDemo
//
//  Created by Daniele Salvioni on 23/02/22.
//

import Foundation
import UIKit

extension UIStackView {
    func arrangedSubviewsContains(_ view: UIView) -> Bool {
        return self.arrangedSubviews.contains(view)
    }
    
    func removeArrangedSubview(_ view: UIView, shouldRemoveFromSuperview: Bool) {
        self.removeArrangedSubview(view)
        if shouldRemoveFromSuperview {
            view.removeFromSuperview()
        }
    }
}
