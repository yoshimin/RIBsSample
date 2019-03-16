//
//  RootComponent.swift
//  RIBsSample
//
//  Created by Yoshimi Shingai on 2019/03/16.
//  Copyright © 2019 SHINGAI YOSHIMI. All rights reserved.
//

import RIBs

final class RootComponent: Component<EmptyDependency>, NewestDependency {
    var repository: ItemsRepository {
        return shared { ItemsRepositoryImpl() }
    }
    
    init() {
        super.init(dependency: EmptyComponent())
    }
}
