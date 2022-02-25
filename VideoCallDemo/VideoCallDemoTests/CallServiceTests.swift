//
//  CallServiceTests.swift
//  VideoCallDemoTests
//
//  Created by Daniele Salvioni on 23/02/22.
//

import XCTest
@testable import VideoCallDemo

class CallServiceTests: XCTestCase {
    
    let contactList = ContactList.init(results: [.init(id: 10,
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
                                                       avatar: .init(path: "https://picsum.photos/id/13/200"))])
    struct FakeError: Error {}
    let fakeError = FakeError()
    
    func testCallServiceConnectAndDisconnect() throws {
        let callDelegateMock = CallProtocolDelegateMock()
        callDelegateMock._didAddStream = { stream in
            XCTFail()
        }
        callDelegateMock._didRemoveStream = { stream in
            XCTFail()
        }
        let apiMock = APIStreamServiceMock()
        let authMock = AuthDataServiceKeychainMock()
        var callService = CallService(api: apiMock, auth: authMock)
        
        
        
        apiMock._connect = { _, _, completion in
            completion(.success(false))
        }
        authMock._data = nil
        callService.delegate = callDelegateMock
        
        let expectation1 = self.expectation(description: "testCallServiceConnectNotConnectedNoAuth")
        callService.connect(contacts: []) { result in
            expectation1.fulfill()
            
            XCTAssertFalse(callService.isConnected())
            switch result {
            case .failure(let error):
                if let _error = error as? CallService.CallError {
                    XCTAssertEqual(_error, CallService.CallError.auth)
                } else {
                    XCTFail()
                }
            case .success(_):
                XCTFail()
            }
        }
        self.waitForExpectations(timeout: 1)
        
        
        apiMock._connect = { _, _, completion in
            completion(.success(false))
        }
        authMock._data = "Token"
        callService = CallService(api: apiMock, auth: authMock)
        callService.delegate = callDelegateMock
        
        let expectation2 = self.expectation(description: "testCallServiceConnectNotConnectedAndFailure1")
        callService.connect(contacts: []) { result in
            expectation2.fulfill()
            
            XCTAssertFalse(callService.isConnected())
            switch result {
            case .failure(_):
                XCTFail()
            case .success(let success):
                XCTAssertFalse(success)
            }
        }
        self.waitForExpectations(timeout: 1)
        
        
        
        apiMock._connect = { _, _, completion in
            completion(.failure(self.fakeError))
        }
        authMock._data = "Token"
        callService = CallService(api: apiMock, auth: authMock)
        callService.delegate = callDelegateMock
        
        let expectation3 = self.expectation(description: "testCallServiceConnectNotConnectedAndFailure2")
        callService.connect(contacts: []) { result in
            expectation3.fulfill()
            
            XCTAssertFalse(callService.isConnected())
            switch result {
            case .failure(let error):
                XCTAssertTrue(error.localizedDescription.contains("FakeError"))
            case .success(_):
                XCTFail()
            }
        }
        self.waitForExpectations(timeout: 1)
        
        
        
        apiMock._connect = { _, _, completion in
            completion(.success(true))
        }
        authMock._data = "Token"
        callService = CallService(api: apiMock, auth: authMock)
        callService.delegate = callDelegateMock
        
        let expectation4 = self.expectation(description: "testCallServiceConnectNotConnectedAndSuccess")
        callService.connect(contacts: []) { result in
            expectation4.fulfill()
            
            XCTAssertTrue(callService.isConnected())
            switch result {
            case .failure(_):
                XCTFail()
            case .success(let success):
                XCTAssertTrue(success)
            }
        }
        self.waitForExpectations(timeout: 1)
        
        
        
        let expectation5 = self.expectation(description: "testCallServiceConnectAlreadyConnectedAndFailure")
        callService.connect(contacts: []) { result in
            expectation5.fulfill()
            
            XCTAssertTrue(callService.isConnected())
            switch result {
            case .failure(let error):
                if let _error = error as? CallService.CallError {
                    XCTAssertEqual(_error, CallService.CallError.alreadyConnected)
                } else {
                    XCTFail()
                }
            case .success(_):
                XCTFail()
            }
        }
        self.waitForExpectations(timeout: 1)
        
        
        
        apiMock._disconnect = { _, completion in
            completion(.success(false))
        }
        authMock._data = nil

        let expectation7 = self.expectation(description: "testCallServiceDisconnectAlreadyConnectedNoAuth")
        callService.disconnect { result in
            expectation7.fulfill()

            XCTAssertTrue(callService.isConnected())
            switch result {
            case .failure(let error):
                if let _error = error as? CallService.CallError {
                    XCTAssertEqual(_error, CallService.CallError.auth)
                } else {
                    XCTFail()
                }
            case .success(_):
                XCTFail()
            }
        }
        self.waitForExpectations(timeout: 1)
        
        
        
        apiMock._disconnect = { _, completion in
            completion(.success(false))
        }
        authMock._data = "Token"

        let expectation8 = self.expectation(description: "testCallServiceDisconnectAlreadyConnectedAndFailure1")
        callService.disconnect { result in
            expectation8.fulfill()

            XCTAssertTrue(callService.isConnected())
            switch result {
            case .failure(_):
                XCTFail()
            case .success(let success):
                XCTAssertFalse(success)
            }
        }
        self.waitForExpectations(timeout: 1)
        
        
        
        apiMock._disconnect = { _, completion in
            completion(.failure(self.fakeError))
        }
        authMock._data = "Token"

        let expectation9 = self.expectation(description: "testCallServiceDisconnectAlreadyConnectedAndFailure2")
        callService.disconnect { result in
            expectation9.fulfill()

            XCTAssertTrue(callService.isConnected())
            switch result {
            case .failure(let error):
                XCTAssertTrue(error.localizedDescription.contains("FakeError"))
            case .success(_):
                XCTFail()
            }
        }
        self.waitForExpectations(timeout: 1)
        
        
        
        apiMock._disconnect = { _, completion in
            completion(.success(true))
        }
        authMock._data = "Token"

        let expectation10 = self.expectation(description: "testCallServiceDisconnectAlreadyConnectedAndSuccess")
        callService.disconnect { result in
            expectation10.fulfill()

            XCTAssertFalse(callService.isConnected())
            switch result {
            case .failure(_):
                XCTFail()
            case .success(let success):
                XCTAssertTrue(success)
            }
        }
        self.waitForExpectations(timeout: 1)
        
        
        
        apiMock._disconnect = { _, completion in
            completion(.success(true))
        }
        authMock._data = "Token"
        
        let expectation11 = self.expectation(description: "testCallServiceNotConnectAndFailure")
        callService.disconnect { result in
            expectation11.fulfill()
            
            XCTAssertFalse(callService.isConnected())
            switch result {
            case .failure(let error):
                if let _error = error as? CallService.CallError {
                    XCTAssertEqual(_error, CallService.CallError.notConnected)
                } else {
                    XCTFail()
                }
            case .success(_):
                XCTFail()
            }
        }
        self.waitForExpectations(timeout: 1)
    }
    
