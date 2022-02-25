//
//  MainCoordinator.swift
//  VideoCallDemo
//
//  Created by Daniele Salvioni on 19/02/22.
//

import Foundation
import UIKit

struct MainCoordinator {
    private (set) weak var rootController: UINavigationController?
}

// MARK: Start
extension MainCoordinator: CoordinatorProtocol {
    func start() {
        self.flowRoot(animated: false)
    }
}

// MARK: Create
private extension MainCoordinator {
    func createRoot() -> UIViewController {
        let dataTask = DataTaskService(session: URLSession(configuration: .default))
        let network = NetworkService(dataTask: dataTask)
        let api = APIAuthService(baseURL: Resources.Api.baseURL, networkService: network)
        let auth = AuthDataServiceKeychain(accessKey: Resources.Keychain.accessKey, valueKey: Resources.Keychain.Token.valueKey)
        let vm = RootViewModel(auth: auth, api: api)
        let vc = RootViewController(viewModel: vm)
        vm.output.loginSelected = { DispatchQueue.main.async { self.flowLogin(animated: true) } }
        vm.output.contactListSelected = { DispatchQueue.main.async { self.flowContactList(animated: true) } }
        return vc
    }
    
    func createLogin() -> UIViewController {
        let dataTask = DataTaskService(session: URLSession(configuration: .default))
        let network = NetworkService(dataTask: dataTask)
        let api = APIAuthService(baseURL: Resources.Api.baseURL, networkService: network)
        let auth = AuthDataServiceKeychain(accessKey: Resources.Keychain.accessKey, valueKey: Resources.Keychain.Token.valueKey)
        let vm = LoginViewModel(auth: auth, api: api)
        let vc = LoginViewController(viewModel: vm)
        vm.output.loginSucceded = { DispatchQueue.main.async { self.rootController?.popViewController(animated: true) } }
        return vc
    }
    
    func createContactList() -> UIViewController {
        let dataTask = DataTaskService(session: URLSession(configuration: .default))
        let network = NetworkService(dataTask: dataTask)
        let api = APIContactsService(baseURL: Resources.Api.baseURL, networkService: network)
        let auth = AuthDataServiceKeychain(accessKey: Resources.Keychain.accessKey, valueKey: Resources.Keychain.Token.valueKey)
        let vm = ContactListViewModel(auth: auth, api: api)
        vm.output.callSelected = { contacts in
            DispatchQueue.main.async {
                self.flowCall(items: contacts)
            }
        }
        let datasource = ContactListDatasource(provider: vm)
        let vc = ContactListViewController(viewModel: vm, datasource: datasource)
        return vc
    }
    
    func createCall(items: [ContactList.Contact]) -> UIViewController {
        let dataTask = DataTaskService(session: URLSession(configuration: .default))
        let network = NetworkService(dataTask: dataTask)
        let api = APIStreamService(baseURL: Resources.Api.baseURL, networkService: network)
        let auth = AuthDataServiceKeychain(accessKey: Resources.Keychain.accessKey, valueKey: Resources.Keychain.Token.valueKey)
        let call = CallService(api: api, auth: auth)
        let vm = CallViewModel(contacts: items, call: call)
        vm.output.hangupSelected = { DispatchQueue.main.async { self.rootController?.popToRootViewController(animated: true) } }
        call.delegate = vm
        let vc = CallViewController(viewModel: vm)
        return vc
    }
}

// MARK: Flow
private extension MainCoordinator {
    func flowRoot(animated: Bool = true) {
        let vc = self.createRoot()
        self.rootController?.pushViewController(vc, animated: animated)
    }
    
    func flowLogin(animated: Bool = true) {
        let vc = self.createLogin()
        self.rootController?.pushViewController(vc, animated: animated)
    }
    
    func flowContactList(animated: Bool = true) {
        let vc = self.createContactList()
        self.rootController?.pushViewController(vc, animated: animated)
    }
    
    func flowCall(animated: Bool = true, items: [ContactList.Contact]) {
        let vc = self.createCall(items: items)
        self.rootController?.pushViewController(vc, animated: animated)
    }
}

