import Foundation
import SwiftyJSON

struct Killing {
  let name: String?

  init(json: JSON) {
    name = json["name"].string
  }
}