//
//  MeasureType.swift
//  JCanyon
//
//  Created by Joao Pedro Franco on 20/08/24.
//

import Foundation

public protocol MeasureProtocol {
	var text: String { get }
	var conversion: Double { get }
	static var allCases: [MeasureProtocol] { get }
	init?(rawValue: Int)
}

public extension MeasureProtocol {
	func base(for value: Double) -> Double {
		value * conversion
	}
	
	func convert(_ base: Double) -> Double {
		base / conversion
	}
}
