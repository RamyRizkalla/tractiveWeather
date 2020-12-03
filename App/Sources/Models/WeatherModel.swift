//Copyright © 2020 Tractive. All rights reserved.

import Foundation

struct WeatherModel {
    var isDay: Bool {
        guard let currentDate = currentDate, let sunriseTime = sunriseTime, let sunsetTime = sunsetTime else { return false }
        return currentDate > sunriseTime && currentDate < sunsetTime
    }

    var city: String?
    var status: String?
    var temperature: Int?
    var icon: Data?
    var minTemperature: Int?
    var maxTemperature: Int?
    var pressure: Int?
    var humidity: Int?
    var windSpeed: Int?
    var sunriseTime: Date?
    var sunsetTime: Date?
    var currentDate: Date?
}
