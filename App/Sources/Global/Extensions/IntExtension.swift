//Copyright © 2020 Tractive. All rights reserved.

import Foundation

extension Int {
    var date: Date {
        return Date(timeIntervalSince1970: TimeInterval(self))
    }

    var stringValue: String {
        return "\(self)"
    }
}
