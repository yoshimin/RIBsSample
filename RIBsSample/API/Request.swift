//
//  Request.swift
//  RIBsSample
//
//  Created by SHINGAI YOSHIMI on 2019/01/30.
//  Copyright © 2019 SHINGAI YOSHIMI. All rights reserved.
//

import Foundation

public enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
}

public protocol Request {
    associatedtype Response: Decodable
    var baseURL: URL { get }
    var method: HTTPMethod { get }
    var path: String { get }
    var headerFields: [String: String] { get }
    var queryParameters: [String: String]? { get }
}
