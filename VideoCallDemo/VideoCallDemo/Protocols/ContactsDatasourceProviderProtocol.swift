//
//  ContactsDatasourceProviderProtocol.swift
//  VideoCallDemo
//
//  Created by Daniele Salvioni on 22/02/22.
//

import Foundation

protocol ContactsDatasourceProviderProtocol {
    var itemsCount: Int { get }
    func itemCellViewModel(index: IndexPath) -> ContactCellViewModel
}
