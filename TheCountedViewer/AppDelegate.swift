import UIKit
import Siesta
import SwiftyJSON

let API = Service(baseURL: "https://thecountedapi.com/api")

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?

  func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
    API.configure {
      $0.config.responseTransformers.add(ResponseContentTransformer(skipWhenEntityMatchesOutputType: false) { JSON($0.content as AnyObject) }, contentTypes: ["*/json"])
    }

    API.configureTransformer("/counted") {
      ($0.content as JSON).arrayValue.map(Incident.init)
    }

    return true
  }
}