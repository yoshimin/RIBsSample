//
//  NewestInteractor.swift
//  RIBsSample
//
//  Created by Yoshimi Shingai on 2019/03/16.
//  Copyright © 2019 SHINGAI YOSHIMI. All rights reserved.
//

import RIBs
import RxSwift

protocol NewestRouting: ItemListRouting {
    var searchBuilder: SearchBuildable { get }
    
    func routeToSearch()
}

protocol NewestPresentable: Presentable {
    var listener: NewestPresentableListener? { get set }
}

final class NewestInteractor: PresentableInteractor<NewestPresentable>, NewestInteractable, ItemListInteractable {
    var router: NewestRouting?
    var itemListRouter: ItemListRouting?
    
    private let mutableItemsStream: MutableItemsStream
    var items: Observable<Items>
    
    init(presenter: NewestPresentable, mutableItemsStream: MutableItemsStream) {
        self.mutableItemsStream = mutableItemsStream
        items = self.mutableItemsStream.items
        
        super.init(presenter: presenter)
        presenter.listener = self
    }
    
    override func didBecomeActive() {
        super.didBecomeActive()
        
        mutableItemsStream.fetch(page: 1, perPage: 20, query: "stocks:>1")
    }
}

extension NewestInteractor: NewestPresentableListener {
    func didTapSearchButton() {
        router?.routeToSearch()
    }
}
