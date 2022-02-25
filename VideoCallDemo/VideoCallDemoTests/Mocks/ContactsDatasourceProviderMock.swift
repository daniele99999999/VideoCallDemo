//
//  ContactsDatasourceProviderMock.swift
//  VideoCallDemoTests
//
//  Created by Daniele Salvioni on 23/02/22.
//

import Foundation
@testable import VideoCallDemo

class ContactsDatasourceProviderMock: ContactsDatasourceProviderProtocol {
    
    var _itemsCount: Int?
    var itemsCount: Int {
        return self._itemsCount!
    }
    
    var _itemCellViewModel: ((IndexPath) -> ContactCellViewModel)?
    func itemCellViewModel(index: IndexPath) -> ContactCellViewModel {
        return self._itemCellViewModel!(index)
    }
}
