//
//  SearchInteractor.swift
//  RIBsSample
//
//  Created by SHINGAI YOSHIMI on 2019/01/29.
//  Copyright © 2019 SHINGAI YOSHIMI. All rights reserved.
//

import RIBs
import RxSwift

protocol SearchRouting: ItemListRouting {}

protocol SearchPresentable: Presentable {
    var listener: SearchPresentableListener? { get set }
}

final class SearchInteractor: PresentableInteractor<SearchPresentable>, ItemListInteractable {
    private let mutableItemsStream: MutableItemsStream
    
    weak var itemListRouter: ItemListRouting?
    var items: Observable<Items>

    init(presenter: SearchPresentable, mutableItemsStream: MutableItemsStream) {
        self.mutableItemsStream = mutableItemsStream
        items = self.mutableItemsStream.items
        
        super.init(presenter: presenter)
        presenter.listener = self
    }
}

extension SearchInteractor: SearchPresentableListener, ItemListPresentableListener {
    func search(with keyword: String) {
        mutableItemsStream.fetch(page: 1, perPage: 20, query: keyword)
    }
}
