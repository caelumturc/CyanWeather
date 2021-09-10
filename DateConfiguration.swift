

import Foundation

class DateConfiguration {
    
    // MARK: - Functions
    class func convertDateToDayName(date: String, identifier: String) -> String {
        var dayName: String!
        
        let dateFormatterForMainDate = DateFormatter()
        dateFormatterForMainDate.dateFormat = "yyyy-MM-dd"
        
        let dateFormatterForDay = DateFormatter()
        dateFormatterForDay.dateFormat = identifier
        dateFormatterForDay.locale = Locale(identifier: "ger_GER")
        
        if let date = dateFormatterForMainDate.date(from: date) {
            dayName = dateFormatterForDay.string(from: date)
        } else {
            print("There was an error decoding the string")
        }
        
        return dayName
    }
}
