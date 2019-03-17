//
//  ItemListBuilder.swift
//  RIBsSample
//
//  Created by Yoshimi Shingai on 2019/03/16.
//  Copyright © 2019 SHINGAI YOSHIMI. All rights reserved.
//

import RIBs

protocol ItemsDependency: Dependency {
    var repository: ItemsRepository { get }
}

class ItemsComponent: Component<ItemsDependency> {
    let repository: ItemsRepository
    
    var mutableStream: MutableItemsStream {
        return shared { ItemsStreamImpl(repository: repository) }
    }
    
    override init(dependency: ItemsDependency) {
        self.repository = dependency.repository
        super.init(dependency: dependency)
    }
}
