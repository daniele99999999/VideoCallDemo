//
//  AuthDataServiceKeychain.swift
//  VideoCallDemo
//
//  Created by Daniele Salvioni on 19/02/22.
//

import Foundation
import KeychainAccess

public struct AuthDataServiceKeychain {
    private let accessKey: String
    private let valueKey: String
    private let keychain: Keychain

    init(accessKey: String, valueKey: String) {
        self.accessKey = accessKey
        self.valueKey = valueKey
        self.keychain = Keychain(service: self.accessKey)
    }
}

extension AuthDataServiceKeychain: AuthDataProtocol {
    public func add(token: Token) throws {
        try self.keychain.set(token, key: self.valueKey)
    }

    public func current() throws -> Token? {
        return try self.keychain.getString(self.valueKey)
    }

    public func isPresent() throws -> Bool {
        return try self.current() != nil
    }

    public func remove() throws {
        try keychain.remove(self.valueKey)
    }
}
