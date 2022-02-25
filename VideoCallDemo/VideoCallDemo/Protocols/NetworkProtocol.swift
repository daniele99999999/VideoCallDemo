//
//  NetworkProtocol.swift
//  VideoCallDemo
//
//  Created by Daniele Salvioni on 19/02/22.
//

import Foundation

public protocol NetworkProtocol {
    func fetchData(request: URLRequest, completion: @escaping (Result<Data, Error>) -> Void) -> VoidClosure
}
