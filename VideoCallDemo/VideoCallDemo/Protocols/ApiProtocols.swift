//
//  ApiProtocols.swift
//  VideoCallDemo
//
//  Created by Daniele Salvioni on 19/02/22.
//

import Foundation

public protocol APIHandleResponseProtocol {}

public extension APIHandleResponseProtocol {
    func handleResponse<T: Decodable>(completion: @escaping (Result<T, Error>) -> Void) -> (Result<Data, Error>) -> Void {
        return { result in
            switch result {
            case .success(let data):
                do {
                    let decoded = try JSONDecoder().decode(T.self, from: data)
                    completion(.success(decoded))
                } catch let decodeError {
                    completion(.failure(decodeError))
                }
            case .failure(let responseError):
                completion(.failure(responseError))
            }
        }
    }
}

public protocol APIAuthProtocol {
    func login(user: String, password: String, completion: @escaping (Result<Token, Error>) -> Void)
    func logout(token: Token, completion: @escaping (Result<Bool, Error>) -> Void)
}

public protocol APIContactsProtocol {
    func getList(user: Token, completion: @escaping (Result<ContactList, Error>) -> Void)
}

public protocol APIStreamProtocol {
    func connect(user: Token, contacts: [ContactList.Contact], completion: @escaping (Result<Bool, Error>) -> Void)
    func disconnect(user: Token, completion: @escaping (Result<Bool, Error>) -> Void)
//    func getStream(user: Token, contact: ContactList.Contact, completion: @escaping (Result<Stream, Error>) -> Void)
}

