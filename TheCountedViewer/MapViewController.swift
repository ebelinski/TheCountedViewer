import UIKit
import MapKit
import Siesta

class MapViewController: UIViewController, ResourceObserver {

  @IBOutlet weak var mapView: MKMapView!

  var killings: [Killing] = []

  override func viewDidLoad() {
    super.viewDidLoad()

    API.resource("/counted").addObserver(self)
  }

  func resourceChanged(resource: Resource, event: ResourceEvent) {
    if let content: [Killing] = resource.typedContent() {
      print("content exists")
      killings = content
    }

    print(killings.count)
  }

}

