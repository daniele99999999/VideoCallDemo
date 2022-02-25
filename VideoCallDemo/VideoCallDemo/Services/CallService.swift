//
//  CallService.swift
//  VideoCallDemo
//
//  Created by Daniele Salvioni on 20/02/22.
//

import Foundation

public class CallService {
    private let api: APIStreamProtocol
    private let auth: AuthDataProtocol
    weak var delegate: CallProtocolDelegate?
    
    private var connected: Bool
    private var streamsCount: Int
    private var delay: Double
    
    init(api: APIStreamProtocol, auth: AuthDataProtocol, delay: Double = 1) {
        self.api = api
        self.auth = auth
        self.delay = delay
        self.connected = false
        self.streamsCount = 0
    }
}

extension CallService {
    public enum CallError: Error, LocalizedError {
        case auth
        case alreadyConnected
        case notConnected
    }
}

extension CallService: CallProtocol {
    public func connect(contacts: [ContactList.Contact], completion: @escaping (Result<Bool, Error>) -> Void) {
        guard !self.isConnected() else {
            completion(.failure(CallError.alreadyConnected))
            return
        }
        
        guard let token = try? self.auth.current() else {
            completion(.failure(CallError.auth))
            return
        }
        
        self.api.connect(user: token, contacts: contacts) { [weak self] result in
            switch result {
            case .success(let success):
                if success {
                    self?.connected = true
                    self?.throwMockStreams(contacts: contacts)
                }
                completion(.success(success))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    public func disconnect(completion: @escaping (Result<Bool, Error>) -> Void) {
        guard self.isConnected() else {
            completion(.failure(CallError.notConnected))
            return
        }
        
        guard let token = try? self.auth.current() else {
            completion(.failure(CallError.auth))
            return
        }
        
        self.api.disconnect(user: token) { [weak self] result in
            switch result {
            case .success(let success):
                if success {
                    self?.connected = false
                    self?.streamsCount = 0
                }
                completion(.success(success))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    public func isConnected() -> Bool {
        return self.connected
    }
    
    public func currentStreamsCount() -> Int {
        return self.streamsCount
    }
}

private extension CallService {
    func throwMockStreams(contacts: [ContactList.Contact]) {
        guard self.isConnected() else {
            return
        }
        
        self.addMockStreams(contacts: contacts, delay: self.delay) { [weak self] in
            guard let self = self else { return }
            self.removeMockStreams(contacts: contacts, delay: self.delay, completion: {})
        }
    }
}

private extension CallService {
    func addMockStreams(contacts: [ContactList.Contact], delay: Double, completion: @escaping () -> Void) {
        if contacts.count > 0 {
            var contactsToThrow = contacts
            let contact = contactsToThrow.removeFirst()
            
            let stream = Stream(contactID: contact.id,
                                video: URL(string: "https://picsum.photos/id/\(contact.id)/400")!)
            
            DispatchQueue.main.asyncAfter(deadline: .now() + delay) { [weak self] in
                guard let self = self else { return }
                if self.isConnected() {
                    self.streamsCount += 1
                    self.delegate?.didAddStream(stream: stream)
                    self.addMockStreams(contacts: contactsToThrow, delay: delay, completion: completion)
                } else {
                    completion()
                }
            }
        } else {
            completion()
        }
    }
    
    func removeMockStreams(contacts: [ContactList.Contact], delay: Double, completion: @escaping () -> Void) {
        if contacts.count > 0 {
            var contactsToThrow = contacts
            let contact = contactsToThrow.removeFirst()
            
            let stream = Stream(contactID: contact.id,
                                video: URL(string: "https://picsum.photos/id/\(contact.id)/400")!)
            
            DispatchQueue.main.asyncAfter(deadline: .now() + delay) { [weak self] in
                guard let self = self else { return }
                if self.isConnected() {
                    self.streamsCount = max(0, self.streamsCount-1)
                    self.delegate?.didRemoveStream(stream: stream)
                    self.removeMockStreams(contacts: contactsToThrow, delay: delay, completion: completion)
                } else {
                    completion()
                }
            }
        } else {
            completion()
        }
    }
}
