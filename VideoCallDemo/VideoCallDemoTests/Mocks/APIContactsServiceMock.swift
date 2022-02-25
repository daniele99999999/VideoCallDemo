//
//  APIContactsServiceMock.swift
//  VideoCallDemoTests
//
//  Created by Daniele Salvioni on 23/02/22.
//

import Foundation
@testable import VideoCallDemo

class APIContactsServiceMock: APIContactsProtocol {
    var _getList: ((Token, @escaping (Result<ContactList, Error>) -> Void) -> Void)?
    func getList(user: Token, completion: @escaping (Result<ContactList, Error>) -> Void) {
        self._getList?(user, completion)
    }
}
