import UIKit
import MapKit
import Siesta

class MapViewController: UIViewController, ResourceObserver {

  @IBOutlet weak var mapView: MKMapView!

  let resource = API.resource("/counted")
  var incidents: [Incident] = []

  override func viewDidLoad() {
    super.viewDidLoad()

    resource.addObserver(self)
  }

  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)

    resource.loadIfNeeded()
  }

  func resourceChanged(resource: Resource, event: ResourceEvent) {
    if let content: [Incident] = resource.typedContent() {
      print("content exists")
      incidents = content
    }

    print(incidents.count)
  }

}

