//
//  SearchBuilder.swift
//  RIBsSample
//
//  Created by SHINGAI YOSHIMI on 2019/01/29.
//  Copyright © 2019 SHINGAI YOSHIMI. All rights reserved.
//

import RIBs

protocol SearchBuildable: Buildable {
    func build() -> ViewableRouting
}

class SearchBuilder: Builder<ItemsDependency>, SearchBuildable {
    func build() -> ViewableRouting {
        let component = ItemsComponent(dependency: dependency)
        let viewController = SearchViewController(style: .plain)
        let interactor = SearchInteractor(presenter: viewController, mutableItemsStream: component.mutableStream)
        let itemBuilder = ItemBuilder()
        let userBuilder = UserBuilder(dependency: dependency)
        return SearchRouter(interactor: interactor, viewController: viewController, itemBuilder: itemBuilder, userBuilder: userBuilder)
    }
}
