//
//  CallServiceMock.swift
//  VideoCallDemoTests
//
//  Created by Daniele Salvioni on 23/02/22.
//

import Foundation
@testable import VideoCallDemo

class CallServiceMock: CallProtocol {
    
    var _connect: (([ContactList.Contact], @escaping (Result<Bool, Error>) -> Void) -> Void)?
    func connect(contacts: [ContactList.Contact], completion: @escaping (Result<Bool, Error>) -> Void) {
        self._connect?(contacts, completion)
    }
    
    var _disconnect: ((@escaping (Result<Bool, Error>) -> Void) -> Void)?
    func disconnect(completion: @escaping (Result<Bool, Error>) -> Void) {
        self._disconnect?(completion)
    }
    
    var _isConnected: (() -> Bool)?
    func isConnected() -> Bool {
        return self._isConnected!()
    }
    
    var _currentStreamsCount: (() -> Int)?
    func currentStreamsCount() -> Int {
        return self._currentStreamsCount!()
    }
}

