//
//  UserInteractor.swift
//  RIBsSample
//
//  Created by Yoshimi Shingai on 2019/03/17.
//  Copyright © 2019 SHINGAI YOSHIMI. All rights reserved.
//

import RIBs
import RxSwift

protocol UserRouting: ItemListRouting {}

protocol UserPresentable: Presentable {
    var listener: UserPresentableListener? { get set }
    // TODO: Declare methods the interactor can invoke the presenter to present data.
}

final class UserInteractor: PresentableInteractor<UserPresentable>, ItemListInteractable {
    private let mutableItemsStream: MutableItemsStream
    private let userId: String
    
    weak var itemListRouter: ItemListRouting?
    var items: Observable<Items>

    init(presenter: UserPresentable, mutableItemsStream: MutableItemsStream, userId: String) {
        self.mutableItemsStream = mutableItemsStream
        self.userId = userId
        items = self.mutableItemsStream.items
        
        super.init(presenter: presenter)
        presenter.listener = self
    }

    override func didBecomeActive() {
        super.didBecomeActive()
        
        let query = "user:" + userId
        mutableItemsStream.fetch(page: nil, perPage: nil, query: query)
    }
}

extension UserInteractor: UserPresentableListener {}
