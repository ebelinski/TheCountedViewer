import Foundation
import MapKit

struct CoordinateManager {

  static var sharedInstance = CoordinateManager()

  // Stores coordinate objects for addresses for the duration of the app session
  var coordinateCache = [String: CLLocationCoordinate2D]()

  var badAddresses = [String]()

  let generateCoordinateOperationQueue: NSOperationQueue = {
    let queue = NSOperationQueue()
    queue.maxConcurrentOperationCount = 1
    return queue
  }()

  mutating func coordinateForAddress(address: String, completion: ((coordinate: CLLocationCoordinate2D) -> Void)) {
    if let coordinate = coordinateCache[address] {
      print("Found in cache")
      completion(coordinate: coordinate)
    }

    if badAddresses.contains(address) {
      print("Bad address")
      return
    }

    generateCoordinateOperationQueue.addOperation(NSBlockOperation() {
      CLGeocoder().geocodeAddressString(address) {
        placemarks, error in

        if let error = error {
          self.badAddresses.append(address)
          print(error)
          return
        }

        guard let coordinate = placemarks?.last?.location?.coordinate else { return }
        self.coordinateCache[address] = coordinate
        completion(coordinate: coordinate)
      }
    })
  }

}