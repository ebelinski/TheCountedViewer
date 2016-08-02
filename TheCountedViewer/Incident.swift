import Foundation
import SwiftyJSON

struct Incident {
  let name: String?
  let age: Int?
  let ethnicity: Ethnicity

  init(json: JSON) {
    name = json["name"].string

    age = Int(json["age"].string ?? "")

    if let raceString = json["race"].string {
      switch raceString {
      case "White": ethnicity = .White
      case "Black": ethnicity = .Black
      case "Hispanic/Latino": ethnicity = .HispanicOrLatino
      case "Asian/Pacific Islander": ethnicity = .AsianOrPacificIslander
      case "Native American": ethnicity = .NativeAmerican
      case "Other": ethnicity = .Other
      default: ethnicity = .Unknown
      }
    } else {
      ethnicity = .Unknown
    }
  }
}