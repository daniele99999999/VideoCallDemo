//
//  APIAuthServiceMock.swift
//  VideoCallDemoTests
//
//  Created by Daniele Salvioni on 23/02/22.
//

import Foundation
@testable import VideoCallDemo

class APIAuthServiceMock: APIAuthProtocol {
    var _login: ((String, String, @escaping (Result<Token, Error>) -> Void) -> Void)?
    func login(user: String, password: String, completion: @escaping (Result<Token, Error>) -> Void) {
        self._login?(user, password, completion)
    }
    
    var _logout: ((Token, @escaping (Result<Bool, Error>) -> Void) -> Void)?
    func logout(token: Token, completion: @escaping (Result<Bool, Error>) -> Void) {
        self._logout?(token, completion)
    }
}
