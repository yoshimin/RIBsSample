//
//  SearchRouter.swift
//  RIBsSample
//
//  Created by Yoshimi Shingai on 2019/03/17.
//  Copyright © 2019 SHINGAI YOSHIMI. All rights reserved.
//

import RIBs

class SearchRouter: ViewableRouter<ItemListInteractable, ItemListViewControllable> {
    let itemBuilder: ItemBuildable
    
    init(interactor: ItemListInteractable,
         viewController: ItemListViewControllable,
         itemBuilder: ItemBuildable) {
        self.itemBuilder = itemBuilder
        super.init(interactor: interactor, viewController: viewController)
        interactor.itemListRouter = self
    }
}

extension SearchRouter: ItemListRouting {
    func route(toItem item: Item) {
        let router = itemBuilder.build(item: item)
        attachChild(router)
        
        viewController.present(view: router.viewControllable)
    }
    
    func route(toUser user: User) {
        
    }
}

