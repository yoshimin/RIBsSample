//
//  SearchBuilder.swift
//  RIBsSample
//
//  Created by SHINGAI YOSHIMI on 2019/01/29.
//  Copyright © 2019 SHINGAI YOSHIMI. All rights reserved.
//

import RIBs

protocol SearchBuildable: Buildable {
    func build() -> NavigationBasedLaunchRouting
}

class SearchBuilder: SearchBuildable {
    func build() -> NavigationBasedLaunchRouting {
        let viewController = StoryboardScene.Search.initialScene.instantiate()
        let interactor = SearchInteractor(presenter: viewController)
        let itemBuilder = ItemBuilder()
        return SearchRouter(interactor: interactor, viewController: viewController, itemBuilder: itemBuilder)
    }
}
