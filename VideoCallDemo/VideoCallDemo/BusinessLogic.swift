//
//  BusinessLogic.swift
//  VideoCallDemo
//
//  Created by Daniele Salvioni on 19/02/22.
//

import Foundation

public enum BusinessLogic {
    static func imageUrl(thumbnail: Thumbnail?) -> URL? {
        guard let _path = thumbnail?.path else { return nil }
        return URL(string: _path)
    }
    
    static func streamIsOwnByContact(stream: Stream, contact: ContactList.Contact) -> Bool {
        return stream.contactID == contact.id
    }
}
