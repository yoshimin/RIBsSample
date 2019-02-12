//
//  SearchInteractor.swift
//  RIBsSample
//
//  Created by SHINGAI YOSHIMI on 2019/01/29.
//  Copyright © 2019 SHINGAI YOSHIMI. All rights reserved.
//

import RIBs
import RxSwift

protocol SearchPresentable: Presentable {
    var listener: SearchPresentableListener? { get set }
}

class SearchInteractor: PresentableInteractor<SearchPresentable>, SearchInteractable {
    weak var router: SearchRouting?

    override init(presenter: SearchPresentable) {
        super.init(presenter: presenter)
        presenter.listener = self
    }
}

extension SearchInteractor: SearchPresentableListener {
    func search(with keyword: String) -> Single<Items> {
        let request = GetItemsRequest(page: 1, perPage: 20, query: keyword)
        return Session().send(request)
    }

    func didSelectItem(_ item: Item) {
        router?.route(toItem: item)
    }

    func didSelectUser(_ user: User) {
        router?.route(toUser: user)
    }
}
