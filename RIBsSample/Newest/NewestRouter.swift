//
//  NewestRouter.swift
//  RIBsSample
//
//  Created by Yoshimi Shingai on 2019/03/16.
//  Copyright © 2019 SHINGAI YOSHIMI. All rights reserved.
//

import RIBs

protocol NewestInteractable: Interactable {
    var router: NewestRouting? { get set }
}

class NewestRouter: NavigationBasedLaunchRouter<(NewestInteractable & ItemListInteractable), ItemListViewControllable> {
    let itemBuilder: ItemBuildable
    let searchBuilder: SearchBuildable
    
    init(interactor: (NewestInteractable & ItemListInteractable),
         viewController: ItemListViewControllable,
         itemBuilder: ItemBuildable,
         searchBuilder: SearchBuildable) {
        self.itemBuilder = itemBuilder
        self.searchBuilder = searchBuilder
        super.init(interactor: interactor, viewController: viewController)
        interactor.itemListRouter = self
        interactor.router = self
    }
}

extension NewestRouter: ItemListRouting {
    func route(toItem item: Item) {
        let router = itemBuilder.build(item: item)
        attachChild(router)
        
        viewController.present(view: router.viewControllable)
    }
    
    func route(toUser user: User) {
        
    }
}
extension NewestRouter: NewestRouting {
    func routeToSearch() {
        let router = searchBuilder.build()
        attachChild(router)
        
        viewController.present(view: router.viewControllable)
    }
}
