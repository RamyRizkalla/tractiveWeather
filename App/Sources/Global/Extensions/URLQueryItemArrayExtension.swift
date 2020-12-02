//Copyright © 2020 Tractive. All rights reserved.

import Foundation

extension Array where Element == URLQueryItem {
    init(queryParameters: [String: String]) {
        self.init()
        queryParameters.forEach { key, value in
            append(URLQueryItem(name: key, value: value))
        }
    }
}
