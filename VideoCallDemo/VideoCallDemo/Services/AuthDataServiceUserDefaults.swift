//
//  AuthDataServiceUserDefaults.swift
//  VideoCallDemo
//
//  Created by Daniele Salvioni on 23/02/22.
//

import Foundation

public struct AuthDataServiceUserDefaults {
    private let accessKey: String
    private let valueKey: String
    private let userDefaults = UserDefaults.standard

    init(accessKey: String, valueKey: String) {
        self.accessKey = accessKey
        self.valueKey = valueKey
    }
}

extension AuthDataServiceUserDefaults: AuthDataProtocol {
    public func add(token: Token) throws {
        self.userDefaults.set(token, forKey: self.valueKey)
    }

    public func current() throws -> Token? {
        self.userDefaults.string(forKey: self.valueKey)
    }

    public func isPresent() throws -> Bool {
        return try self.current() != nil
    }

    public func remove() throws {
        self.userDefaults.removeObject(forKey: self.valueKey)
    }
}
