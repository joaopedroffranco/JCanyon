//
//  SwiftUIView.swift
//  
//
//  Created by Joao Pedro Franco on 19/08/24.
//

import SwiftUI
import MapKit

public struct MapView: View {
	@ObservedObject var viewModel: MapViewModel
	
	public init(viewModel: MapViewModel) {
		self.viewModel = viewModel
	}
	
	public var body: some View {
		Map(
			coordinateRegion: $viewModel.region,
			annotationItems: viewModel.allPins,
			annotationContent: { pin in pinView(pin) }
		)
	}

	private func pinView(_ pin: Pin) -> some MapAnnotationProtocol {
		switch pin.type {
		case .main:
			return MapAnnotation(coordinate: pin.location) {
				Image(systemName: "pin.circle.fill").foregroundColor(.blue)
				Text("Main")
					.font(.system(size: 12))
			}
		case .regular:
			return MapAnnotation(coordinate: pin.location) {
				Image(systemName: "pin.circle.fill").foregroundColor(.red)
				Text("Regular")
					.font(.system(size: 8))
			}
		}
	}
}
