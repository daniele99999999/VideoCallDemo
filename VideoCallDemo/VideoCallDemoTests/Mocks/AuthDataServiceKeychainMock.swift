//
//  AuthDataServiceKeychainMock.swift
//  VideoCallDemoTests
//
//  Created by Daniele Salvioni on 23/02/22.
//

import Foundation
@testable import VideoCallDemo

class AuthDataServiceKeychainMock: AuthDataProtocol {
    var _data: Token?
    
    func add(token: Token) throws {
        self._data = token
    }
    
    func current() throws -> Token? {
        return self._data
    }
    
    func isPresent() throws -> Bool {
        return self._data != nil
    }
    
    func remove() throws {
        self._data = nil
    }
}
