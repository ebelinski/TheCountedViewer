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

  func coordinateForAddress(address: String, completion: ((coordinate: CLLocationCoordinate2D) -> Void)) {
    if let coordinate = coordinateCache.objectForKey(address) as? CLLocationCoordinate2D {
      print("Found in cache")
      completion(coordinate: coordinate)
    }

    generateCoordinateOperationQueue.addOperation(NSBlockOperation() {
      CLGeocoder().geocodeAddressString(address) {
        placemarks, error in

        if let error = error {
          print(error)
          return
        }

        guard let coordinate = placemarks?.last?.location?.coordinate else { return }
        completion(coordinate: coordinate)
      }
    })
  }

}