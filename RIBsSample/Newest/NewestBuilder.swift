//
//  NewestBuilder.swift
//  RIBsSample
//
//  Created by Yoshimi Shingai on 2019/03/16.
//  Copyright © 2019 SHINGAI YOSHIMI. All rights reserved.
//

import RIBs

typealias NewestDependency = ItemsDependency

// MARK: - Builder

protocol NewestBuildable: Buildable {
    func build() -> NavigationBasedLaunchRouting
}

final class NewestBuilder: Builder<ItemsDependency>, NewestBuildable {    
    func build() -> NavigationBasedLaunchRouting {
        let component = ItemsComponent(dependency: dependency)
        let viewController = NewestViewController(style: .plain)
        let interactor = NewestInteractor(presenter: viewController, mutableItemsStream: component.mutableStream)
        let itemBuilder = ItemBuilder()
        let searchBuilder = SearchBuilder(dependency: dependency)
        return NewestRouter(interactor: interactor, viewController: viewController, itemBuilder: itemBuilder, searchBuilder: searchBuilder)
    }
}
