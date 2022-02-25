//
//  LoginViewModel.swift
//  VideoCallDemo
//
//  Created by Daniele Salvioni on 20/02/22.
//

import Foundation

class LoginViewModel {
    let input = Input()
    let output = Output()
    
    private let auth: AuthDataProtocol
    private let api: APIAuthProtocol
    
    init(auth: AuthDataProtocol, api: APIAuthProtocol) {
        self.auth = auth
        self.api = api
        
        self.input.ready = self.ready
        self.input.loginSelected = self.loginSelected
    }
}

private extension LoginViewModel {
    func ready() {
        self.output.titleMain?(NSLocalizedString("Login.title", comment: ""))
        self.output.isLoading?(false)
        self.output.usernamePlaceholder?(NSLocalizedString("Login.username.placeholder.title", comment: ""))
        self.output.passwordPlaceholder?(NSLocalizedString("Login.password.placeholder.title", comment: ""))
        self.output.loginTitle?(NSLocalizedString("Login.login.button.title", comment: ""))
    }
    
    func loginSelected(credentials: (user: String?, password: String?)) {
        self.doLogin(user: credentials.user, password: credentials.password)
    }
}

private extension LoginViewModel {
    func doLogin(user: String?, password: String?) {
        guard let _user = user, let _password = password else {
            self.output.error?(NSLocalizedString("Login.login.error.credentials", comment: ""))
            return
        }
        
        self.output.isLoading?(true)
        self.api.login(user: _user, password: _password) { [weak self] result in
            guard let self = self else { return }
            defer { self.output.isLoading?(false) }
            
            switch result {
            case .success(let token):
                do {
                    try self.auth.add(token: token)
                    self.output.loginSucceded?()
                } catch let error {
                    self.output.error?(error.localizedDescription)
                }
            case .failure(let error):
                self.output.error?(error.localizedDescription)
            }
        }
    }
}

extension LoginViewModel {
    class Input {
        var ready: VoidClosure?
        var loginSelected: VoidOutputClosure<(user: String?, password: String?)>?
    }
    
    class Output {
        var titleMain: VoidOutputClosure<String>?
        var error: VoidOutputClosure<String>?
        var isLoading: VoidOutputClosure<Bool>?
        var usernamePlaceholder: VoidOutputClosure<String>?
        var passwordPlaceholder: VoidOutputClosure<String>?
        var loginTitle: VoidOutputClosure<String>?
        var loginSucceded: VoidClosure?
    }
}
