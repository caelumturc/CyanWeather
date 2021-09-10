

import UIKit
import MapKit

class WeeklyViewController: UITableViewController {
    
    // MARK: - Properties
    var weather: Weather?
    let cellIdentifier = "DayWeatherCell"
    let maxDayCount = 10
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.tableFooterView = UIView()
    }
    
    // MARK: - Functions
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return maxDayCount
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as? DayWeatherTableViewCell {
            if let weatherData = weather?.data[indexPath.row] {
                cell.update(with: weatherData)
            }
            
            return cell
        }
        
        return UITableViewCell()
    }
}
