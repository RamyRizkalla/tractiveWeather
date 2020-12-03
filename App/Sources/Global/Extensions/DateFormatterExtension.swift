//Copyright © 2020 Tractive. All rights reserved.

import Foundation

extension DateFormatter {
    static var shortTimeFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        return formatter
    }
}
