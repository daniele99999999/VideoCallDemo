//
//  ContactListViewController.swift
//  VideoCallDemo
//
//  Created by Daniele Salvioni on 20/02/22.
//

import Foundation
import UIKit

class ContactListViewController: UIViewController {

    private let rootView = ContactListView()
    
    private let viewModel: ContactListViewModel
    private let datasource: ContactListDatasource

    init(viewModel: ContactListViewModel, datasource: ContactListDatasource) {
        self.viewModel = viewModel
        self.datasource = datasource
        
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
}

private extension ContactListViewController {
    
    func setupUI() {
        self.rootView.setTableView(delegate: self, dataSource: self.datasource)
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
        
        self.viewModel.output.callTitle = Self.bindOnMain { [weak self] title in
            self?.rootView.updateCallButtonTitle(title)
        }
        
        self.viewModel.output.contactsUpdates = Self.bindOnMain { [weak self] in
            self?.rootView.updateContactsItems()
        }
        
        self.viewModel.output.contactUpdate = Self.bindOnMain { [weak self] indexPath in
            self?.rootView.updateContactsItems(indexPaths: [indexPath])
        }
        
        self.rootView.callButton.addTarget(self, action: #selector(callButtonPressed), for: .touchUpInside)
    }
}

private extension ContactListViewController {
    @objc func callButtonPressed() {
        self.viewModel.input.callSelected?()
    }
}

extension ContactListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        
        self.viewModel.input.contactSelected?(indexPath)
    }
}
