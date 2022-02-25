//
//  UICollectionView+CustomCells.swift
//  VideoCallDemo
//
//  Created by Daniele Salvioni on 19/02/22.
//

import Foundation
import UIKit

extension UICollectionView {
    func registerCell<T: UICollectionViewCell>(className: T.Type, identifier: String = String(describing: T.self)) {
        self.register(T.self, forCellWithReuseIdentifier: identifier)
    }
    
    func dequeueReusableCell<T: UICollectionViewCell>(className: T.Type, identifier: String = String(describing: T.self), indexPath: IndexPath) -> T {
        guard let cell = self.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as? T else {
            fatalError("Couldn't find UICollectionViewCell for \(String(describing: className))")
        }
        return cell
    }
}
