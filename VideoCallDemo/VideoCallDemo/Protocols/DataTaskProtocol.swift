//
//  DataTaskProtocol.swift
//  VideoCallDemo
//
//  Created by Daniele Salvioni on 19/02/22.
//

import Foundation

public protocol DataTaskProtocol {
    func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> VoidClosure
}
