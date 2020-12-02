//  Copyright © 2020 Tractive. All rights reserved.

import UIKit
import CoreLocation

enum Rows: Int, CaseIterable {
    case overview
    case sunrise
    case humidityAndWind
}

class WeatherViewController: UIViewController {
    @IBOutlet private var tableView: UITableView!
    private var locationManager: CLLocationManager!
    private var weatherViewModel: WeatherViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        weatherViewModel = WeatherViewModel()
        configureTableView()
        determineCurrentLocation()
    }

    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
    }

    func determineCurrentLocation() {
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()

        if CLLocationManager.locationServicesEnabled() {
            locationManager.startUpdatingLocation()
        }
    }
}

extension WeatherViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Rows.allCases.count
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = .clear
        cell.selectionStyle = .none
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch Rows(rawValue: indexPath.row)! {
        case .overview:
            return configureWeatherOverviewCell(at: indexPath)
        case .humidityAndWind, .sunrise:
            return configureWeatherDetailsCell(at: indexPath)
        }
    }

    private func configureWeatherOverviewCell(at indexPath: IndexPath) -> WeatherOverviewTableViewCell {
        let overviewCell: WeatherOverviewTableViewCell = tableView.dequeueCell(for: indexPath)
        if let data = weatherViewModel.cellData(weatherDataType: Rows(rawValue: indexPath.row)!) as? WeatherCellData {
            overviewCell.setData(data)
        }
        return overviewCell
    }
    
    private func configureWeatherDetailsCell(at indexPath: IndexPath) -> WeatherDetailsTableViewCell {
        let detailsCell: WeatherDetailsTableViewCell = tableView.dequeueCell(for: indexPath)
        if let data = weatherViewModel.cellData(weatherDataType: Rows(rawValue: indexPath.row)!) as? WeatherDetailsCellData {
            detailsCell.setData(data)
        }
        return detailsCell
    }
}

extension WeatherViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch Rows(rawValue: indexPath.row)! {
        case .overview:
            return 250
        case .sunrise, .humidityAndWind:
            return 75
        }
    }
}

//MARK:- CLLocationManagerDelegate Methods

extension WeatherViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let userLocationCoordinates = locations.last?.coordinate else { return }
        let coordinates = Coordinates(lon: userLocationCoordinates.longitude, lat: userLocationCoordinates.latitude)
        weatherViewModel.fetchWeatherData(for: coordinates) {
            DispatchQueue.main.async { [weak self] in
                self?.configureTableViewBackground()
                self?.tableView.reloadData()
            }
        }
    }
    
    private func configureTableViewBackground() {
        let backgroundImage: UIImage = weatherViewModel.weatherData.timeOfDay == .day ? Assets.Images.dayBackground : Assets.Images.nightBackground
        tableView.backgroundView = UIImageView(image: backgroundImage)
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error - locationManager: \(error.localizedDescription)")
    }
}
