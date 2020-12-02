//Copyright © 2020 Tractive. All rights reserved.

import UIKit

struct WeatherCellData: ViewData {
    var location: String
    var description: String
    var temperature: String
    var icon: Data?
}

class WeatherOverviewTableViewCell: UITableViewCell {
    @IBOutlet private var locationLabel: UILabel! {
        didSet {
            locationLabel.textColor = .white
        }
    }
    @IBOutlet private var descriptionLabel: UILabel! {
        didSet {
            descriptionLabel.textColor = .white
        }
    }
    @IBOutlet private var temperatureLabel: UILabel! {
        didSet {
            temperatureLabel.textColor = .white
        }
    }
    @IBOutlet private var weatherImageView: UIImageView!

    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    func setData(_ data: WeatherCellData) {
        locationLabel.text = data.location
        descriptionLabel.text = data.description
        temperatureLabel.text = data.temperature
        if let iconData = data.icon {
            weatherImageView.image = UIImage(data: iconData)
        }
    }
}


