//Copyright © 2020 Tractive. All rights reserved.

import Foundation

enum L10n {
    enum Global {
        enum Labels {
            static let error = "global.labels.error".localized
        }
    }

    enum Weather {
        enum Errors {
            static let unknownLocation = "weather.errors.unknown_location".localized
            static let permissionDenied = "weather.errors.permission_denied".localized
            static let unexpectedLocation = "weather.errors.unexpected_location".localized
        }
    }
}

extension String {
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
}
