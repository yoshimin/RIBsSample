//
//  ItemsStream.swift
//  RIBsSample
//
//  Created by Yoshimi Shingai on 2019/03/16.
//  Copyright © 2019 SHINGAI YOSHIMI. All rights reserved.
//

import RIBs
import RxSwift
import RxCocoa

protocol ItemsStream: class {
    var items: Observable<Items> { get }
}

protocol MutableItemsStream: ItemsStream {
    func fetch(page: Int?, perPage: Int?, query: String?)
}

class ItemsStreamImpl: MutableItemsStream {
    private let repository: ItemsRepository
    private let _items = BehaviorRelay<Items>(value: [])
    private let disposeBag = DisposeBag()
    
    var items: Observable<Items>
    
    init(repository: ItemsRepository) {
        self.repository = repository
        
        items = _items
            .asObservable()
            .distinctUntilChanged()
    }
    
    func fetch(page: Int?, perPage: Int?, query: String?) {
        repository.fetch(page: page, perPage: perPage, query: query)
            .subscribe(onSuccess: { [weak self] items in
                self?._items.accept(items)
            })
            .disposed(by: disposeBag)
    }
}

extension Item: Equatable {
    static func == (lhs: Item, rhs: Item) -> Bool {
        return lhs.id == rhs.id
    }
}
