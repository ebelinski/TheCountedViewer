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
    let coder = CLGeocoder()

    for incident in incidents {
      let addressString = (incident.streetAddress ?? "") + " "
                        + (incident.city ?? "") + " "
                        + (incident.state ?? "")

      coder.geocodeAddressString(addressString) {
        placemarks, error in

        if let error = error {
          print(error)
          return
        }

        guard let location = placemarks?.last?.location else { return }
      }
    }
  }

}