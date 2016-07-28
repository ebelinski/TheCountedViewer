import Foundation
import SwiftyJSON

struct Incident {
  let name: String?

  init(json: JSON) {
    name = json["name"].string
  }
}