//Copyright © 2020 Tractive. All rights reserved.

import Foundation

extension Date {
    var shortTimeString: String {
        DateFormatter.shortTimeFormatter.string(from: self)
    }
}
