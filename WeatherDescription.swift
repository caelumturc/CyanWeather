

import UIKit

struct WeatherDescription: Codable {
    
    // MARK: - Properties
    var iconName: String
    var description: String
    
    var icon: UIImage? {
        return UIImage(named: iconName)
    }
    
    enum CodingKeys: String, CodingKey {
        case iconName = "icon"
        case description = "description"
    }
}
