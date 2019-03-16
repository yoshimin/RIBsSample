//
//  ItemBuilder.swift
//  RIBsSample
//
//  Created by SHINGAI YOSHIMI on 2019/02/07.
//  Copyright © 2019 SHINGAI YOSHIMI. All rights reserved.
//

import RIBs

protocol ItemBuildable: Buildable {
    func build(item: Item) -> ViewableRouting
}

class ItemBuilder: ItemBuildable {
    func build(item: Item) -> ViewableRouting {
        let viewController = StoryboardScene.Item.initialScene.instantiate()
        viewController.item = item
        let interactor = ItemInteractor(presenter: viewController)
        return ItemRouter(interactor: interactor, viewController: viewController)
    }
}
