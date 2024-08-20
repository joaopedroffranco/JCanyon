//
//  File.swift
//  
//
//  Created by Joao Pedro Franco on 20/08/24.
//

import Foundation

public enum LengthType: Int, MeasureProtocol {
	case m = 0
	case km
	case feet
	case yard
	case miles
	
	public var text: String {
		switch self {
		case .m: return "m"
		case .km: return "km"
		case .feet: return "feet"
		case .yard: return "yard"
		case .miles: return "miles"
		}
	}
	
	public var conversion: Double {
		switch self {
		case .m: return 1
		case .km: return 1000
		case .feet: return 0.3048
		case .yard: return 0.9144
		case .miles: return 1609.34
		}
	}
	
	public static var allCases: [MeasureProtocol] = [
		LengthType.m,
		LengthType.km,
		LengthType.feet,
		LengthType.yard,
		LengthType.miles
	]
}
