//
//  LoginView.swift
//  VideoCallDemo
//
//  Created by Daniele Salvioni on 20/02/22.
//

import Foundation
import UIKit

class LoginView: UIView {
    private lazy var containerView: UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        return view
    }()
    
    private lazy var stackContainerView: UIStackView = {
        let view = UIStackView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .vertical
        view.distribution = .fill
        view.alignment = .fill
        view.spacing = 10
        view.backgroundColor = .clear
        return view
    }()
    
    private lazy var usernameTextField: UITextField = {
        let view = UITextField(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = Resources.UI.Colors.colorFFFFFF
        view.font = Resources.UI.Fonts.systemRegular(size: 15)
        view.adjustsFontForContentSizeCategory = true
        view.textColor = Resources.UI.Colors.color000000
        view.placeholder = nil
        view.text = nil
        return view
    }()
    
    private lazy var passwordTextField: UITextField = {
        let view = UITextField(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = Resources.UI.Colors.colorFFFFFF
        view.font = Resources.UI.Fonts.systemRegular(size: 15)
        view.adjustsFontForContentSizeCategory = true
        view.textColor = Resources.UI.Colors.color000000
        view.isSecureTextEntry = true
        view.placeholder = nil
        view.text = nil
        return view
    }()
    
    lazy var loginButton: UIButton = {
        let view = UIButton(type: .custom)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = Resources.UI.Colors.colorFFFFFF
        view.titleLabel?.font = Resources.UI.Fonts.systemRegular(size: 15)
        view.titleLabel?.numberOfLines = 1
        view.setTitleColor(Resources.UI.Colors.color000000, for: .normal)
        view.setTitleColor(Resources.UI.Colors.color000000.withAlphaComponent(0.5), for: .highlighted)
        view.setTitle(nil, for: .normal)
        return view
    }()
    
    private lazy var loaderView: UIActivityIndicatorView = {
        let view: UIActivityIndicatorView
        if #available(iOS 13.0, *) {
            view = UIActivityIndicatorView(style: .medium)
        } else {
            view = UIActivityIndicatorView(style: .gray)
        }
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = Resources.UI.Colors.color000000.withAlphaComponent(0.3)
        view.color = Resources.UI.Colors.colorFFFFFF
        view.stopAnimating()
        return view
    }()
   
    init() {
        super.init(frame: .zero)
        self.setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        self.backgroundColor = Resources.UI.Colors.colorC8C8C8
        
        self.addSubview(self.containerView)
        NSLayoutConstraint.activate([
            self.containerView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.containerView.topAnchor.constraint(equalTo: self.topAnchor),
            self.containerView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.containerView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
        
        self.containerView.addSubview(self.stackContainerView)
        NSLayoutConstraint.activate([
            self.stackContainerView.topAnchor.constraint(equalTo: self.containerView.topAnchor, constant: Resources.Layout.Login.topInset),
            self.stackContainerView.leadingAnchor.constraint(equalTo: self.containerView.leadingAnchor, constant: Resources.Layout.Login.horizontalInsets),
            self.stackContainerView.trailingAnchor.constraint(equalTo: self.containerView.trailingAnchor, constant: -Resources.Layout.Login.horizontalInsets)
        ])
        
        self.stackContainerView.addArrangedSubview(self.usernameTextField)
        self.stackContainerView.addArrangedSubview(self.passwordTextField)
        self.stackContainerView.addArrangedSubview(self.loginButton)
        NSLayoutConstraint.activate([
            self.loginButton.heightAnchor.constraint(equalToConstant: 48),
        ])
        
        
        self.containerView.addSubview(self.loaderView)
        NSLayoutConstraint.activate([
            self.loaderView.topAnchor.constraint(equalTo: self.containerView.topAnchor),
            self.loaderView.bottomAnchor.constraint(equalTo: self.containerView.bottomAnchor),
            self.loaderView.leadingAnchor.constraint(equalTo: self.containerView.leadingAnchor),
            self.loaderView.trailingAnchor.constraint(equalTo: self.containerView.trailingAnchor)
        ])
    }
}

extension LoginView {
    func getUsername() -> String? {
        return self.usernameTextField.text
    }
    
    func getPassword() -> String? {
        return self.passwordTextField.text
    }
}

extension LoginView {
    func updateUsernamePlaceholder(_ title: String) {
        self.usernameTextField.placeholder = title
    }
    
    func updatePasswordPlaceholder(_ title: String) {
        self.passwordTextField.placeholder = title
    }
    
    func updateLoginButtonTitle(_ title: String) {
        self.loginButton.setTitle(title, for: .normal)
    }
    
    func startLoader() {
        self.loaderView.startAnimating()
        self.loaderView.isHidden = false
    }

    func stopLoader() {
        self.loaderView.stopAnimating()
        self.loaderView.isHidden = true
    }
}
