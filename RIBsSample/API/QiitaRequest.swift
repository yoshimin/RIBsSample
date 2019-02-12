//
//  QiitaRequest.swift
//  RIBsSample
//
//  Created by SHINGAI YOSHIMI on 2019/01/30.
//  Copyright © 2019 SHINGAI YOSHIMI. All rights reserved.
//

import Foundation

protocol QiitaRequest: Request {}

extension QiitaRequest {
    var baseURL: URL {
        return URL(string: "https://qiita.com/api/v2")!
    }
}
