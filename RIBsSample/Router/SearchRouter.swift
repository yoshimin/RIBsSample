//
//  SearchRouter.swift
//  RIBsSample
//
//  Created by SHINGAI YOSHIMI on 2019/01/29.
//  Copyright © 2019 SHINGAI YOSHIMI. All rights reserved.
//

import RIBs

protocol SearchRouting: ViewableRouting {
    func route(toItem item: Item)
    func route(toUser user: User)
}

protocol SearchInteractable: Interactable {
    var router: SearchRouting? { get set }
}

protocol SearchViewControllable: ViewControllable {
    func present(view: ViewControllable)
}

class SearchRouter: NavigationBasedLaunchRouter<Interactable, SearchViewControllable>, SearchRouting {
    private let itemBuilder: ItemBuildable

    init(interactor: SearchInteractable, viewController: SearchViewControllable, itemBuilder: ItemBuildable) {
        self.itemBuilder = itemBuilder
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }

    func route(toItem item: Item) {
        let router = itemBuilder.build(item: item)
        attachChild(router)

        viewController.present(view: router.viewControllable)
    }

    func route(toUser user: User) {

    }
}
