//
//  ItemListInteractor.swift
//  RIBsSample
//
//  Created by Yoshimi Shingai on 2019/03/16.
//  Copyright © 2019 SHINGAI YOSHIMI. All rights reserved.
//

import RIBs
import RxSwift

protocol ItemListRouting: ViewableRouting {
    var itemBuilder: ItemBuildable { get }
    
    func route(toItem item: Item)
    func route(toUser user: User)
}

protocol ItemListPresentableListener: class {
    var items: Observable<Items> { get }
    
    func didSelectItem(_ item: Item)
    func didSelectUser(_ user: User)
}

extension ItemListPresentableListener where Self: ItemListInteractable {
    func didSelectItem(_ item: Item) {
        itemListRouter?.route(toItem: item)
    }
    
    func didSelectUser(_ user: User) {
        itemListRouter?.route(toUser: user)
    }
}
