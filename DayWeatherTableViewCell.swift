

import UIKit

class DayWeatherTableViewCell: UITableViewCell {

    // MARK: - UI Elements
    @IBOutlet weak var dayNameLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var maximumTemperatureLabel: UILabel!
    @IBOutlet weak var minimumTemperatureLabel: UILabel!
    
    // MARK: - Functions
    func update(with weather: DailyWeather) {
        dayNameLabel.text = DateConfiguration.convertDateToDayName(date: weather.datetime, identifier: "EEEE")
        iconImageView.image = weather.weatherDescription.icon
        maximumTemperatureLabel.text = "\(Int(weather.maxTemperature))"
        minimumTemperatureLabel.text = "\(Int(weather.minTemperature))"
    }
}
