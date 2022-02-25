//
//  CallViewModel.swift
//  VideoCallDemo
//
//  Created by Daniele Salvioni on 20/02/22.
//

import Foundation

class CallViewModel {
    let input = Input()
    let output = Output()
    
    private let contacts: [ContactList.Contact]
    private let call: CallProtocol
    
    init(contacts: [ContactList.Contact], call: CallProtocol) {
        self.contacts = contacts
        self.call = call
        
        self.input.ready = self.ready
        self.input.hangupSelected = self.hangupSelected
    }
}

private extension CallViewModel {
    func ready() {
        self.output.titleMain?(NSLocalizedString("Call.title", comment: ""))
        self.output.hangupTitle?(NSLocalizedString("Call.hangup.button.title", comment: ""))
        
        self.connect() {}
    }
    
    func hangupSelected() {
        self.diconnect() { [weak self] in
            self?.output.hangupSelected?()
        }
    }
}

private extension CallViewModel {
    func connect(completion: @escaping () -> Void) {
        self.output.isLoading?(true)
        self.call.connect(contacts: self.contacts) { [weak self] result in
            guard let self = self else { return }
            defer { self.output.isLoading?(false) }
            
            switch result {
            case .success(let success):
                if !success {
                    self.output.error?(NSLocalizedString("Call.error.connection", comment: ""))
                }
            case .failure(let error):
                self.output.error?(error.localizedDescription)
            }
            
            completion()
        }
    }
    
    func diconnect(completion: @escaping () -> Void) {
        self.output.isLoading?(true)
        self.call.disconnect { [weak self] result in
            guard let self = self else { return }
            defer { self.output.isLoading?(false) }
            
            switch result {
            case .success(let success):
                if !success {
                    self.output.error?(NSLocalizedString("Call.error.connection", comment: ""))
                }
            case .failure(let error):
                self.output.error?(error.localizedDescription)
            }
            
            completion()
        }
    }
}

extension CallViewModel: CallProtocolDelegate {
    func didAddStream(stream: Stream) {
        let streamsRendered = max(0, self.call.currentStreamsCount()-1)
        if (streamsRendered % 2) == 0 {
            // odd stream
            self.output.addOddFeed?((videoStream: stream.video, videoId: stream.contactID))
        } else {
            // even stream
            self.output.addEvenFeed?((videoStream: stream.video, videoId: stream.contactID))
        }
    }
    
    func didRemoveStream(stream: Stream) {
        self.output.removeFeed?((videoStream: stream.video, videoId: stream.contactID))
    }
}

extension CallViewModel {
    class Input {
        var ready: VoidClosure?
        var hangupSelected: VoidClosure?
    }
    
    class Output {
        var titleMain: VoidOutputClosure<String>?
        var error: VoidOutputClosure<String>?
        var isLoading: VoidOutputClosure<Bool>?
        var hangupTitle: VoidOutputClosure<String>?
        var addOddFeed: VoidOutputClosure<(videoStream: URL, videoId: Int)>?
        var addEvenFeed: VoidOutputClosure<(videoStream: URL, videoId: Int)>?
        var removeFeed: VoidOutputClosure<(videoStream: URL, videoId: Int)>?
        var hangupSelected: VoidClosure?
    }
}
