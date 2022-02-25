//
//  APIAuthService.swift
//  VideoCallDemo
//
//  Created by Daniele Salvioni on 20/02/22.
//

import Foundation

public struct APIAuthService {
    private let baseURL: URL
    private let networkService: NetworkProtocol
    
    init(baseURL: URL, networkService: NetworkProtocol) {
        self.baseURL = baseURL
        self.networkService = networkService
    }
    
    enum Endpoints {
        case login
        case logout
        
        var path: String {
            switch self {
            case .login:
                return "v1/public/login"
            case .logout:
                return "v1/public/logout"
            }
        }
        
        func url(baseURL: URL) -> URL {
            return baseURL.appendingPathComponent(self.path)
        }
    }
}

extension APIAuthService: APIHandleResponseProtocol {}
extension APIAuthService: APIAuthProtocol {
    public func login(user: String, password: String, completion: @escaping (Result<Token, Error>) -> Void) {
//        let url = Endpoints.login.url(baseURL: self.baseURL)
//        let request = URLRequest(url: url)
//        _ = self.networkService.fetchData(request: request,
//                                          completion: self.handleResponse(completion: completion))
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            completion(.success(String.random(length: 20)))
        }
    }
    
    public func logout(token: Token, completion: @escaping (Result<Bool, Error>) -> Void) {
//        let url = Endpoints.logout.url(baseURL: self.baseURL)
//        let request = URLRequest(url: url)
//        _ = self.networkService.fetchData(request: request,
//                                          completion: self.handleResponse(completion: completion))
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            completion(.success(true))
        }
    }
}
