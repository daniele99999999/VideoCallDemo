//
//  DataTaskServiceMock.swift
//  VideoCallDemoTests
//
//  Created by Daniele Salvioni on 23/02/22.
//

import Foundation
@testable import VideoCallDemo

class DataTaskServiceMock: DataTaskProtocol {
    var _dataTask: ((URLRequest, @escaping (Data?, URLResponse?, Error?) -> Void) -> VoidClosure)?
    func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> VoidClosure {
        return self._dataTask!(request, completionHandler)
    }
}
