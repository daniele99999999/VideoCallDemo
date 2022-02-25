//
//  UIKit+BindOnMainThread.swift
//  VideoCallDemo
//
//  Created by Daniele Salvioni on 19/02/22.
//

import Foundation
import UIKit

extension UIViewController {
    class func bindOnMain<T>(_ closure: @escaping (T) -> Void) -> (T) -> Void {
        return { input in
            DispatchQueue.main.async { closure(input) }
        }
    }
    
    class func bindOnMain(_ closure: @escaping () -> Void) -> () -> Void {
        return {
            DispatchQueue.main.async { closure() }
        }
    }
}

extension UIView {
    class func bindOnMain<T>(_ closure: @escaping (T) -> Void) -> (T) -> Void {
        return { input in
            DispatchQueue.main.async { closure(input) }
        }
    }
    
    class func bindOnMain(_ closure: @escaping () -> Void) -> () -> Void {
        return {
            DispatchQueue.main.async { closure() }
        }
    }
}
