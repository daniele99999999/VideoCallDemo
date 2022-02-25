//
//  APIContactsService.swift
//  VideoCallDemo
//
//  Created by Daniele Salvioni on 20/02/22.
//

import Foundation

public struct APIContactsService {
    private let baseURL: URL
    private let networkService: NetworkProtocol
    
    init(baseURL: URL, networkService: NetworkProtocol) {
        self.baseURL = baseURL
        self.networkService = networkService
    }
    
    enum Endpoints {
        case list
        
        var path: String {
            switch self {
            case .list:
                return "v1/public/contact/list"
            }
        }
        
        func url(baseURL: URL) -> URL {
            return baseURL.appendingPathComponent(self.path)
        }
    }
}

extension APIContactsService: APIHandleResponseProtocol {}
extension APIContactsService: APIContactsProtocol {
    public func getList(user: Token, completion: @escaping (Result<ContactList, Error>) -> Void) {
//        let url = Endpoints.list.url(baseURL: self.baseURL)
//        let request = URLRequest(url: url)
//        _ = self.networkService.fetchData(request: request,
//                                          completion: self.handleResponse(completion: completion))
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            completion(.success(.init(results: [.init(id: 10,
                                                      firstName: "Daniele",
                                                      lastName: "Rossi",
                                                      avatar: .init(path: "https://picsum.photos/id/10/200")),
                                                .init(id: 11,
                                                      firstName: "Fabio",
                                                      lastName: "Bianchi",
                                                      avatar: .init(path: "https://picsum.photos/id/11/200")),
                                                .init(id: 12,
                                                      firstName: "Maria",
                                                      lastName: "Verdi",
                                                      avatar: .init(path: "https://picsum.photos/id/12/200")),
                                                .init(id: 13,
                                                      firstName: "Giacomo",
                                                      lastName: "Blu",
                                                      avatar: .init(path: "https://picsum.photos/id/13/200"))])))
        }
    }
}
