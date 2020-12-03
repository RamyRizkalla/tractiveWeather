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
        
        enum Details {
            enum Headers {
                static let sunrise = "weather.details.headers.sunrise".localized
                static let sunset = "weather.details.headers.sunset".localized
                static let wind = "weather.details.headers.wind".localized
                static let humidity = "weather.details.headers.humidity".localized
            }
        }
    }
}

extension String {
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
}
