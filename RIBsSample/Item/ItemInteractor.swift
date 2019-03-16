//
//  ItemInteractor.swift
//  RIBsSample
//
//  Created by SHINGAI YOSHIMI on 2019/02/07.
//  Copyright © 2019 SHINGAI YOSHIMI. All rights reserved.
//

import RIBs

protocol ItemPresentableListener: class {
    func openLink(_ url: URL)
}

protocol ItemPresentable: Presentable {
    var listener: ItemPresentableListener? { get set }
}

class ItemInteractor: PresentableInteractor<ItemPresentable>, ItemInteractable {
    var router: ItemRouting?
    
    override init(presenter: ItemPresentable) {
        super.init(presenter: presenter)
        presenter.listener = self
    }
}

extension ItemInteractor: ItemPresentableListener {
    func openLink(_ url: URL) {
        router?.openLink(url)
    }
}
