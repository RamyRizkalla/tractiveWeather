//Copyright © 2020 Tractive. All rights reserved.

import Foundation

enum TimesOfDay {
    case day
    case night
}

struct WeatherData {
    var city: String?
    var status: String?
    var temperature: Int?
    var icon: Data?
    var minTeperature: Int?
    var maxTemerature: Int?
    var pressure: Int?
    var humidity: Int?
    var windSpeed: Int?
    var sunriseTime: Date?
    var sunsetTime: Date?
    var currentDate: Date?
    
    var timeOfDay: TimesOfDay {
        guard let currentDate = currentDate, let sunriseTime = sunriseTime, let sunsetTime = sunsetTime else { return .day }
        return (currentDate > sunriseTime && currentDate < sunsetTime ) ? .day : .night
    }
}
