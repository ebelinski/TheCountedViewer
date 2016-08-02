import Foundation
import SwiftyJSON

struct Incident {
  let name: String?
  let age: Int?

  init(json: JSON) {
    name = json["name"].string
    if let ageString = json["age"].string {
      age = Int(ageString)
    } else {
      age = nil
    }
  }
}