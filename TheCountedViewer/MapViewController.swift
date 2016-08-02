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
    if let errorMessage = resource.latestError?.userMessage {
      print(errorMessage)
      return
    }

    incidents = resource.typedContent() ?? []
    refreshMap()
  }

  private func refreshMap() {
    for incident in incidents {
      let address = (incident.streetAddress ?? "") + ", "
                  + (incident.city ?? "") + ", "
                  + (incident.state ?? "")

      CoordinateManager.sharedInstance.coordinateForAddress(address) {
        coordinate in

        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        annotation.title = "\(incident.name ?? "") (\(address))"
        self.mapView.addAnnotation(annotation)
      }
    }
  }

}