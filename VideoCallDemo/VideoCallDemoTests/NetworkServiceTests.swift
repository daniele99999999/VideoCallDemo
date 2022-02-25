//
//  NetworkServiceTests.swift
//  VideoCallDemoTests
//
//  Created by Daniele Salvioni on 23/02/22.
//

import XCTest
@testable import VideoCallDemo

class NetworkServiceTests: XCTestCase {
    
    func testNetworkServiceUnknown() {
        let dataTaskMock = DataTaskServiceMock()
        dataTaskMock._dataTask = { request, completion in
            completion(nil,
                       nil,
                       nil)
            return {}
        }
        
        let networkService = NetworkService(dataTask: dataTaskMock)
        _ = networkService.fetchData(request: URLRequest(url: URL(string: "https://www.google.it")!)) { result in
            switch result {
            case .failure(let error):
                if let _error = error as? NetworkService.NetworkError {
                    XCTAssertEqual(_error, NetworkService.NetworkError.unknown)
                } else {
                    XCTFail()
                }
            case .success(_):
                XCTFail()
            }
        }
    }
    
    func testNetworkServiceUnsuccessful() {
        let dataTaskMock = DataTaskServiceMock()
        dataTaskMock._dataTask = { request, completion in
            completion(nil,
                       HTTPURLResponse(url: request.url!,
                                       statusCode: 400,
                                       httpVersion: nil,
                                       headerFields: nil),
                       nil)
            return {}
        }
        
        let networkService = NetworkService(dataTask: dataTaskMock)
        _ = networkService.fetchData(request: URLRequest(url: URL(string: "https://www.google.it")!)) { result in
            switch result {
            case .failure(let error):
                if let _error = error as? NetworkService.NetworkError {
                    XCTAssertEqual(_error, NetworkService.NetworkError.unsuccessful)
                } else {
                    XCTFail()
                }
            case .success(_):
                XCTFail()
            }
        }
    }
    
    func testNetworkService200FailureGeneric() {
        let dataTaskMock = DataTaskServiceMock()
        dataTaskMock._dataTask = { request, completion in
            completion(nil,
                       HTTPURLResponse(url: request.url!,
                                       statusCode: 200,
                                       httpVersion: nil,
                                       headerFields: nil),
                       nil)
            return {}
        }
        
        let networkService = NetworkService(dataTask: dataTaskMock)
        _ = networkService.fetchData(request: URLRequest(url: URL(string: "https://www.google.it")!)) { result in
            switch result {
            case .failure(let error):
                if let _error = error as? NetworkService.NetworkError {
                    XCTAssertEqual(_error, NetworkService.NetworkError.generic)
                } else {
                    XCTFail()
                }
            case .success(_):
                XCTFail()
            }
        }
    }
    
    func testNetworkService200FailureSpecific() {
        let dataTaskMock = DataTaskServiceMock()
        dataTaskMock._dataTask = { request, completion in
            completion(nil,
                       HTTPURLResponse(url: request.url!,
                                       statusCode: 200,
                                       httpVersion: nil,
                                       headerFields: nil),
                       NSError(domain: "", code: 0, userInfo: nil))
            return {}
        }
        
        let networkService = NetworkService(dataTask: dataTaskMock)
        _ = networkService.fetchData(request: URLRequest(url: URL(string: "https://www.google.it")!)) { result in
            switch result {
            case .failure(let error):
                if let _error = error as NSError? {
                    XCTAssertEqual(_error.code, 0)
                } else {
                    XCTFail()
                }
            case .success(_):
                XCTFail()
            }
        }
    }
    
    func testNetworkService200Success() {
        let dataTaskMock = DataTaskServiceMock()
        dataTaskMock._dataTask = { request, completion in
            completion(Data(),
                       HTTPURLResponse(url: request.url!,
                                       statusCode: 200,
                                       httpVersion: nil,
                                       headerFields: nil),
                       nil)
            return {}
        }
        
        let networkService = NetworkService(dataTask: dataTaskMock)
        _ = networkService.fetchData(request: URLRequest(url: URL(string: "https://www.google.it")!)) { result in
            switch result {
            case .failure(_):
                XCTFail()
            case .success(_):
                XCTAssertTrue(true)
            }
        }
    }
}
