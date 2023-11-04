//
//  LocationManager.swift
//  iCinema
//
//  Created by Ahmed Yamany on 24/04/2023.
//

import UIKit
import CoreLocation
import Combine

/**
 A utility class for managing location services, providing access to device location, heading, and geocoded placemark information.

 - Note: This class requires iOS 14.0 or later.

 - Author: Your Name
 */
@available(iOS 14.0, *)
open class LocationProxy: NSObject, CLLocationManagerDelegate {
    // MARK: - Properties
    /// The shared instance of the LocationProxy for managing location services.
    public static let shared = LocationProxy()
    ///
    /// The core `CLLocationManager` responsible for handling location updates and services.
    public var manager: CLLocationManager
    ///
    /// A publisher for receiving updates on the device's heading information.
    public let heading: PassthroughSubject<CLHeading, Error>
    /// A publisher for receiving updates on the device's location information.
    public let locations: PassthroughSubject<[CLLocation], Error>
    /// A publisher for receiving updates on geocoded placemarks associated with the device's location.
    public let placemarks: PassthroughSubject<[CLPlacemark], Error>
    // MARK: - Initialization
    /**
     Initializes the LocationProxy and sets up the `CLLocationManager` instance.
     
     - Important: This initializer should be called only once to create a shared instance.
     
     - Author: Your Name
     */
    public override init() {
        manager = CLLocationManager()
        heading = PassthroughSubject<CLHeading, Error>()
        locations = PassthroughSubject<[CLLocation], Error>()
        placemarks = PassthroughSubject<[CLPlacemark], Error>()
        super.init()
        manager.delegate = self
        manager.requestWhenInUseAuthorization()
    }
    // MARK: - Public Methods
    /**
     Enables location services.
     
     Call this method to start receiving location updates.
     */
    public func enable() {
        manager.startUpdatingHeading()
        manager.startUpdatingLocation()
    }
    /**
     Disables location services.
     
     Call this method to stop receiving location updates.
     */
    public func disable() {
        manager.stopUpdatingLocation()
        manager.stopUpdatingHeading()
    }
    // MARK: - CLLocationManagerDelegate Methods
    /// Delegate method called when a new heading is available.
    public func locationManager(_ manager: CLLocationManager, didUpdateHeading newHeading: CLHeading) {
        heading.send(newHeading)
    }
    /// Delegate method called when an error occurs during location updates.
    public func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        heading.send(completion: .failure(error))
        locations.send(completion: .failure(error))
    }
    /// Delegate method called when new location updates are available.
    public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        self.locations.send(locations)
        if let location = locations.last {
            reverseGeocode(location: location)
        }
    }
    /// Delegate method called when the authorization status for location services changes.
    public func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        if manager.authorizationStatus == .denied {
            showLocationDisabledPopUp()
        }
    }
    // MARK: - Private Methods
    /**
     Displays a popup to the user when location access is denied.
     
     This method shows a user-friendly alert to inform the user about denied location access
     and provides an option to open the device settings for adjusting permissions.
     
     - Author: Your Name
     */
    private func showLocationDisabledPopUp() {
        let title = NSLocalizedString("title", bundle: .module, comment: "")
        let message = NSLocalizedString("message", bundle: .module, comment: "")
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        //
        let cancelTitle = NSLocalizedString("cancel", bundle: .module, comment: "")
        let cancelAction = UIAlertAction(title: cancelTitle, style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        ///
        let openTitle = NSLocalizedString("open", bundle: .module, comment: "")
        let openAction = UIAlertAction(title: openTitle, style: .default) { [unowned self] _ in
            openDeviceSettings()
        }
        alertController.addAction(openAction)
        ///
        if let topViewController = UIApplication.shared.topMostViewController() {
            topViewController.present(alertController, animated: true, completion: nil)
        } else {
            debugPrint("failed to get top most viewcontroller to show location alert")
        }
    }
    /**
     Reverse geocodes the provided location and sends the placemark information.
     
     - Parameter location: The location to be reverse geocoded.
     
     - Author: Your Name
     */
    private func reverseGeocode(location: CLLocation) {
        CLGeocoder().reverseGeocodeLocation(location) { placemarks, error in
            if let error = error {
                self.placemarks.send(completion: .failure(error))
            }
            self.placemarks.send(placemarks ?? [])
        }
    }
    // MARK: - Helper Methods
    /**
     Opens the device settings for the current application.
     
     - Author: Your Name
     */
    private func openDeviceSettings() {
        if let url = URL(string: UIApplication.openSettingsURLString) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
}
