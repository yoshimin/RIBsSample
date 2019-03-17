//
//  ItemsRepository.swift
//  RIBsSample
//
//  Created by Yoshimi Shingai on 2019/03/16.
//  Copyright © 2019 SHINGAI YOSHIMI. All rights reserved.
//

import Foundation
import RxSwift

protocol ItemsRepository {
    func fetch(page: Int?, perPage: Int?, query: String?) -> Single<Items>
}

struct ItemsRepositoryImpl: ItemsRepository {
    func fetch(page: Int?, perPage: Int?, query: String?) -> Single<Items> {
        let request = GetItemsRequest(page: page, perPage: perPage, query: query)
        return Session().send(request)
    }
}
