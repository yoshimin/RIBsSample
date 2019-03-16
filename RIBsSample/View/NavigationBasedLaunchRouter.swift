//
//  NavigationBasedLaunchRouter.swift
//  RIBsSample
//
//  Created by SHINGAI YOSHIMI on 2019/02/08.
//  Copyright © 2019 SHINGAI YOSHIMI. All rights reserved.
//

import RIBs

public protocol NavigationBasedLaunchRouting: ViewableRouting {
    func launch(from window: UIWindow)
}

class NavigationBasedLaunchRouter<InteractorType, ViewControllerType>: ViewableRouter<InteractorType, ViewControllerType>, NavigationBasedLaunchRouting {
    public override init(interactor: InteractorType, viewController: ViewControllerType) {
        super.init(interactor: interactor, viewController: viewController)
    }

    func launch(from window: UIWindow) {
        window.rootViewController = UINavigationController(rootViewController: viewControllable.uiviewController)
        window.makeKeyAndVisible()

        interactable.activate()
        load()
    }
}
