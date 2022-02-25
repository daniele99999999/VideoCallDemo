//
//  CallProtocols.swift
//  VideoCallDemo
//
//  Created by Daniele Salvioni on 20/02/22.
//

import Foundation

public protocol CallProtocol {
    func connect(contacts: [ContactList.Contact], completion: @escaping (Result<Bool, Error>) -> Void)
    func disconnect(completion: @escaping (Result<Bool, Error>) -> Void)
    func isConnected() -> Bool
    func currentStreamsCount() -> Int
}

public protocol CallProtocolDelegate: AnyObject {
    func didAddStream(stream: Stream)
    func didRemoveStream(stream: Stream)
}
