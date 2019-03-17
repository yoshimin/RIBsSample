//
//  ItemListViewControllable.swift
//  RIBsSample
//
//  Created by Yoshimi Shingai on 2019/03/16.
//  Copyright © 2019 SHINGAI YOSHIMI. All rights reserved.
//

import RIBs

protocol ItemListViewControllable: ViewControllable {
    func present(view: ViewControllable)
}

extension ItemListViewControllable where Self: UIViewController {
    func present(view: ViewControllable) {
        navigationController?.pushViewController(view.uiviewController, animated: true)
    }
}

protocol ItemListInteractable: Interactable {
    var itemListRouter: ItemListRouting? { get set }
}

protocol HasItemListViewControllable {
    var viewController: ItemListViewControllable { get }
}

extension ItemListRouting where Self: HasItemListViewControllable {
    func route(toItem item: Item) {
        let router = itemBuilder.build(item: item)
        attachChild(router)
        
        viewController.present(view: router.viewControllable)
    }
    
    func route(toUser user: User) {
        let router = userBuilder.build(user: user)
        attachChild(router)
        
        viewController.present(view: router.viewControllable)
    }
}
