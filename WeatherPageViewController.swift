
import UIKit
import CoreLocation

class WeatherPageViewController: UIPageViewController {
    
    enum Appearance: Int {
        case daily
        case weekly
    }
    
    // MARK: - UI Elements
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    lazy var dailyViewController: DailyViewController = {
        return storyboard!.instantiateViewController(identifier: "DailyViewController")
    }()
    
    lazy var weeklyViewController: WeeklyViewController = {
        return storyboard!.instantiateViewController(identifier: "WeeklyViewController")
    }()
    
    var managedControllers: [UIViewController] {
        return [dailyViewController, weeklyViewController]
    }
    
    // MARK: - Properties
    let locationManager = CLLocationManager()
    var currentAppearance: Appearance = .daily
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.requestLocation()
        
        updateCurrentController(animated: false)
    }
    
    // MARK: - Functions
    func updateCurrentController(animated: Bool) {
        switch currentAppearance {
        case .daily:
            setViewControllers([dailyViewController], direction: .reverse, animated: animated, completion: nil)
        case .weekly:
            setViewControllers([weeklyViewController], direction: .forward, animated: animated, completion: nil)
        }
    }
    
    // MARK: Actions
    @IBAction func segmentedControlValueChanged(_ segmentedControl: UISegmentedControl) {
        if let newAppearance = Appearance(rawValue: segmentedControl.selectedSegmentIndex) {
            currentAppearance = newAppearance
            updateCurrentController(animated: true)
        }
    }
}

extension WeatherPageViewController: CLLocationManagerDelegate {
    
    // MARK: - Functions
    private func locationManager(manager: CLLocationManager!, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        switch status {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            print("The app is not authorized to use location services.")
        case .denied:
            print("The user has denied the use of location services for the app or has been globally disabled in Settings.")
        case .authorizedAlways:
            print("The user allowed the application to start the location service at any time.")
        case .authorizedWhenInUse:
            print("User allowed to start location services while in app.")
        @unknown default:
            fatalError()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let myCoordinate = locations.first?.coordinate {
            let weatherProvider = WeatherProvider()
            
            weatherProvider.getWeather(for: myCoordinate) { (weather) in
                guard let weather = weather else { return }
                
                self.dailyViewController.updateUI(with: weather)
                self.weeklyViewController.weather = weather
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
}
