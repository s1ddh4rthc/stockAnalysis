//
//  AcceptHospViewController.swift
//  FinanceApp
//
//  Created by Siddharth on 12/18/20.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

class AcceptHospViewController: UIViewController {
    
    @IBOutlet weak var hospName: UILabel!
    
    var hospitalName = ""
    
    var acceptedOfferDictionary = [String:Any]()
    
    let email = Auth.auth().currentUser?.email?.replacingOccurrences(of: ".", with: "-").replacingOccurrences(of: "@", with: "-")

    override func viewDidLoad() {
        super.viewDidLoad()
        
        hospName.text = hospitalName
                

    }
    
    @IBAction func acceptOrderPressed(_ sender: Any) {
        
        Database.database().reference().child(email!).observeSingleEvent(of: .value) { (snapshot) in
                        
            let value = snapshot.value as? NSDictionary
            
            if let name = value?["name"] as? String ?? "" {
                
                if let geoLocation = value?["geolocation"] as? [Double] ?? [] {
                    
                    self.acceptedOfferDictionary = ["hospName" : name, "hospLocation" : geoLocation, "chosenHosp" : self.hospitalName, "status" : "requested"]
                    
                    Database.database().reference().child("Accepted-Offers").childByAutoId().setValue(self.acceptedOfferDictionary)
                    
                    Database.database().reference().child("Outgoing-Offers").queryOrdered(byChild: "name").queryEqual(toValue: self.hospitalName).observe(.childAdded) { (snapshot) in
                        
                        
                        snapshot.ref.removeValue()
                        Database.database().reference().child("Outgoing-Offers").removeAllObservers()
                        
                    }
                }
                
            }
            
        }
        
        
        
    }

    

   
}
