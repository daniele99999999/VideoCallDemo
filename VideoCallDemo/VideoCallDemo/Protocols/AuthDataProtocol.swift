//
//  AuthDataProtocol.swift
//  VideoCallDemo
//
//  Created by Daniele Salvioni on 19/02/22.
//

import Foundation

public protocol AuthDataProtocol {
    func add(token: Token) throws
    func current() throws -> Token?
    func isPresent() throws -> Bool
    func remove() throws
}
