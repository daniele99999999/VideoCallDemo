//
//  ContactList.swift
//  VideoCallDemo
//
//  Created by Daniele Salvioni on 19/02/22.
//

import Foundation

public struct ContactList: Codable {
    public let results: [Contact]
}

public extension ContactList {
    struct Contact: Codable {
        public let id: Int
        public let firstName: String
        public let lastName: String
        public let avatar: Thumbnail?
    }
}

extension ContactList.Contact: Equatable {
    public static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.id == rhs.id
    }
}
