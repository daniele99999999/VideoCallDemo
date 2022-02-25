//
//  ContactListViewModel.swift
//  VideoCallDemo
//
//  Created by Daniele Salvioni on 20/02/22.
//

import Foundation

class ContactListViewModel {
    let input = Input()
    let output = Output()
    
    private let auth: AuthDataProtocol
    private let api: APIContactsProtocol
    
    private var list: [(item: ContactList.Contact, selected: Bool)] = []
    
    init(auth: AuthDataProtocol, api: APIContactsProtocol) {
        self.auth = auth
        self.api = api
        
        self.input.ready = self.ready
        self.input.contactSelected = self.contactSelected
        self.input.callSelected = self.callSelected
    }
}

private extension ContactListViewModel {
    func ready() {
        self.output.titleMain?(NSLocalizedString("ContactList.title", comment: ""))
        self.output.callTitle?(NSLocalizedString("ContactList.call.button.title", comment: ""))
        self.output.isLoading?(false)
        self.fetchContacts()
    }
    
    func contactSelected(index: IndexPath) {
        if self.list[index.row].selected {
            self.removeCallContact(index: index)
        } else {
            self.addCallContact(index: index)
        }
    }
    
    func callSelected() {
        let concactsForCall = self.retrieveContactsSelected()
        if concactsForCall.count > 0 {
            self.output.callSelected?(concactsForCall)
        } else {
            self.output.error?(NSLocalizedString("ContactList.error.tooLessContacts", comment: ""))
        }
    }
}

private extension ContactListViewModel {
    func fetchContacts() {
        guard let token = try? self.auth.current() else {
            self.output.error?(NSLocalizedString("ContactList.error.token", comment: ""))
            return
        }
        
        self.output.isLoading?(true)
        self.api.getList(user: token) { [weak self] result in
            guard let self = self else { return }
            defer { self.output.isLoading?(false) }
            
            switch result {
            case .success(let contactList):
                self.list = contactList.results.enumerated().map({ (item: $0.element, selected: false) })
                self.output.contactsUpdates?()
            case .failure(let error):
                self.output.error?(error.localizedDescription)
            }
        }
    }
    
    func addCallContact(index: IndexPath) {
        self.list[index.row].selected = true
        self.output.contactUpdate?(index)
    }
    
    func removeCallContact(index: IndexPath) {
        self.list[index.row].selected = false
        self.output.contactUpdate?(index)
    }
    
    func retrieveContactsSelected() -> [ContactList.Contact] {
        return (self.list.filter { $0.selected == true }).map { $0.item }
    }
    
    func initContactCellViewModel(index: IndexPath) -> ContactCellViewModel {
        let element = self.list[index.row]
        return ContactCellViewModel(firstName: element.item.firstName,
                                    lastName: element.item.lastName,
                                    imageUrl: BusinessLogic.imageUrl(thumbnail: element.item.avatar),
                                    selected: element.selected)
    }
}

extension ContactListViewModel: ContactsDatasourceProviderProtocol {
    var itemsCount: Int {
        return self.list.count
    }
    
    func itemCellViewModel(index: IndexPath) -> ContactCellViewModel {
        return self.initContactCellViewModel(index: index)
    }
}

extension ContactListViewModel {
    class Input {
        var ready: VoidClosure?
        var contactSelected: VoidOutputClosure<IndexPath>?
        var callSelected: VoidClosure?
    }
    
    class Output {
        var titleMain: VoidOutputClosure<String>?
        var error: VoidOutputClosure<String>?
        var isLoading: VoidOutputClosure<Bool>?
        var callTitle: VoidOutputClosure<String>?
        var contactsUpdates: VoidClosure?
        var contactUpdate: VoidOutputClosure<IndexPath>?
        var callSelected: VoidOutputClosure<[ContactList.Contact]>?
    }
}

