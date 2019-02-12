//
//  ItemRouter.swift
//  RIBsSample
//
//  Created by SHINGAI YOSHIMI on 2019/02/07.
//  Copyright © 2019 SHINGAI YOSHIMI. All rights reserved.
//

import RIBs

protocol ItemInteractable: Interactable {
}

protocol ItemViewControllable: ViewControllable {
}

class ItemRouter: ViewableRouter<ItemInteractable, ItemViewControllable> {
    
}
