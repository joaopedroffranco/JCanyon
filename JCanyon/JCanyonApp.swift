//
//  JCanyonApp.swift
//  JCanyon
//
//  Created by Joao Pedro Franco on 16/08/24.
//

import SwiftUI
import JFoundation
import JUI

@main
struct JCanyonApp: App {
	private var locationManager: LocationManagerProtocol = LocationManager()
	
	var body: some Scene {
		WindowGroup {
			NavigationView {
				LenghtView()
			}
		}
	}
}
