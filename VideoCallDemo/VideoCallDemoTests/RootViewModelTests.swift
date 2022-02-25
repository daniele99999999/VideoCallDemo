//
//  RootViewModelTests.swift
//  VideoCallDemoTests
//
//  Created by Daniele Salvioni on 23/02/22.
//

import XCTest
@testable import VideoCallDemo

class RootViewModelTests: XCTestCase {
    
    struct FakeError: Error {}
    let fakeError = FakeError()
    
    func testTitleMain() {
        let authMock = AuthDataServiceKeychainMock()
        let apiMock = APIAuthServiceMock()
        let vm = RootViewModel(auth: authMock, api: apiMock)
        
        let expectation = self.expectation(description: "testTitleMain")
        vm.output.titleMain = { title in
            expectation.fulfill()
            XCTAssertEqual(title, "Home")
        }
        vm.input.ready?()
        self.waitForExpectations(timeout: 1)
    }
    
    func testError() {
        let authMock = AuthDataServiceKeychainMock()
        authMock._data = "Token"
        let apiMock = APIAuthServiceMock()
        let vm = RootViewModel(auth: authMock, api: apiMock)
        
        
        
        let expectation1 = self.expectation(description: "testError1")
        vm.output.error = { message in
            expectation1.fulfill()
            XCTAssertEqual(message, "error in auth process")
        }
        vm.input.ready?()
        vm.input.loginSelected?()
        self.waitForExpectations(timeout: 1)
        
        
        
        authMock._data = nil
        
        let expectation2 = self.expectation(description: "testError2")
        vm.output.error = { message in
            expectation2.fulfill()
            XCTAssertEqual(message, "error in auth process")
        }
        vm.input.ready?()
        vm.input.logoutSelected?()
        self.waitForExpectations(timeout: 1)
        
        
        
        authMock._data = "Token"
        apiMock._logout = { token, completion in
            completion(.failure(self.fakeError))
        }
        
        let expectation3 = self.expectation(description: "testError3")
        vm.output.error = { message in
            expectation3.fulfill()
            XCTAssertTrue(message.contains("FakeError"))
        }
        vm.input.ready?()
        vm.input.logoutSelected?()
        self.waitForExpectations(timeout: 1)
        
        
        
        authMock._data = nil
        
        let expectation4 = self.expectation(description: "testError4")
        vm.output.error = { message in
            expectation4.fulfill()
            XCTAssertEqual(message, "error in auth process")
        }
        vm.input.ready?()
        vm.input.contactListSelected?()
        self.waitForExpectations(timeout: 1)
    }
    
    func testIsLoading() {
        let authMock = AuthDataServiceKeychainMock()
        let apiMock = APIAuthServiceMock()
        let vm = RootViewModel(auth: authMock, api: apiMock)
        
        
        
        let expectation1 = self.expectation(description: "isLoading1")
        vm.output.isLoading = { isLoading in
            expectation1.fulfill()
        }
        vm.input.ready?()
        self.waitForExpectations(timeout: 1)
        
        
        authMock._data = "Token"
        apiMock._logout = { _, completion in
            completion(.success(true))
        }
        let expectation2 = self.expectation(description: "isLoading2")
        expectation2.expectedFulfillmentCount = 3
        vm.output.isLoading = { isLoading in
            expectation2.fulfill()
        }
        vm.input.ready?()
        vm.input.logoutSelected?()
        self.waitForExpectations(timeout: 1)
    }
    
    func testLoginTitle() {
        let authMock = AuthDataServiceKeychainMock()
        let apiMock = APIAuthServiceMock()
        let vm = RootViewModel(auth: authMock, api: apiMock)
        
        let expectation = self.expectation(description: "testLoginTitle")
        vm.output.loginTitle = { title in
            expectation.fulfill()
            XCTAssertEqual(title, "login")
        }
        vm.input.ready?()
        self.waitForExpectations(timeout: 1)
    }
    
