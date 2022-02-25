//
//  NetworkServiceMock.swift
//  VideoCallDemoTests
//
//  Created by Daniele Salvioni on 23/02/22.
//

import Foundation
@testable import VideoCallDemo

class NetworkServiceMock: NetworkProtocol {
    var _fetchData: ((URLRequest, @escaping (Result<Data, Error>) -> Void) -> VoidClosure)?
    func fetchData(request: URLRequest, completion: @escaping (Result<Data, Error>) -> Void) -> VoidClosure {
        return self._fetchData!(request, completion)
    }
}
