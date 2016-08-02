import Foundation
import MapKit

struct CoordinateManager {

  static let sharedInstance = CoordinateManager()

  // Stores coordinate objects for addresses for the duration of the app session
  let coordinateCache = NSCache()

  let generateCoordinateOperationQueue: NSOperationQueue = {
    let queue = NSOperationQueue()
    queue.maxConcurrentOperationCount = 1
    return queue
  }()

}