//Copyright © 2020 Tractive. All rights reserved.

import Foundation

extension URL {
    static func UrlWithQueryParameters(_ baseUrlString: String, queryParameters: [String: String]) -> URL? {
        guard
            let baseUrl = URL(string: baseUrlString),
            var urlComponents = URLComponents(url: baseUrl, resolvingAgainstBaseURL: false)
        else {
            return nil
        }
        urlComponents.queryItems = Array(queryParameters: queryParameters)
        return urlComponents.url
    }
}
