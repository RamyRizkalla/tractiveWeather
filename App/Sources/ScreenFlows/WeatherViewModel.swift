//Copyright © 2020 Tractive. All rights reserved.

import Foundation

class WeatherViewModel {
    enum Constants {
        static let emptyDataPlaceHolder: String = "--"
    }
    var weatherData: WeatherData

    init() {
        weatherData = WeatherData()
    }

    func fetchWeatherData(for coordinates: Coordinates, completionHandler: @escaping () -> Void) {
        ApiManager.shared.fetchWeatherForecast(coordinates: coordinates) { [weak self] weatherData in
            self?.copyWeatherDataFromResponse(weatherData)
            if let iconName = weatherData.weather.first?.icon {
                self?.fetchIcon(iconName)
            }
            completionHandler()
        }
    }
    
    private func copyWeatherDataFromResponse(_ response: WeatherApiResponseModel) {
        weatherData.city = response.name
        weatherData.status = response.weather.first?.main
        weatherData.temperature = Int(response.main.temp)
        weatherData.minTeperature = Int(response.main.tempMin)
        weatherData.maxTemerature = Int(response.main.tempMax)
        weatherData.pressure = response.main.pressure
        weatherData.currentDate = response.dt.date
        weatherData.humidity = response.main.humidity
        weatherData.windSpeed = Int(response.wind.speed)
        weatherData.sunriseTime = response.sys.sunrise.date
        weatherData.sunsetTime = response.sys.sunset.date
    }
    
    private func fetchIcon(_ iconName: String) {
        weatherData.icon = ApiManager.shared.fetchIcon(name: iconName)
    }
    
    func cellData(weatherDataType: Rows) -> ViewData {
        switch weatherDataType {
        case .overview:
            return WeatherCellData(
                location: weatherData.city ?? Constants.emptyDataPlaceHolder,
                description: weatherData.status ?? Constants.emptyDataPlaceHolder,
                temperature: weatherData.temperature?.toString.appending("°") ?? Constants.emptyDataPlaceHolder,
                icon: weatherData.icon
            )
        case .sunrise:
            return WeatherDetailsCellData(
                leftHeader: "Sunrise",
                leftInfo: weatherData.sunriseTime?.shortTimeString ?? Constants.emptyDataPlaceHolder,
                rightHeader: "Sunset",
                rightInfo: weatherData.sunsetTime?.shortTimeString ?? Constants.emptyDataPlaceHolder
            )
        case .humidityAndWind:
            return WeatherDetailsCellData(
                leftHeader: "Wind",
                leftInfo: weatherData.windSpeed?.toString ?? Constants.emptyDataPlaceHolder,
                rightHeader: "Humidity",
                rightInfo: weatherData.humidity?.toString.appending("%") ?? Constants.emptyDataPlaceHolder
            )
        }
    }
}

protocol ViewData { }
