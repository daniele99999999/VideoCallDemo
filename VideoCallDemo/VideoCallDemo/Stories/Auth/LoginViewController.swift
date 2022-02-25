//
//  LoginViewController.swift
//  VideoCallDemo
//
//  Created by Daniele Salvioni on 20/02/22.
//

import Foundation
import UIKit

class LoginViewController: UIViewController {

    private let rootView = LoginView()
    
    private let viewModel: LoginViewModel

    init(viewModel: LoginViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        self.view = self.rootView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupUI()
        self.setupBindings()
        
        self.viewModel.input.ready?()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.showBackArrowOnly()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.view.endEditing(true)
    }
}

private extension LoginViewController {
    
    func setupUI() {
        
    }
    
    func setupBindings() {
        self.viewModel.output.titleMain = Self.bindOnMain { [weak self] name in
            self?.navigationItem.title = name
        }
        
        self.viewModel.output.error = Self.bindOnMain { [weak self] error in
            self?.showErrorAlert(title: nil, message: error)
        }
        
        self.viewModel.output.isLoading = Self.bindOnMain { [weak self] isLoading in
            if isLoading {
                self?.rootView.startLoader()
            } else {
                self?.rootView.stopLoader()
            }
        }
        
        self.viewModel.output.usernamePlaceholder = Self.bindOnMain { [weak self] title in
            self?.rootView.updateUsernamePlaceholder(title)
        }
        
        self.viewModel.output.passwordPlaceholder = Self.bindOnMain { [weak self] title in
            self?.rootView.updatePasswordPlaceholder(title)
        }
        
        self.viewModel.output.loginTitle = Self.bindOnMain { [weak self] title in
            self?.rootView.updateLoginButtonTitle(title)
        }
        
        self.rootView.loginButton.addTarget(self, action: #selector(loginButtonPressed), for: .touchUpInside)
    }
}

private extension LoginViewController {
    @objc func loginButtonPressed() {
        self.viewModel.input.loginSelected?((user: self.rootView.getUsername(), password: self.rootView.getPassword()))
    }
}

