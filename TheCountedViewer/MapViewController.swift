import UIKit
import MapKit
import Siesta

class MapViewController: UIViewController, ResourceObserver {

  @IBOutlet weak var mapView: MKMapView!

  var incidents: [Incident] = []

  override func viewDidLoad() {
    super.viewDidLoad()

    API.resource("/counted").addObserver(self).loadIfNeeded()
  }

  func resourceChanged(resource: Resource, event: ResourceEvent) {
    if let content: [Incident] = resource.typedContent() {
      print("content exists")
      incidents = content
    }

    print(incidents.count)
  }

}

