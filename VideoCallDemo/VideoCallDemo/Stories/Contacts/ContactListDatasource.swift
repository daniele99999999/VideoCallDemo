//
//  ContactListDatasource.swift
//  VideoCallDemo
//
//  Created by Daniele Salvioni on 21/02/22.
//

import Foundation
import UIKit

class ContactListDatasource: NSObject {
    private let provider: ContactsDatasourceProviderProtocol
    
    init(provider: ContactsDatasourceProviderProtocol) {
        self.provider = provider
    }
}

extension ContactListDatasource: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.provider.itemsCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(className: ContactCell.self, indexPath: indexPath)
        let cellViewModel = self.provider.itemCellViewModel(index: indexPath)
        cell.set(viewModel: cellViewModel)
        return cell
    }
}
