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
    let userBuilder: UserBuildable
    
    init(interactor: ItemListInteractable, viewController: ItemListViewControllable, itemBuilder: ItemBuildable, userBuilder: UserBuildable) {
        self.itemBuilder = itemBuilder
        self.userBuilder = userBuilder
        super.init(interactor: interactor, viewController: viewController)
        interactor.itemListRouter = self
    }
}

extension SearchRouter: ItemListRouting, HasItemListViewControllable {}
