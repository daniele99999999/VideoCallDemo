//
//  NetworkService.swift
//  VideoCallDemo
//
//  Created by Daniele Salvioni on 20/02/22.
//

import Foundation

public struct NetworkService {
    private let dataTask: DataTaskProtocol

    public init(dataTask: DataTaskProtocol) {
        self.dataTask = dataTask
    }
}

extension NetworkService {
    public enum NetworkError: Error, LocalizedError {
        case unknown
        case generic
        case unsuccessful
    }
}

extension NetworkService: NetworkProtocol {
    public func fetchData(request: URLRequest, completion: @escaping (Result<Data, Error>) -> Void) -> VoidClosure {
        let cancellable = self.dataTask.dataTask(with: request) { data, response, error in
            guard let _response = response as? HTTPURLResponse else {
                completion(.failure(NetworkError.unknown))
                return
            }
            
            switch _response.statusCode {
            case 200..<400:
                switch (data, error) {
                case let (_, .some(error)):
                    completion(.failure(error))
                case let (.some(data), .none):
                    completion(.success(data))
                case (.none, .none):
                    completion(.failure(NetworkError.generic))
                }
            default:
                completion(.failure(NetworkError.unsuccessful))
            }
        }
        return cancellable
    }
}
