//
//  LenghtView.swift
//  JCanyon
//
//  Created by Joao Pedro Franco on 20/08/24.
//

import SwiftUI
import JFoundation

struct LenghtView: View {
	@StateObject var viewModel = LenghtViewModel()
	
	var body: some View {
		VStack(alignment: .leading) {
			TextField("From", text: $viewModel.inputText)
				.frame(height: 44)
			Picker("From type", selection: $viewModel.inputType) {
				ForEach(viewModel.allCases, id: \.self) {
					Text($0.text).tag($0.rawValue)
				}
			}
			.pickerStyle(.segmented)
			
			Spacer()

			Text(viewModel.outputText)
				.font(.system(size: 32))
			
			Picker("To type", selection: $viewModel.outputType) {
				ForEach(viewModel.allCases, id: \.self) {
					Text($0.text).tag($0.rawValue)
				}
			}
			.pickerStyle(.segmented)
		}
		.frame(maxWidth: .infinity, alignment: .leading)
		.padding()
		.onAppear { viewModel.setup() }
		.navigationTitle("Length")
		.navigationBarTitleDisplayMode(.inline)
	}
}

struct LenghtView_Previews: PreviewProvider {
	static var previews: some View {
		LenghtView()
	}
}
