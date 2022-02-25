//
//  APIStreamServiceMock.swift
//  VideoCallDemoTests
//
//  Created by Daniele Salvioni on 23/02/22.
//

import Foundation
@testable import VideoCallDemo

class APIStreamServiceMock: APIStreamProtocol {
    var _connect: ((Token, [ContactList.Contact], @escaping (Result<Bool, Error>) -> Void) -> Void)?
    func connect(user: Token, contacts: [ContactList.Contact], completion: @escaping (Result<Bool, Error>) -> Void) {
        self._connect?(user, contacts, completion)
    }
    
    var _disconnect: ((Token, @escaping (Result<Bool, Error>) -> Void) -> Void)?
    func disconnect(user: Token, completion: @escaping (Result<Bool, Error>) -> Void) {
        self._disconnect?(user, completion)
    }
}
