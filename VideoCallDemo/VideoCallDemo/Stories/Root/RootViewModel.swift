//
//  RootViewModel.swift
//  VideoCallDemo
//
//  Created by Daniele Salvioni on 19/02/22.
//

import Foundation

class RootViewModel {
    let input = Input()
    let output = Output()
    
    private let auth: AuthDataProtocol
    private let api: APIAuthProtocol
    
    init(auth: AuthDataProtocol, api: APIAuthProtocol) {
        self.auth = auth
        self.api = api
        
        self.input.ready = self.ready
        self.input.loginSelected = self.loginSelected
        self.input.logoutSelected = self.logoutSelected
        self.input.contactListSelected = self.contactListSelected
    }
}

private extension RootViewModel {
    func ready() {
        self.output.titleMain?(NSLocalizedString("Root.title", comment: ""))
        self.output.loginTitle?(NSLocalizedString("Root.login.button.title", comment: ""))
        self.output.logoutTitle?(NSLocalizedString("Root.logout.button.title", comment: ""))
        self.output.contactListTitle?(NSLocalizedString("Root.contactList.button.title", comment: ""))
        self.output.isLoading?(false)
        self.updateButtonsStateByToken()
    }
    
    func loginSelected() {
        if !self.tokenAvailable() {
            self.output.loginSelected?()
        } else {
            self.output.error?(NSLocalizedString("Root.error.token", comment: ""))
        }
        self.updateButtonsStateByToken()
    }
    
    func logoutSelected() {
        guard let token = try? self.auth.current() else {
            self.output.error?(NSLocalizedString("Root.error.token", comment: ""))
            self.updateButtonsStateByToken()
            return
        }
        
        self.output.isLoading?(true)
        self.api.logout(token: token) { [weak self] result in
            guard let self = self else { return }
            defer { self.output.isLoading?(false) }
            
            switch result {
            case .success(let success):
                if success {
                    try? self.auth.remove()
                }
            case .failure(let error):
                self.output.error?(error.localizedDescription)
            }
            
            self.updateButtonsStateByToken()
        }
    }
    
    func contactListSelected() {
        if self.tokenAvailable() {
            self.output.contactListSelected?()
        } else {
            self.output.error?(NSLocalizedString("Root.error.token", comment: ""))
        }
        self.updateButtonsStateByToken()
    }
}

private extension RootViewModel {
    func tokenAvailable() -> Bool {
        return (try? self.auth.isPresent()) ?? false
    }
    
    func updateButtonsStateByToken() {
        let tokenPresent = self.tokenAvailable()
        self.output.isLoginEnabled?(!tokenPresent)
        self.output.isLogoutEnabled?(tokenPresent)
        self.output.isContactListEnabled?(tokenPresent)
    }
}

extension RootViewModel {
    class Input {
        var ready: VoidClosure?
        var loginSelected: VoidClosure?
        var logoutSelected: VoidClosure?
        var contactListSelected: VoidClosure?
    }
    
    class Output {
        var titleMain: VoidOutputClosure<String>?
        var error: VoidOutputClosure<String>?
        var isLoading: VoidOutputClosure<Bool>?
        var loginTitle: VoidOutputClosure<String>?
        var logoutTitle: VoidOutputClosure<String>?
        var contactListTitle: VoidOutputClosure<String>?
        var isLoginEnabled: VoidOutputClosure<Bool>?
        var isLogoutEnabled: VoidOutputClosure<Bool>?
        var isContactListEnabled: VoidOutputClosure<Bool>?
        var loginSelected: VoidClosure?
        var contactListSelected: VoidClosure?
    }
}


