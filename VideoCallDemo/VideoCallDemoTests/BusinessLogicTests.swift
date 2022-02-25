//
//  BusinessLogicTests.swift
//  VideoCallDemoTests
//
//  Created by Daniele Salvioni on 24/02/22.
//

import XCTest
@testable import VideoCallDemo

class BusinessLogicTests: XCTestCase {
    
    func testBusinessLogicImageUrl() {
        let result = BusinessLogic.imageUrl(thumbnail: .init(path: "https://www.google.it"))
        XCTAssertEqual(result, URL(string: "https://www.google.it"))
    }
    
    func testBusinessLogicStreamIsOwnByContact() {
        let result1 = BusinessLogic.streamIsOwnByContact(stream: .init(contactID: 10,
                                                                       video: URL(string: "https://picsum.photos/id/\(10)/400")!),
                                                         contact: .init(id: 10,
                                                                        firstName: "Daniele",
                                                                        lastName: "Rossi",
                                                                        avatar: .init(path: "https://picsum.photos/id/10/200")))
        XCTAssertTrue(result1)
        
        let result2 = BusinessLogic.streamIsOwnByContact(stream: .init(contactID: 10,
                                                                       video: URL(string: "https://picsum.photos/id/\(10)/400")!),
                                                         contact: .init(id: 20,
                                                                        firstName: "Daniele",
                                                                        lastName: "Rossi",
                                                                        avatar: .init(path: "https://picsum.photos/id/10/200")))
        XCTAssertFalse(result2)
    }
}
