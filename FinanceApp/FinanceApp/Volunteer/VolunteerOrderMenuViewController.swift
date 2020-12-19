//
//  VolunteerOrderMenuViewController.swift
//  FinanceApp
//
//  Created by Siddharth on 12/18/20.
//

import Foundation

import UIKit
import FirebaseAuth
import FirebaseDatabase
import MapKit

class VolunteerOrderMenuViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet var HospitalName: UILabel!
    @IBOutlet weak var mealProgramName: UILabel!
    
    var requestLocation = CLLocationCoordinate2D()
    var volunteerLocation = CLLocationCoordinate2D()
    var locationManager = CLLocationManager()
    
    var HospName = ""
    var distName = ""
    
    var volunteerOrder = [String:Any]()
    var uid = ""
    
    let email = Auth.auth().currentUser?.email?.replacingOccurrences(of: ".", with: "-").replacingOccurrences(of: "@", with: "-")
    
    @IBAction func HospDirections(_ sender: Any) {
        
        
    }
    
    @IBAction func mealDirections(_ sender: Any) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        HospitalName.text = HospName
        mealProgramName.text = distName
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if let coord = manager.location?.coordinate {
            volunteerLocation = coord
        }
        
    }
    
    @IBAction func acceptPressed(_ sender: Any) {
        
        Database.database().reference().child(email!).observeSingleEvent(of: .value) { [self] (snapshot) in
            
            let value = snapshot.value as? NSDictionary
            
            if let firstName = value?["firstName"] as? String {
                
                if let lastName = value?["lastName"] as? String {
                    
                    let name = ("\(firstName)" + " " + "\(lastName)")
                    
                    Database.database().reference().child("Accepted-Offers").queryOrdered(byChild: "chosenHosp").queryEqual(toValue: HospName).observe(.childAdded) { (snapshot) in
                        
                        let value = snapshot.value as? NSDictionary
                        
                        if let distName = value?["distName"] as? String {
                            
                            if let chosenHosp = value?["chosenHosp"] as? String {
                                
                                if let geolocation = value?["geolocation"] as? [Double] {
                                    
                                    self.volunteerOrder = ["chosenHosp" : chosenHosp, "distName" : distName, "distLocation" : geolocation, "volunteerLat" : volunteerLocation.latitude, "volunteerLong" : volunteerLocation.longitude, "volunteerName" : name, "status" : "transit"]
                                    
                                    Database.database().reference().child("Transit-Orders").childByAutoId().setValue(self.volunteerOrder)
                                    
                                    Database.database().reference().child("Accepted-Offers").queryOrdered(byChild: "chosenHosp").queryEqual(toValue: chosenHosp).observe(.childAdded) { (snapshot) in
                                        
                                        snapshot.ref.removeValue()
                                        Database.database().reference().child("Accepted-Offers").removeAllObservers()
                                        
                                    }
                                    
                                }
                                
                            }
                            
                        }
                        
                        
                        
                    }
                            
                    
                }
                
            }
            
        }
        
        
    }
    
}
