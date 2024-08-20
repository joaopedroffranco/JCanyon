//
//  File.swift
//  
//
//  Created by Joao Pedro Franco on 20/08/24.
//

import Foundation
import Combine

open class MeasureViewModel<Measure: MeasureProtocol>: ObservableObject {
	@Published public var inputText: String = ""
	@Published public var inputType: Int = .zero
	@Published public var outputType: Int = .zero
	@Published public var outputText: String = ""
	
	private var cancellables: [Cancellable] = []
	
	public var allCases: [Measure] { Measure.allCases as! [Measure] }
	
	public init() {}
	
	public func setup() {
		Publishers
			.CombineLatest3($inputText, $inputType, $outputType)
			.map { (text, input, output) in
				guard
					let double = Double(text),
					let inputMeasure = Measure(rawValue: input),
					let outputMeasure = Measure(rawValue: output)
				else { return "Invalid input" }
				return self.convert(double, from: inputMeasure, to: outputMeasure).description
			}
			.assign(to: &$outputText)
	}
	
	private func convert(_ value: Double, from: Measure, to: Measure) -> Double {
		to.convert(from.base(for: value))
	}
}
