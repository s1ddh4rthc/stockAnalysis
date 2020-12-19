//
//  VolunteerOrdersViewController.swift
//  FinanceApp
//
//  Created by Siddharth on 12/18/20.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class VolunteerOrdersViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var acceptedOffers : [DataSnapshot] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        Database.database().reference().child("Accepted-Offers").observe(.childAdded) { (snapshot) in
            
            self.acceptedOffers.append(snapshot)
            self.tableView.reloadData()
            
        }
        
        Timer.scheduledTimer(withTimeInterval: 3, repeats: true) { (timer) in
            self.tableView.reloadData()
        }

    }

}

extension VolunteerOrdersViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return acceptedOffers.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "acceptedOffers") as? AvailableRestTableViewCell
        
        let snapshot = acceptedOffers[indexPath.row]
        
        if let acceptedDictionary = snapshot.value as? [String:Any] {
            
            if let chosenHosp = acceptedDictionary["chosenHosp"] as? String {
                
                if let distName = acceptedDictionary["distName"] as? String {
                    
                    cell?.hospName.text = "From: \(distName), To: \(chosenHosp)"
                    
                }
                
            }
            
        }
        
        return cell!
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 65
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let snapshot = acceptedOffers[indexPath.row]
        self.performSegue(withIdentifier: "driverMenu", sender: snapshot)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let volunteerMenu = segue.destination as? VolunteerOrderMenuViewController {
            
            if let snapshot = sender as? DataSnapshot {
                
                if let volunteerOrder = snapshot.value as? [String:Any] {
                    
                    if let hospName = volunteerOrder["chosenHosp"] as? String {
                        
                        if let distName = volunteerOrder["distName"] as? String {
                            
                            print("-" + hospName)
                            print("," + distName)
                            
                            volunteerMenu.HospName = hospName
                            volunteerMenu.distName = distName
                            
                        }
                        
                    }
                    
                }
                
            }
            
        }
        
    }
    
    
}
