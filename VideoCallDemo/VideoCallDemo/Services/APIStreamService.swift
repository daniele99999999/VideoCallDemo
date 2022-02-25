//
//  APIStreamService.swift
//  VideoCallDemo
//
//  Created by Daniele Salvioni on 20/02/22.
//

import Foundation

public struct APIStreamService {
    private let baseURL: URL
    private let networkService: NetworkProtocol
    
    init(baseURL: URL, networkService: NetworkProtocol) {
        self.baseURL = baseURL
        self.networkService = networkService
    }
    
    enum Endpoints {
        case connect
        case disconnect
        case stream
        
        var path: String {
            switch self {
            case .connect:
                return "v1/public/connect"
            case .disconnect:
                return "v1/public/disconnect"
            case .stream:
                return "v1/public/stream"
            }
        }
        
        func url(baseURL: URL) -> URL {
            return baseURL.appendingPathComponent(self.path)
        }
    }
}

extension APIStreamService: APIHandleResponseProtocol {}
extension APIStreamService: APIStreamProtocol {
    public func connect(user: Token, contacts: [ContactList.Contact], completion: @escaping (Result<Bool, Error>) -> Void) {
//        let url = Endpoints.connect.url(baseURL: self.baseURL)
//        let request = URLRequest(url: url)
//        _ = self.networkService.fetchData(request: request,
//                                          completion: self.handleResponse(completion: completion))
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            completion(.success(true))
        }
    }
    
    public func disconnect(user: Token, completion: @escaping (Result<Bool, Error>) -> Void) {
//        let url = Endpoints.disconnect.url(baseURL: self.baseURL)
//        let request = URLRequest(url: url)
//        _ = self.networkService.fetchData(request: request,
//                                          completion: self.handleResponse(completion: completion))
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            completion(.success(true))
        }
    }
    
//    public func getStream(user: Token, contact: ContactList.Contact, completion: @escaping (Result<Stream, Error>) -> Void) {
////        let url = Endpoints.stream.url(baseURL: self.baseURL)
////        let request = URLRequest(url: url)
////        _ = self.networkService.fetchData(request: request,
////                                          completion: self.handleResponse(completion: completion))
//        
//        DispatchQueue.main.asyncAfter(deadline: .now() + Double.random(in: 0...3)) {
//            completion(.success(.init(contactID: contact.id,
//                                      video: URL(string: "https://picsum.photos/id/\(contact.id)/400")!)))
//        }
//    }
}
