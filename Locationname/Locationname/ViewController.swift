//
//  ViewController.swift
//  Locationname
//
//  Created by Peter Deyi on 4/21/23.
//
import CoreLocation
import MapKit
import UIKit

class ViewController: UIViewController {

    private let map: MKMapView = {
        let map = MKMapView()
        return map
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.addSubview(map)
        title = "Locations"
        LocationManager.shared.getUserLocation { [weak self] location in
            DispatchQueue.main.async {
                guard let strongSelf = self else {
                    return
                }
                strongSelf.addMapPin(with: location)
            }
        }
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        map.frame = view.bounds
    }

    func addMapPin(with location: CLLocation) {
        let pin = MKPointAnnotation()
        pin.coordinate = location.coordinate
        map.setRegion(MKCoordinateRegion(center: location.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.7, longitudeDelta: 0.7)), animated: true)
            // How much you want the map to zoom into screen
        map.addAnnotation(pin)
        
        LocationManager.shared.resolveLocationName(with: location) { [weak self] locationName in
            self?.title = locationName
        }
    }
}

