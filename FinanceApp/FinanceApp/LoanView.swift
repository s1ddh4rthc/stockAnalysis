//
//  LoanView.swift
//  FinanceApp
//
//  Created by Arth Bohra on 12/18/20.
//

import UIKit
import FirebaseAuth
import Firebase
import FirebaseDatabase

class LoanView: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var bank = [String]()
    var duration = [String]()
    var principle = [String]()
    var apr = [String]()
    var security = [String]()
    
    @IBOutlet var tableView: UITableView!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
                tableView.dataSource = self
            self.tableView.reloadData()
                

        let postsRef = Database.database().reference().child("jobPosts")
        postsRef.observe(.value) { (snapshot) in
            
            for child in snapshot.children {
                if let childSnapshot = child as? DataSnapshot,
                   let dict = childSnapshot.value as? [String: Any],

                   let bank = dict["bankName"] as? String,
                   let duration = dict["duration"] as? String,
                   let principle = dict["loanAmount"] as? String,
                   let apr = dict["aprRate"] as? String,
                   let security = dict["security"] as? String {
                  
                   
                   print(bank)
                   print(duration)
   
                   self.bank.append((bank))
                   self.duration.append((duration))
                   self.principle.append((principle))
                   self.apr.append((apr))
                   self.security.append((security))
                    self.tableView.reloadData()
                }
                
            }
            
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            
            return bank.count
            
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
            //let cell = tableView.dequeueReusableCell(withIdentifier: "JobPost") as! jobPostingView
            let cell = tableView.dequeueReusableCell(withIdentifier: "JobCell", for: indexPath) as! loanPostingView

            
            let useBank = bank[indexPath.row]
            let useDuration = duration[indexPath.row]
            let usePrinciple = principle[indexPath.row]
            let useApr = apr[indexPath.row]
            let useSecurity = security[indexPath.row]
            cell.bankNameText.text = useBank
            cell.durationText.text = useDuration
            cell.loanAmountText.text = usePrinciple
            cell.aprText.text = useApr
            cell.securityText.text = useSecurity

                
            print(useBank)
            print(usePrinciple)
            
            return cell
            
        }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            
            return 200
            
        }
        
        
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "JobPost", for: indexPath) as! jobPostingView
//        let useLocation = locations[indexPath.row]
//        let useName = names[indexPath.row]
//        let useOther = others[indexPath.row]
//        let useTitle = titles[indexPath.row]
//        let useSkills = skillss[indexPath.row]
//    }
    


}
class viewMyLoanPosts: UIViewController {
    
    var bank = [String]()
    var duration = [String]()
    var principle = [String]()
    var apr = [String]()
    var security = [String]()
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        let postsRef = Database.database().reference().child("users/"+Auth.auth().currentUser!.uid + "/posts")
        postsRef.observe(.value) { (snapshot) in
            
            for child in snapshot.children {
                if let childSnapshot = child as? DataSnapshot,
                    let dict = childSnapshot.value as? [String: Any],
                    
                    let bank = dict["bankName"] as? String,
                    let duration = dict["duration"] as? String,
                    let principle = dict["loanAmount"] as? String,
                    let apr = dict["aprRate"] as? String,
                    let security = dict["security"] as? String {
                   
                    
                    
    
                    self.bank.append((bank))
                    self.duration.append((duration))
                    self.principle.append((principle))
                    self.apr.append((apr))
                    self.security.append((security))
                
    
                }
            }
        }


    }
}
class loanPostingView: UITableViewCell {
    
    @IBOutlet weak var bankNameText: UILabel!
    @IBOutlet weak var durationText: UILabel!
    @IBOutlet weak var loanAmountText: UILabel!
    @IBOutlet weak var aprText: UILabel!
    @IBOutlet weak var securityText: UILabel!
    
    
}


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

