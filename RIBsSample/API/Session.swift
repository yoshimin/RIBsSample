//
//  Session.swift
//  RIBsSample
//
//  Created by SHINGAI YOSHIMI on 2019/01/30.
//  Copyright © 2019 SHINGAI YOSHIMI. All rights reserved.
//

import Foundation
import RxSwift

public enum SessionError: Error {
    case invalidURL(URL)
    case failed(Error)
    case invalidResponse
    case invalidStatusCode(Int)
}

class Session {
    func send<T: Request>(_ request: T) -> Single<T.Response> {
        return Single<T.Response>.create(subscribe: { (observer) -> Disposable in
            let url = request.baseURL.appendingPathComponent(request.path)
            var urlRequest = URLRequest(url: url)

            guard var componets = URLComponents(url: url, resolvingAgainstBaseURL: true) else {
                observer(.error(SessionError.invalidURL(url)))
                return Disposables.create()
            }
            componets.queryItems = request.queryParameters?.compactMap(URLQueryItem.init)

            urlRequest.url = componets.url
            urlRequest.httpMethod = request.method.rawValue
            urlRequest.allHTTPHeaderFields = request.headerFields

            let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
                if let error = error {
                    observer(.error(SessionError.failed(error)))
                    return
                }

                guard let response = response as? HTTPURLResponse, let data = data else {
                    observer(.error(SessionError.invalidResponse))
                    return
                }

                guard  200..<300 ~= response.statusCode else {
                    observer(.error(SessionError.invalidStatusCode(response.statusCode)))
                    return
                }

                do {
                    let decoder = JSONDecoder()
                    decoder.dateDecodingStrategy = .iso8601
                    let object = try decoder.decode(T.Response.self, from: data)
                    observer(.success(object))
                } catch {
                    observer(.error(SessionError.invalidResponse))
                }
            }

            task.resume()
            return Disposables.create()
        })
    }
}
