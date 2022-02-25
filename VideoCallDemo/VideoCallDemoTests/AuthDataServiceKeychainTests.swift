//
//  AuthDataServiceKeychainTests.swift
//  VideoCallDemoTests
//
//  Created by Daniele Salvioni on 23/02/22.
//

import XCTest
@testable import VideoCallDemo

class AuthDataServiceKeychainTests: XCTestCase {
    
    func testAuthDataServiceKeychain() throws {
        let persistence = AuthDataServiceKeychain(accessKey: "VideoCallDemo.Test", valueKey: "testAuthDataServiceKeychain")
        try persistence.remove()
        
        try persistence.add(token: "TestToken")
        let result1 = try persistence.current()
        XCTAssertEqual(result1, "TestToken")
        
        let result2 = try persistence.isPresent()
        XCTAssertTrue(result2)
        
        try persistence.remove()
        let result3 = try persistence.current()
        XCTAssertNil(result3)
        
        let result4 = try persistence.isPresent()
        XCTAssertFalse(result4)
    }
}
