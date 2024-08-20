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
	@StateObject private var viewModel = HomeViewModel(mapViewModel: MapViewModel())
	
	var body: some View {
		MapView(viewModel: viewModel.mapViewModel)
			.task { viewModel.onAppear() }
			.navigationTitle("My Bikes")
			.navigationBarTitleDisplayMode(.inline)
			.toolbar {
				ToolbarItem(placement: .navigationBarTrailing) {
					Button {
						viewModel.addBike()
					} label: {
						Image(systemName: "plus")
					}
				}
				
				ToolbarItem(placement: .navigationBarLeading) {
					NavigationLink {
						LenghtView()
					} label: {
						Text("Length")
					}
				}
			}
	}
}

struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		HomeView()
	}
}
