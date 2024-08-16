//
//  Created by João Pedro Fabiano Franco
//

import Foundation

public enum ImageType: Hashable {
	case local(String)
  case remote(URL)
}
