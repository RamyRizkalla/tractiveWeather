//Copyright © 2020 Tractive. All rights reserved.

import Foundation

class WeatherViewModel {
    enum Constants {
        static let emptyPlaceHolder: String = "--"
    }

    var weatherData = WeatherModel()
    var failureHandler: ((String) -> Void)?

    func fetchWeatherData(for coordinates: Coordinates, completionHandler: @escaping () -> Void) {
        ApiManager.shared.fetchWeatherForecast(coordinates: coordinates) { [weak self] result in
            switch result {
            case .success(let weatherData):
                guard let weatherData = weatherData as? WeatherApiResponseModel else {
                    self?.failureHandler?(L10n.Weather.Errors.parsingError)
                    return
                }
                self?.copyWeatherDataFromResponse(weatherData)
                if let iconName = weatherData.weather.first?.icon {
                    self?.fetchIcon(iconName)
                }
                completionHandler()
            case .failure(let error):
                self?.failureHandler?("\(error.localizedDescription)")
            }
        }
    }
    
    private func copyWeatherDataFromResponse(_ response: WeatherApiResponseModel) {
        weatherData.city = response.name
        weatherData.status = response.weather.first?.main
        weatherData.temperature = Int(response.main.temp)
        weatherData.minTemperature = Int(response.main.tempMin)
        weatherData.maxTemperature = Int(response.main.tempMax)
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
    
    func cellData(weatherDataType: WeatherDetailType) -> ViewData {
        switch weatherDataType {
        case .overview:
            return WeatherOverviewCellData(
                location: weatherData.city ?? Constants.emptyPlaceHolder,
                description: weatherData.status ?? Constants.emptyPlaceHolder,
                temperature: weatherData.temperature?.stringValue.appending("°") ?? Constants.emptyPlaceHolder,
                maxTemperature: weatherData.maxTemperature?.stringValue ?? Constants.emptyPlaceHolder,
                minTemperature: weatherData.maxTemperature?.stringValue ?? Constants.emptyPlaceHolder,
                icon: weatherData.icon
            )
        case .sunrise:
            return WeatherDetailsCellData(
                leftHeader: L10n.Weather.Details.Headers.sunrise,
                leftInfo: weatherData.sunriseTime?.shortTimeString ?? Constants.emptyPlaceHolder,
                rightHeader: L10n.Weather.Details.Headers.sunset,
                rightInfo: weatherData.sunsetTime?.shortTimeString ?? Constants.emptyPlaceHolder
            )
        case .humidityAndWind:
            return WeatherDetailsCellData(
                leftHeader: L10n.Weather.Details.Headers.wind,
                leftInfo: weatherData.windSpeed?.stringValue.appending(" KM/H") ?? Constants.emptyPlaceHolder,
                rightHeader: L10n.Weather.Details.Headers.humidity,
                rightInfo: weatherData.humidity?.stringValue.appending("%") ?? Constants.emptyPlaceHolder
            )
        }
    }
}
