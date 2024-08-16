//
//  Created by João Pedro Fabiano Franco
//

import Combine
import CoreLocation

public protocol LocationManagerProtocol {
	var currentStatus: CurrentValueSubject<LocationAuthorizationStatus, Never> { get }
	var currentLocation: CurrentValueSubject<CLLocation?, Never> { get }

	func startTracking(within: Double)
	func stopTracking()
}

public class LocationManager: NSObject, LocationManagerProtocol {
  private var nativeLocationManager: CLLocationManager

  public var currentStatus: CurrentValueSubject<LocationAuthorizationStatus, Never>
	public var currentLocation: CurrentValueSubject<CLLocation?, Never>
	
  public init(nativeLocationManager: CLLocationManager = CLLocationManager()) {
    self.nativeLocationManager = nativeLocationManager
		self.currentStatus = .init(LocationAuthorizationStatus(from: self.nativeLocationManager.authorizationStatus))
		self.currentLocation = .init(nil)
    super.init()
    self.nativeLocationManager.delegate = self
    requestAuthorizationIfNeeded()
  }
	
	public func startTracking(within: Double) {
		nativeLocationManager.allowsBackgroundLocationUpdates = true
		nativeLocationManager.distanceFilter = within
		nativeLocationManager.pausesLocationUpdatesAutomatically = false
		nativeLocationManager.startUpdatingLocation()
	}
	
	public func stopTracking() {
		nativeLocationManager.stopUpdatingLocation()
	}

  private func requestAuthorizationIfNeeded() {
    nativeLocationManager.requestWhenInUseAuthorization()
  }
}

extension LocationManager: CLLocationManagerDelegate {
  public func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
    let newStatus = LocationAuthorizationStatus(from: manager.authorizationStatus)

		if newStatus != currentStatus.value {
			currentStatus.send(newStatus)
    }
  }
	
	public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
		currentLocation.send(locations.last)
	}
}
