//
//  UITableView+CustomCells.swift
//  VideoCallDemo
//
//  Created by Daniele Salvioni on 19/02/22.
//

import Foundation
import UIKit

extension UITableView {
    func registerCell<T: UITableViewCell>(className: T.Type, identifier: String = String(describing: T.self)) {
        self.register(T.self, forCellReuseIdentifier: identifier)
    }
    
    func dequeueReusableCell<T: UITableViewCell>(className: T.Type, identifier: String = String(describing: T.self), indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? T else {
            fatalError("Couldn't find UITableViewCell for \(String(describing: className))")
        }
        return cell
    }
}
