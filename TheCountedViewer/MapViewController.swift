import UIKit
import MapKit
import Siesta

class MapViewController: UIViewController, ResourceObserver {

  @IBOutlet weak var mapView: MKMapView!

  override func viewDidLoad() {
    super.viewDidLoad()

    API.resource("/").addObserver(self)
  }

  func resourceChanged(resource: Resource, event: ResourceEvent) {
    print("resource changed")
  }

}

