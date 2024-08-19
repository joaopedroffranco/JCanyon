//
//  Created by João Pedro Fabiano Franco
//

import SwiftUI

public enum DesignSystem {
  public enum Colors {
		public static let background = Color.white
		public static let primary = Color.green
		public static let secondary = Color.white
		public static let dark = Color.black
  }

  public enum Fonts {
		public static let `default` = Font.system(size: 16)
    public static let button = Font.system(size: 16)
		public static let uiButton = UIFont.systemFont(ofSize: 16)
  }

  public enum Radius {
		public static let `default`: CGFloat = 6.0
  }

  public enum Spacings {
    public static let xs = 8.0
    public static let xxs = 6.0
    public static let xxxs = 4.0
    public static let xxxxs = 2.0
  }
}
