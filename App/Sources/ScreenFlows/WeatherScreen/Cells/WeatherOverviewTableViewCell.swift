//Copyright © 2020 Tractive. All rights reserved.

import UIKit

struct WeatherOverviewCellData: ViewData {
    var location: String
    var description: String
    var temperature: String
    var maxTemperature: String
    var minTemperature: String
    var icon: Data?
}

class WeatherOverviewTableViewCell: UITableViewCell {
    @IBOutlet private var alllabels: [UILabel]! {
        didSet {
            self.alllabels.forEach { $0.textColor = .white }
        }
    }
    @IBOutlet private var locationLabel: UILabel!
    @IBOutlet private var descriptionLabel: UILabel!
    @IBOutlet private var temperatureLabel: UILabel!
    @IBOutlet private var maxTemperatureLabel: UILabel!
    @IBOutlet private var minTemperatureLabel: UILabel!
    @IBOutlet private var weatherImageView: UIImageView! {
        didSet {
            weatherImageView.isHidden = true
        }
    }

    func setData(_ data: WeatherOverviewCellData) {
        locationLabel.text = data.location
        descriptionLabel.text = data.description
        temperatureLabel.text = data.temperature
        maxTemperatureLabel.text = data.maxTemperature
        minTemperatureLabel.text = data.minTemperature
        setIcon(data.icon)
    }
    
    private func setIcon(_ iconData: Data?) {
        guard let iconData = iconData else { return }
        weatherImageView.isHidden = false
        weatherImageView.image = UIImage(data: iconData)
    }
}


