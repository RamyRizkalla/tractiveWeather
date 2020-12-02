//Copyright © 2020 Tractive. All rights reserved.

import Foundation

enum Result {
    case success(Decodable)
    case failure(Error)
}

class ApiManager {
    static var shared = ApiManager()

    func fetchWeatherForecast(coordinates: Coordinates, completion: @escaping (WeatherApiResponseModel) -> Void) {
        let baseUrl = "\(Environment.baseUrl)?lat=\(coordinates.lat)&lon=\(coordinates.lon)&units=metric&appid=85f3a9611734e604214c612f9a21db20"
        let url = URL(string: baseUrl)!
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            // Check if an error occured
            if error != nil {
                return
            }
            
            // Serialize the data into an object
            do {
                let jsonDecoder = JSONDecoder()
                jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
                let weatherResponse = try jsonDecoder.decode(WeatherApiResponseModel.self, from: data!)
                completion(weatherResponse)
            } catch {
                print("Error during JSON serialization: \(error.localizedDescription)")
            }
            
        }
        task.resume()
    }
    
    func fetchIcon(name: String) -> Data? {
        let imageUrlPath = "https://openweathermap.org/img/wn/\(name)@2x.png"
        let imageUrl = URL(string: imageUrlPath)!
        return try? Data(contentsOf: imageUrl)
    }
}
