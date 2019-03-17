//
//  UserBuilder.swift
//  RIBsSample
//
//  Created by Yoshimi Shingai on 2019/03/17.
//  Copyright © 2019 SHINGAI YOSHIMI. All rights reserved.
//

import RIBs

// MARK: - Builder

protocol UserBuildable: Buildable {
    func build(user: User) -> UserRouting
}

final class UserBuilder: Builder<ItemsDependency>, UserBuildable {
    func build(user: User) -> UserRouting {
        let component = ItemsComponent(dependency: dependency)
        let viewController = UserViewController(user: user)
        let interactor = UserInteractor(presenter: viewController, mutableItemsStream: component.mutableStream, userId: user.id)
        let itemBuilder = ItemBuilder()
        let userBuilder = UserBuilder(dependency: dependency)
        return UserRouter(interactor: interactor, viewController: viewController, itemBuilder: itemBuilder, userBuilder: userBuilder)
    }
}