    func testLogoutTitle() {
        let authMock = AuthDataServiceKeychainMock()
        let apiMock = APIAuthServiceMock()
        let vm = RootViewModel(auth: authMock, api: apiMock)
        
        let expectation = self.expectation(description: "testLogoutTitle")
        vm.output.logoutTitle = { title in
            expectation.fulfill()
            XCTAssertEqual(title, "logout")
        }
        vm.input.ready?()
        self.waitForExpectations(timeout: 1)
    }
    
    func testContactListTitle() {
        let authMock = AuthDataServiceKeychainMock()
        let apiMock = APIAuthServiceMock()
        let vm = RootViewModel(auth: authMock, api: apiMock)
        
        let expectation = self.expectation(description: "testContactListTitle")
        vm.output.contactListTitle = { title in
            expectation.fulfill()
            XCTAssertEqual(title, "contacts")
        }
        vm.input.ready?()
        self.waitForExpectations(timeout: 1)
    }
    
    func testButtonsEnabled() {
        let authMock = AuthDataServiceKeychainMock()
        let apiMock = APIAuthServiceMock()
        let vm = RootViewModel(auth: authMock, api: apiMock)
        
        authMock._data = nil
        let expectation1 = self.expectation(description: "testButtonsEnabled1")
        expectation1.expectedFulfillmentCount = 3
        vm.output.isLoginEnabled = { enabled in
            expectation1.fulfill()
            XCTAssertTrue(enabled)
        }
        vm.output.isLogoutEnabled = { enabled in
            expectation1.fulfill()
            XCTAssertFalse(enabled)
        }
        vm.output.isContactListEnabled = { enabled in
            expectation1.fulfill()
            XCTAssertFalse(enabled)
        }
        vm.input.ready?()
        self.waitForExpectations(timeout: 1)
        
        
        
        authMock._data = "Token"
        let expectation2 = self.expectation(description: "testButtonsEnabled2")
        expectation2.expectedFulfillmentCount = 3
        vm.output.isLoginEnabled = { enabled in
            expectation2.fulfill()
            XCTAssertFalse(enabled)
        }
        vm.output.isLogoutEnabled = { enabled in
            expectation2.fulfill()
            XCTAssertTrue(enabled)
        }
        vm.output.isContactListEnabled = { enabled in
            expectation2.fulfill()
            XCTAssertTrue(enabled)
        }
        vm.input.ready?()
        self.waitForExpectations(timeout: 1)
    }
    
    func testLoginSelected() {
        let authMock = AuthDataServiceKeychainMock()
        let apiMock = APIAuthServiceMock()
        let vm = RootViewModel(auth: authMock, api: apiMock)
        
        authMock._data = nil
        let expectation1 = self.expectation(description: "testLoginSelected1")
        vm.output.loginSelected = {
            expectation1.fulfill()
        }
        vm.input.ready?()
        vm.input.loginSelected?()
        self.waitForExpectations(timeout: 1)
        
        
        authMock._data = "Token"
        let expectation2 = self.expectation(description: "testLoginSelected2")
        expectation2.isInverted = true
        vm.output.loginSelected = {
            expectation2.fulfill()
        }
        vm.input.ready?()
        vm.input.loginSelected?()
        self.waitForExpectations(timeout: 0.1)
    }
    
    func testContactListSelected() {
        let authMock = AuthDataServiceKeychainMock()
        let apiMock = APIAuthServiceMock()
        let vm = RootViewModel(auth: authMock, api: apiMock)
        
        authMock._data = "Token"
        let expectation1 = self.expectation(description: "testContactListSelected1")
        vm.output.contactListSelected = {
            expectation1.fulfill()
        }
        vm.input.ready?()
        vm.input.contactListSelected?()
        self.waitForExpectations(timeout: 1)
        
        
        authMock._data = nil
        let expectation2 = self.expectation(description: "testContactListSelected2")
        expectation2.isInverted = true
        vm.output.contactListSelected = {
            expectation2.fulfill()
        }
        vm.input.ready?()
        vm.input.contactListSelected?()
        self.waitForExpectations(timeout: 0.1)
    }
}
