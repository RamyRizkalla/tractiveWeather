//Copyright © 2020 Tractive. All rights reserved.

import Foundation

class ApiManager {
    static var shared = ApiManager()

    func fetchWeatherForecast(coordinates: Coordinates, completion: @escaping (Result) -> Void) {
        let queryParameters: [String: String] = [
            "lat": "\(coordinates.lat)",
            "lon": "\(coordinates.lon)",
            "units": "metric",
            "appid": Environment.apiKey
        ]

        let url = URL.UrlWithQueryParameters(Environment.baseUrl, queryParameters: queryParameters)!
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            if let error = error {
                completion(.failure(error))
            } else {
                self?.decodeWeatherResponse(data!, completion: completion)
            }
        }
        task.resume()
    }
    
    private func decodeWeatherResponse(_ data: Data, completion: @escaping (Result) -> Void) {
        do {
            let jsonDecoder = JSONDecoder()
            jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
            let weatherResponse = try jsonDecoder.decode(WeatherApiResponseModel.self, from: data)
            completion(.success(weatherResponse))
        } catch {
            print("Error during JSON serialization: \(error.localizedDescription)")
        }
    }
    
    func fetchIcon(name: String) -> Data? {
        let imageUrlPath = "https://openweathermap.org/img/wn/\(name)@2x.png"
        let imageUrl = URL(string: imageUrlPath)!
        return try? Data(contentsOf: imageUrl)
    }
}
