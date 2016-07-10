import UIKit
import Siesta
import SwiftyJSON

let API = Service(baseURL: "https://thecountedapi.com/api")

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?

  func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {

    API.configureTransformer("/counted") {
      ($0.content as JSON).arrayValue.map(Killing.init)
    }

    return true
  }
}