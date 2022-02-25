//
//  RootView.swift
//  VideoCallDemo
//
//  Created by Daniele Salvioni on 19/02/22.
//

import Foundation
import UIKit

class RootView: UIView {
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
    
    lazy var logoutButton: UIButton = {
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
    
    lazy var contactListButton: UIButton = {
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
            self.stackContainerView.leadingAnchor.constraint(equalTo: self.containerView.leadingAnchor, constant: Resources.Layout.Root.horizontalInsets),
            self.stackContainerView.centerYAnchor.constraint(equalTo: self.containerView.centerYAnchor),
            self.stackContainerView.trailingAnchor.constraint(equalTo: self.containerView.trailingAnchor, constant: -Resources.Layout.Root.horizontalInsets)
        ])
        
        self.stackContainerView.addArrangedSubview(self.loginButton)
        NSLayoutConstraint.activate([
            self.loginButton.heightAnchor.constraint(equalToConstant: 48),
        ])
        
        self.stackContainerView.addArrangedSubview(self.logoutButton)
        NSLayoutConstraint.activate([
            self.logoutButton.heightAnchor.constraint(equalToConstant: 48),
        ])
        
        self.stackContainerView.addArrangedSubview(self.contactListButton)
        NSLayoutConstraint.activate([
            self.contactListButton.heightAnchor.constraint(equalToConstant: 48),
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

extension RootView {
    func updateLoginButtonTitle(_ title: String) {
        self.loginButton.setTitle(title, for: .normal)
    }
    
    func updateLogoutButtonTitle(_ title: String) {
        self.logoutButton.setTitle(title, for: .normal)
    }
    
    func updateContactListButtonTitle(_ title: String) {
        self.contactListButton.setTitle(title, for: .normal)
    }
    
    func isLoginEnabled(_ enabled: Bool) {
        self.loginButton.isHidden = !enabled
    }
    
    func isLogoutEnabled(_ enabled: Bool) {
        self.logoutButton.isHidden = !enabled
    }
    
    func isContactListEnabled(_ enabled: Bool) {
        self.contactListButton.isHidden = !enabled
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
