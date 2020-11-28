//Copyright © 2020 Tractive. All rights reserved.

import Foundation

struct WeatherApiResponseModel {
    
}

struct Coordinates: Decodable {
    var lon: Int
    var lat: Int
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
}
