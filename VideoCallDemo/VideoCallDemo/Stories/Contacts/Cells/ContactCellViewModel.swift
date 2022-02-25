//
//  ContactCellViewModel.swift
//  VideoCallDemo
//
//  Created by Daniele Salvioni on 21/02/22.
//

import Foundation

class ContactCellViewModel {
    let input = Input()
    let output = Output()
    
    private let firstName: String
    private let lastName: String
    private let imageUrl: URL?
    private let selected: Bool
    
    init(firstName: String, lastName: String, imageUrl: URL?, selected: Bool) {
        self.firstName = firstName
        self.lastName = lastName
        self.imageUrl = imageUrl
        self.selected = selected
        
        self.input.ready = self.ready
        self.input.reset = self.reset
    }
}

private extension ContactCellViewModel {
    func ready() {
        self.output.firstName?(self.firstName)
        self.output.lastName?(self.lastName)
        self.output.imageURL?(self.imageUrl)
        self.output.selected?(self.selected)
    }
    
    func reset() {
        self.output.reset?()
    }
}

extension ContactCellViewModel {
    class Input {
        var ready: VoidClosure?
        var reset: VoidClosure?
    }
    
    class Output {
        var reset: VoidClosure?
        var firstName: VoidOutputClosure<String>?
        var lastName: VoidOutputClosure<String>?
        var imageURL: VoidOutputClosure<URL?>?
        var selected: VoidOutputClosure<Bool>?
    }
}
