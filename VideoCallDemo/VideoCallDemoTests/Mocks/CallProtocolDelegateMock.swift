//
//  CallProtocolDelegateMock.swift
//  VideoCallDemoTests
//
//  Created by Daniele Salvioni on 24/02/22.
//

import Foundation
@testable import VideoCallDemo

class CallProtocolDelegateMock: CallProtocolDelegate {
    
    var _didAddStream: ((VideoCallDemo.Stream) -> Void)?
    func didAddStream(stream: VideoCallDemo.Stream) {
        self._didAddStream?(stream)
    }
    
    var _didRemoveStream: ((VideoCallDemo.Stream) -> Void)?
    func didRemoveStream(stream: VideoCallDemo.Stream) {
        self._didRemoveStream?(stream)
    }
}
