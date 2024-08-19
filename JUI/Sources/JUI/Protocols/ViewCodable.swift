//
//  Created by Joao Pedro Franco on 15/07/24.
//

public protocol ViewCodable {
	func buildViewHierarchy()
	func setupConstraints()
	func configureViews()
	func setupView()
}

public extension ViewCodable {
	func setupView() {
		buildViewHierarchy()
		setupConstraints()
		configureViews()
	}
}
