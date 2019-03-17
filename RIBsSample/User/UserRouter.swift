//
//  UserRouter.swift
//  RIBsSample
//
//  Created by Yoshimi Shingai on 2019/03/17.
//  Copyright © 2019 SHINGAI YOSHIMI. All rights reserved.
//

import RIBs

final class UserRouter: ViewableRouter<ItemListInteractable, ItemListViewControllable>, UserRouting {
    let itemBuilder: ItemBuildable
    let userBuilder: UserBuildable

    init(interactor: ItemListInteractable, viewController: ItemListViewControllable, itemBuilder: ItemBuilder, userBuilder: UserBuildable) {
        self.itemBuilder = itemBuilder
        self.userBuilder = userBuilder
        super.init(interactor: interactor, viewController: viewController)
        interactor.itemListRouter = self
    }
}

extension UserRouter: ItemListRouting {
    func route(toItem item: Item) {
        let router = itemBuilder.build(item: item)
        attachChild(router)
        
        viewController.present(view: router.viewControllable)
    }
    
    func route(toUser user: User) {
        // Nothing to do.
    }
}
