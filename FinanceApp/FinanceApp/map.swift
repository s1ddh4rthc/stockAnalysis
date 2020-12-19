//
//  map.swift
//  FinanceApp
//
//  Created by Arth Bohra on 12/18/20.
//

import UIKit
import MapKit
import CoreLocation
import Firebase
import FirebaseAuth
import FirebaseFirestore

class MapViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate, UISearchBarDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    
    var red: Bool = false
    var yellow: Bool = false
    var green: Bool = false
    var purple: Bool = false
    var locationManager = CLLocationManager()
    var circlesDisplay: [MKCircle] = []
        
    override func viewDidLoad() {
        
        super.viewDidLoad()
        var circlesDisplay: [MKCircle] = []
        
        self.mapView.delegate = self
        
        let locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        mapView.showsTraffic = true
        mapView.showsCompass = false
        mapView.showsUserLocation = true
        if (CLLocationManager.locationServicesEnabled()) {
            locationManager.requestAlwaysAuthorization()
            locationManager.requestWhenInUseAuthorization()
        }
        
        if let userLocation = locationManager.location?.coordinate {
            let span = MKCoordinateSpan.init(latitudeDelta: 0.005, longitudeDelta: 0.005)
            let coordinate = CLLocationCoordinate2D.init(latitude: userLocation.latitude, longitude: userLocation.longitude)
            let region = MKCoordinateRegion.init(center: coordinate, span: span)
            mapView.setRegion(region, animated: true)
        }
        
        self.locationManager = locationManager
        
        DispatchQueue.main.async {
            self.locationManager.startUpdatingLocation()
        }
        
        let db = Firestore.firestore()
        db.collection("hospitals")
            .getDocuments() {
                (QuerySnapshot, Error) in
                
                if let err = Error {
                    print("Didn't work")
                    return
                }
                
                else {
                    for document in QuerySnapshot!.documents {
                        //green hospital
                        if let status = document.get("status") as? String {
                            if status == "secure" {
                                self.green = true
                                if let geo = document.get("geolocation") as? [Double] {
                                    let greenHosp = MKPointAnnotation()
                                    greenHosp.title =  document.get("name") as? String
                                    greenHosp.subtitle = "Vaccine has been delivered."
                                    greenHosp.coordinate = CLLocationCoordinate2D(latitude: geo[0], longitude: geo[1])
                                    self.mapView.addAnnotation(greenHosp)
                                    let grnCir: MKCircle = MKCircle(center: greenHosp.coordinate, radius: 100)
                                    circlesDisplay.append(grnCir)
                                    self.mapView.addOverlay(grnCir)
                                }
                            }
                            
                            //yellow hospital
                            if status == "transit" {
                                self.yellow = true
                                if let geo = document.get("geolocation") as? [Double] {
                                    let yellowHosp = MKPointAnnotation()
                                    yellowHosp.title =  document.get("name") as? String
                                    yellowHosp.subtitle = "Vaccine is in transit."
                                    yellowHosp.coordinate = CLLocationCoordinate2D(latitude: geo[0], longitude: geo[1])
                                    self.mapView.addAnnotation(yellowHosp)
                                    let ylwCir: MKCircle = MKCircle(center: yellowHosp.coordinate, radius: 100)
                                    circlesDisplay.append(ylwCir)
                                    self.mapView.addOverlay(ylwCir)
                                }
                            }
                            
                            if status == "offer" {
                                self.red = true
                                if let geo = document.get("geolocation") as? [Double] {
                                    let redHosp = MKPointAnnotation()
                                    redHosp.title =  document.get("name") as? String
                                    redHosp.subtitle = "Vaccine needed."
                                    redHosp.coordinate = CLLocationCoordinate2D(latitude: geo[0], longitude: geo[1])
                                    self.mapView.addAnnotation(redHosp)
                                    let redCir: MKCircle = MKCircle(center: redHosp.coordinate, radius: 100)
                                    self.mapView.addOverlay(redCir)
                                    circlesDisplay.append(redCir)
                                    
                                }
                            }
                        }
                    }
                }
                
            }
        
        db.collection("distribution-centers")
            .getDocuments() {
                (QuerySnapshot, Error) in
                
                if let err = Error {
                    print("Didn't work")
                    return
                } else {
                    
                for document in QuerySnapshot!.documents {
                if let status = document.get("status") as? String {
                        print(status)
                        // green points
                        if status == "delivered" {
                            print("im delivered")
                            self.green = true
                            if let geo = document.get("geolocation") as? [Double] {
                                let greenAnnot = MKPointAnnotation()
                                greenAnnot.title = document.get("name") as? String
                                greenAnnot.subtitle = "Vaccine has been delivered."
                                greenAnnot.coordinate = CLLocationCoordinate2D(latitude: geo[0], longitude: geo[1])
                                self.mapView.addAnnotation(greenAnnot)
                                let grnCir = MKCircle(center: greenAnnot.coordinate, radius: 100)
                                self.mapView.addOverlay(grnCir)
                                circlesDisplay.append(grnCir)
                            }
                        }

                        //yellow points
                        if status == "transit" {
                            print("im in transit")
                            self.yellow = true
                            if let geo = document.get("geolocation") as? [Double] {
                                let yellowAnnot = MKPointAnnotation()
                                yellowAnnot.title = document.get("name") as? String
                                yellowAnnot.subtitle = "Vaccine is in transit."
                                yellowAnnot.coordinate = CLLocationCoordinate2D(latitude: geo[0], longitude: geo[1])
                                self.mapView.addAnnotation(yellowAnnot)
                                let ylwCir: MKCircle = MKCircle(center: yellowAnnot.coordinate, radius: 100)
                                self.mapView.addOverlay(ylwCir)
                                circlesDisplay.append(ylwCir)
                            }
                        }

                        //red points
                        if status == "requested" {
                            self.red = true
                            if let geo = document.get("geolocation") as? [Double] {
                                let redAnnot = MKPointAnnotation()
                                redAnnot.title = document.get("name") as? String
                                redAnnot.subtitle = "Vaccine is being packaged."
                                redAnnot.coordinate = CLLocationCoordinate2D(latitude: geo[0], longitude: geo[1])
                                self.mapView.addAnnotation(redAnnot)
                                let redCir: MKCircle = MKCircle(center: redAnnot.coordinate, radius: 100)
                                self.mapView.addOverlay(redCir)
                                circlesDisplay.append(redCir)

                            }
                        }
                    }
                }
                }

                if (circlesDisplay.count > 0) {
                    self.mapView.region = MKCoordinateRegion(center: circlesDisplay[0].coordinate, latitudinalMeters: 1000, longitudinalMeters: 1000)

                }
            }
    }
    
    
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        
        let circles = MKCircleRenderer(overlay: overlay)
        circles.strokeColor = UIColor.black
        circles.lineWidth = 1.0
        circles.alpha = 0.25
        
        return circles
        
    }
    
    
}


extension MapViewController {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let location = locations.last!
        let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005))
        // mapView.setRegion(region, animated: true)
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
    }
}
