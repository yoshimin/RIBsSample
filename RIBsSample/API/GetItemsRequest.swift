//
//  GetItemsRequest.swift
//  RIBsSample
//
//  Created by SHINGAI YOSHIMI on 2019/01/31.
//  Copyright © 2019 SHINGAI YOSHIMI. All rights reserved.
//

import Foundation

struct GetItemsRequest: QiitaRequest {
    typealias Response = Items

    private let page: Int?
    private let perPage: Int?
    private let query: String?

    init(page: Int?, perPage: Int?, query: String?) {
        self.page = page
        self.perPage = perPage
        self.query = query
    }

    var method = HTTPMethod.get
    var path = "items"
    var headerFields: [String:String] = [:]
    
    var queryParameters: [String:String]? {
        var params: [String:String] = [:]
        if let page = page {
            params["page"] = String(page)
        }
        if let perPage = perPage {
            params["per_page"] = String(perPage)
        }
        if let query = query {
            params["query"] = query
        }
        return params
    }
}
