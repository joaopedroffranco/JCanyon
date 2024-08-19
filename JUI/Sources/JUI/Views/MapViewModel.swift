//
//  SwiftUIView.swift
//  
//
//  Created by Joao Pedro Franco on 19/08/24.
//

import SwiftUI
import MapKit
import Combine

// Region
public class MapViewModel: ObservableObject {
	@Published public var current: Pin?
	@Published public var pins: [Pin]
	@Published public var region: MKCoordinateRegion

	private var cancellables: [AnyCancellable] = []
	
	public var allPins: [Pin] {
		if let current = current {
			return [current] + pins
		}
		
		return pins
	}
	
	public init(current: Pin? = nil, pins: [Pin] = []) {
		self.current = current
		self.pins = pins
		self.region = MKCoordinateRegion(
				center: .init(latitude: .zero, longitude: .zero),
			 span: .init(latitudeDelta: 10, longitudeDelta: 10)
		 )
	}
	
	public func setupObservers() {
		Publishers
			.CombineLatest($current, $pins)
			.map { _ in self.calculateRegion(from: self.allPins) }
			.assign(to: &$region)
	}
	
	public func add(_ pin: Pin) {
		pins.append(pin)
	}
	
	private func calculateRegion(from pins: [Pin]) -> MKCoordinateRegion {
		guard !pins.isEmpty else {
			return MKCoordinateRegion(
				center: .init(latitude: .zero, longitude: .zero),
				span: .init(latitudeDelta: 1000, longitudeDelta: 1000)
			)
		}
		var minLat = 90.0
		var maxLat = -90.0
		var minLong = 180.0
		var maxLong = -180.0
		
		pins.forEach {
			let loc = $0.location
			if loc.latitude < minLat { minLat = loc.latitude }
			if loc.latitude > maxLat { maxLat = loc.latitude }
			if loc.longitude < minLong { minLong = loc.longitude }
			if loc.longitude > maxLong { maxLong = loc.longitude }
		}
		
		return MKCoordinateRegion(
			center: .init(latitude: (minLat + maxLat) / 2, longitude: (minLong + maxLong) / 2),
			span: .init(latitudeDelta: maxLat - minLat, longitudeDelta: maxLong - minLong)
		)
	}
}

// Pin
public enum PinType {
	case main
	case regular
}

public struct Pin: Identifiable {
	public let id = UUID()
	let type: PinType
	let location: CLLocationCoordinate2D
	
	public init(_ location: CLLocationCoordinate2D, type: PinType = .regular) {
		self.type = type
		self.location = location
	}
}
