//Copyright © 2020 Tractive. All rights reserved.

import Foundation

struct WeatherApiResponseModel: Decodable {
    var name: String
    var dt: Int
    var weather: [Weather]
    var main: Main
    var wind: Wind
    var sys: System
}

struct Coordinates: Decodable {
    var lon: Double
    var lat: Double
}

struct Weather: Decodable {
    var id: Int
    var main: String
    var description: String
    var icon: String
}

struct Main: Decodable {
    var temp: Double
    var humidity: Int
    var tempMin: Double
    var tempMax: Double
    var feelsLike: Double
    var pressure: Int
}

struct Wind: Decodable {
    var speed: Double
    var deg: Double
}

struct System: Decodable {
    var sunrise: Int
    var sunset: Int
}
