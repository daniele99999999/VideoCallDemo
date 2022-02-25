//
//  ContactListView.swift
//  VideoCallDemo
//
//  Created by Daniele Salvioni on 20/02/22.
//

import Foundation
import UIKit

class ContactListView: UIView {
    private lazy var containerView: UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        return view
    }()
    
    lazy var callButton: UIButton = {
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
    
    private lazy var tableView: UITableView = {
        let view = UITableView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        view.registerCell(className: ContactCell.self)
        view.rowHeight = Resources.Layout.Contacts.Cell.itemHeight + Resources.Layout.Contacts.Cell.itemSpacing
        view.contentInset = .zero
        view.separatorStyle = .none
        view.showsVerticalScrollIndicator = true
        view.allowsSelection = true
        view.allowsMultipleSelection = false
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
        
        self.containerView.addSubview(self.callButton)
        NSLayoutConstraint.activate([
            self.callButton.leadingAnchor.constraint(equalTo: self.containerView.leadingAnchor, constant: Resources.Layout.Contacts.horizontalInsets),
            self.callButton.topAnchor.constraint(equalTo: self.containerView.topAnchor, constant: Resources.Layout.Contacts.topInset),
            self.callButton.trailingAnchor.constraint(equalTo: self.containerView.trailingAnchor, constant: -Resources.Layout.Contacts.horizontalInsets),
        ])
        
        self.containerView.addSubview(self.tableView)
        NSLayoutConstraint.activate([
            self.tableView.topAnchor.constraint(equalTo: self.callButton.bottomAnchor, constant: Resources.Layout.Contacts.verticalPadding),
            self.tableView.bottomAnchor.constraint(equalTo: self.containerView.bottomAnchor),
            self.tableView.leadingAnchor.constraint(equalTo: self.containerView.leadingAnchor, constant: Resources.Layout.Contacts.Table.horizontalInsets),
            self.tableView.trailingAnchor.constraint(equalTo: self.containerView.trailingAnchor, constant: -Resources.Layout.Contacts.Table.horizontalInsets)
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

extension ContactListView {
    func updateCallButtonTitle(_ title: String) {
        self.callButton.setTitle(title, for: .normal)
    }
    
    func setTableView(delegate: UITableViewDelegate, dataSource: UITableViewDataSource) {
        self.tableView.delegate = delegate
        self.tableView.dataSource = dataSource
    }
    
    func updateContactsItems() {
        self.tableView.beginUpdates()
        self.tableView.reloadSections(IndexSet(integersIn: 0...0), with: .fade)
        self.tableView.endUpdates()
    }
    
    func updateContactsItems(indexPaths: [IndexPath]) {
        self.tableView.beginUpdates()
        self.tableView.reloadRows(at: indexPaths, with: .fade)
        self.tableView.endUpdates()
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
