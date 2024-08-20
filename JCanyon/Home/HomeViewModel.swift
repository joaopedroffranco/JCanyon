//
//  HomeViewModel.swift
//  JCanyon
//
//  Created by Joao Pedro Franco on 19/08/24.
//

import Foundation
import CoreLocation
import Combine
import JFoundation
import JUI

class HomeViewModel: ObservableObject {
	var mapViewModel: MapViewModel
	
	private var locationManager: LocationManagerProtocol
	private var cancellables: [AnyCancellable] = []
	
	init(mapViewModel: MapViewModel, locationManager: LocationManagerProtocol = LocationManager()) {
		self.mapViewModel = mapViewModel
		self.locationManager = locationManager
	}
	
	func onAppear() {
		setupPublishers()
		locationManager.requestAuthorizationIfNeeded()
	}
	
	func addBike() {
		let currentLoc = locationManager.currentLocation.value
		let currentLat = currentLoc?.coordinate.latitude ?? .zero
		let currentLong = currentLoc?.coordinate.longitude ?? .zero
		let margin = 0.1
		let randomLat = Double.random(in: currentLat-margin...currentLat+margin)
		let randomLong = Double.random(in: currentLong-margin...currentLong+margin)
		mapViewModel.add(Pin(CLLocationCoordinate2D(latitude: randomLat, longitude: randomLong)))
	}
	
	private func setupPublishers() {
		mapViewModel.setupObservers()
		
		locationManager.currentLocation
			.compactMap {
				guard let current = $0 else { return nil }
				return Pin(current.coordinate, type: .main)
			}
			.assign(to: &mapViewModel.$current)
		
		locationManager.currentStatus
			.sink { status in
				if case .authorized = status {
					self.locationManager.startTracking(within: 100, backgroundUpdates: false)
				}
			}
			.store(in: &cancellables)
	}
}