    func testCallServiceDelegate1Contact() throws {
        let callDelegateMock = CallProtocolDelegateMock()
        let apiMock = APIStreamServiceMock()
        let authMock = AuthDataServiceKeychainMock()
        let callService = CallService(api: apiMock, auth: authMock, delay: 0.05)
        callService.delegate = callDelegateMock
        apiMock._connect = { _, _, completion in
            completion(.success(true))
        }
        authMock._data = "Token"
        
        
        let expectation = self.expectation(description: "testCallServiceDelegate1Contact")
        expectation.expectedFulfillmentCount = 3
        callDelegateMock._didAddStream = { stream in
            expectation.fulfill()
            XCTAssertEqual(callService.currentStreamsCount(), 1)
            XCTAssertEqual(stream.contactID, 10)
            XCTAssertEqual(stream.video.absoluteString, "https://picsum.photos/id/\(stream.contactID)/400")
        }
        callDelegateMock._didRemoveStream = { stream in
            expectation.fulfill()
            XCTAssertEqual(callService.currentStreamsCount(), 0)
            XCTAssertEqual(stream.contactID, 10)
            XCTAssertEqual(stream.video.absoluteString, "https://picsum.photos/id/\(stream.contactID)/400")
        }
        callService.connect(contacts: Array(self.contactList.results.prefix(1))) { result in
            expectation.fulfill()
        }
        self.waitForExpectations(timeout: 1)
        
        XCTAssertTrue(true)
    }
    
    func testCallServiceDelegate2Contact() throws {
        let callDelegateMock = CallProtocolDelegateMock()
        let apiMock = APIStreamServiceMock()
        let authMock = AuthDataServiceKeychainMock()
        let callService = CallService(api: apiMock, auth: authMock, delay: 0.05)
        callService.delegate = callDelegateMock
        apiMock._connect = { _, _, completion in
            completion(.success(true))
        }
        authMock._data = "Token"
        
        
        let expectation = self.expectation(description: "testCallServiceDelegate2Contact")
        expectation.expectedFulfillmentCount = 5
        callDelegateMock._didAddStream = { stream in
            expectation.fulfill()
        }
        callDelegateMock._didRemoveStream = { stream in
            expectation.fulfill()
        }
        callService.connect(contacts: Array(self.contactList.results.prefix(2))) { result in
            expectation.fulfill()
        }
        self.waitForExpectations(timeout: 1)
        
        XCTAssertTrue(true)
    }
    
    func testCallServiceDelegate3Contact() throws {
        let callDelegateMock = CallProtocolDelegateMock()
        let apiMock = APIStreamServiceMock()
        let authMock = AuthDataServiceKeychainMock()
        let callService = CallService(api: apiMock, auth: authMock, delay: 0.05)
        callService.delegate = callDelegateMock
        apiMock._connect = { _, _, completion in
            completion(.success(true))
        }
        authMock._data = "Token"
        
        
        let expectation = self.expectation(description: "testCallServiceDelegate3Contact")
        expectation.expectedFulfillmentCount = 7
        callDelegateMock._didAddStream = { stream in
            expectation.fulfill()
        }
        callDelegateMock._didRemoveStream = { stream in
            expectation.fulfill()
        }
        callService.connect(contacts: Array(self.contactList.results.prefix(3))) { result in
            expectation.fulfill()
        }
        self.waitForExpectations(timeout: 1)
        
        XCTAssertTrue(true)
    }
    
    func testCallServiceDelegate4Contact() throws {
        let callDelegateMock = CallProtocolDelegateMock()
        let apiMock = APIStreamServiceMock()
        let authMock = AuthDataServiceKeychainMock()
        let callService = CallService(api: apiMock, auth: authMock, delay: 0.05)
        callService.delegate = callDelegateMock
        apiMock._connect = { _, _, completion in
            completion(.success(true))
        }
        authMock._data = "Token"
        
        
        let expectation = self.expectation(description: "testCallServiceDelegate4Contact")
        expectation.expectedFulfillmentCount = 9
        callDelegateMock._didAddStream = { stream in
            expectation.fulfill()
        }
        callDelegateMock._didRemoveStream = { stream in
            expectation.fulfill()
        }
        callService.connect(contacts: Array(self.contactList.results.prefix(4))) { result in
            expectation.fulfill()
        }
        self.waitForExpectations(timeout: 1)
        
        XCTAssertTrue(true)
    }
}
