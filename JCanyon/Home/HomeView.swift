//
//  ContentView.swift
//  JCanyon
//
//  Created by Joao Pedro Franco on 16/08/24.
//

import SwiftUI
import JUI
import MapKit

struct HomeView: View {
	@ObservedObject private var viewModel: HomeViewModel
	
	init(viewModel: HomeViewModel) {
		self.viewModel = viewModel
	}
	
	var body: some View {
		MapView(viewModel: viewModel.mapViewModel)
			.task { viewModel.onAppear() }
			.navigationTitle("My Bikes")
			.navigationBarTitleDisplayMode(.inline)
			.toolbar {
				Button {
					viewModel.addBike()
				} label: {
					Image(systemName: "plus")
				}
			}
	}
}

struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		HomeView(viewModel: HomeViewModel(mapViewModel: MapViewModel(current: nil)))
	}
}
