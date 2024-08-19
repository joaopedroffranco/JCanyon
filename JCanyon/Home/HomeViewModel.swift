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
