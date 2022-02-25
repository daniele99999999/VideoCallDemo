//
//  RootViewController.swift
//  VideoCallDemo
//
//  Created by Daniele Salvioni on 19/02/22.
//

import Foundation
import UIKit

class RootViewController: UIViewController {

    private let rootView = RootView()
    
    private let viewModel: RootViewModel

    init(viewModel: RootViewModel) {
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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.showBackArrowOnly()
        
        self.viewModel.input.ready?()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
}

private extension RootViewController {
    
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
        
        self.viewModel.output.loginTitle = Self.bindOnMain { [weak self] title in
            self?.rootView.updateLoginButtonTitle(title)
        }
        
        self.viewModel.output.logoutTitle = Self.bindOnMain { [weak self] title in
            self?.rootView.updateLogoutButtonTitle(title)
        }
        
        self.viewModel.output.contactListTitle = Self.bindOnMain { [weak self] title in
            self?.rootView.updateContactListButtonTitle(title)
        }
        
        self.viewModel.output.isLoginEnabled = Self.bindOnMain { [weak self] enabled in
            self?.rootView.isLoginEnabled(enabled)
        }
        
        self.viewModel.output.isLogoutEnabled = Self.bindOnMain { [weak self] enabled in
            self?.rootView.isLogoutEnabled(enabled)
        }
        
        self.viewModel.output.isContactListEnabled = Self.bindOnMain { [weak self] enabled in
            self?.rootView.isContactListEnabled(enabled)
        }
        
        self.rootView.loginButton.addTarget(self, action: #selector(loginButtonPressed), for: .touchUpInside)
        self.rootView.logoutButton.addTarget(self, action: #selector(logoutButtonPressed), for: .touchUpInside)
        self.rootView.contactListButton.addTarget(self, action: #selector(contactListButtonPressed), for: .touchUpInside)
    }
}

private extension RootViewController {
    @objc func loginButtonPressed() {
        self.viewModel.input.loginSelected?()
    }
    
    @objc func logoutButtonPressed() {
        self.viewModel.input.logoutSelected?()
    }
    
    @objc func contactListButtonPressed() {
        self.viewModel.input.contactListSelected?()
    }
}
