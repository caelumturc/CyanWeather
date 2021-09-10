

import Foundation

struct Weather: Codable {
    
    // MARK: - Properties
    var cityName: String
    var data: [DailyWeather]
    
    enum CodingKeys: String, CodingKey {
        case cityName = "city_name"
        case data = "data"
    }
}
