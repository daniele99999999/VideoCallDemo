//
//  UIView+Circle.swift
//  VideoCallDemo
//
//  Created by Daniele Salvioni on 19/02/22.
//

import Foundation
import UIKit

extension UIView {
    func makeCircular() {
        self.layer.cornerRadius = min(self.frame.width, self.frame.height) / CGFloat(2.0)
        self.layer.masksToBounds = true
    }
}
