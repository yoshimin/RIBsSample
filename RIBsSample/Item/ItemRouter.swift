//
//  ItemRouter.swift
//  RIBsSample
//
//  Created by SHINGAI YOSHIMI on 2019/02/07.
//  Copyright © 2019 SHINGAI YOSHIMI. All rights reserved.
//

import RIBs
import SafariServices

protocol ItemRouting: ViewableRouting {
    func openLink(_ url: URL)
}

protocol ItemInteractable: Interactable {
    var router: ItemRouting? { get set }
}

protocol ItemViewControllable: ViewControllable {
    func present(view: ViewControllable)
}

class ItemRouter: ViewableRouter<ItemInteractable, ItemViewControllable>, ItemRouting {
    override init(interactor: ItemInteractable, viewController: ItemViewControllable) {
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
    
    func openLink(_ url: URL) {
        let safari = SFSafariViewController(url: url)
        viewController.present(view: safari)
    }
}
