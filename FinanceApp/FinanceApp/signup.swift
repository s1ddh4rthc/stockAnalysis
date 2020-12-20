//
//  signup.swift
//  FinanceApp
//
//  Created by Arth Bohra on 12/18/20.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class signup: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet var posPicker: UISegmentedControl!
    @IBOutlet var registerButton: UIButton!
    
    func errorMessage(title: String, message: String) {
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alertController, animated: true, completion: nil)
        
    }
    
    @IBAction func loginButtonPressed(_ sender: Any) {
        if let username = usernameTextField.text {
            
            if let password = passwordTextField.text {
                
                print ("Function passed")
                      Auth.auth().createUser(withEmail: username, password: password) { (result, error) in
                          if let error = error {
                              print ("Failed to sign user up with error", error.localizedDescription)
                                
                              
                              print ("Hello")
                          }
                              
                          Auth.auth().signIn(withEmail: username, password: password) { (result, error) in
                              if let error = error {
                                  print ("Failed to sign up user with error message: ", error.localizedDescription)
                                  
                                  return
                              }
                              print ("Successfully logged user in...")
                            
                                  
                                  
                          }
                        
                          
                }
                
            }
            
        }
        guard let emailLolz = usernameTextField.text as? String else { return };
        
        if posPicker.selectedSegmentIndex == 0 {
            
            var values = ["email": emailLolz, "type": "volunteer"
                
                
            ] as [String : Any]
            var user = Auth.auth().currentUser
            if let user = user {
                let uid = user.uid
                Database.database().reference().child("users").child(uid).updateChildValues(values,withCompletionBlock: {(error, ref) in
                    if let error = error {
                        print ("Failed to update database value with errors: ", error.localizedDescription)
                        
                        return
                    }
                    
                })
            }
            
        }
        if posPicker.selectedSegmentIndex == 1 {
            
            var values = ["email": emailLolz, "type": "employee"
                
                
                ] as [String : Any]
            var user = Auth.auth().currentUser
            if let user = user {
                let uid = user.uid
                Database.database().reference().child("users").child(uid).updateChildValues(values,withCompletionBlock: {(error, ref) in
                    if let error = error {
                        print ("Failed to update database value with errors: ", error.localizedDescription)
                        
                        return
                    }
                    
                })
            }
            
            
        }
        if posPicker.selectedSegmentIndex == 2 {
            
            var values = ["email": emailLolz, "type": "employer"
                
                
            ] as [String : Any]
            var user = Auth.auth().currentUser
            if let user = user {
                let uid = user.uid
                Database.database().reference().child("users").child(uid).updateChildValues(values,withCompletionBlock: {(error, ref) in
                    if let error = error {
                        print ("Failed to update database value with errors: ", error.localizedDescription)
                        
                        return
                    }
                    
                })
            }
            
        }
        if posPicker.selectedSegmentIndex == 3 {
            
            var values = ["email": emailLolz, "type": "bank"
                
                
            ] as [String : Any]
            var user = Auth.auth().currentUser
            if let user = user {
                let uid = user.uid
                Database.database().reference().child("users").child(uid).updateChildValues(values,withCompletionBlock: {(error, ref) in
                    if let error = error {
                        print ("Failed to update database value with errors: ", error.localizedDescription)
                        
                        return
                    }
                    
                })
            }
            
        }
        self.performSegue(withIdentifier: "registrationDone", sender: self)
    }
   

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.usernameTextField.delegate = self
        self.passwordTextField.delegate = self
        usernameTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        usernameTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        self.view.endEditing(true)
        return true
    }

}
class myProfile: UIViewController {
    
    @IBOutlet var address: UILabel!
    @IBOutlet var city: UILabel!
    @IBOutlet var state: UILabel!
    @IBOutlet var attended: UILabel!
    @IBOutlet var degree: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        let user = Auth.auth().currentUser
        
        var o = 0
         if let user = user {
            let ref = Database.database().reference()
            let code = user.uid

            ref.child("users/" + String(code) + "/address").observeSingleEvent(of: .value) { (snapshot) in
                guard let goalsCurrent = snapshot.value as? String else { return }
                self.address.text = String(goalsCurrent)
            }
            ref.child("users/" + String(code) + "/city").observeSingleEvent(of: .value) { (snapshot) in
                guard let goalsCurrent = snapshot.value as? String else { return }
                self.city.text = String(goalsCurrent)
            }
            ref.child("users/" + String(code) + "/state").observeSingleEvent(of: .value) { (snapshot) in
                guard let goalsCurrent = snapshot.value as? String else { return }
                self.state.text = String(goalsCurrent)
            }
            ref.child("users/" + String(code) + "/collegeAttended").observeSingleEvent(of: .value) { (snapshot) in
                guard let goalsCurrent = snapshot.value as? String else { return }
                self.attended.text = String(goalsCurrent)
            }
            ref.child("users/" + String(code) + "/degree").observeSingleEvent(of: .value) { (snapshot) in
                guard let goalsCurrent = snapshot.value as? String else { return }
                self.degree.text = String(goalsCurrent)
            }
         }
        
    }
    
}
class editProfile: UIViewController, UITextFieldDelegate {
    
    @IBOutlet var address: UITextField!
    @IBOutlet var city: UITextField!
    @IBOutlet var state: UITextField!
    @IBOutlet var attended: UITextField!
    @IBOutlet var degree: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        address.resignFirstResponder()
        state.resignFirstResponder()
        attended.resignFirstResponder()
        city.resignFirstResponder()
        degree.resignFirstResponder()
    }
    @IBAction func finish(_ sender: Any) {
        let user = Auth.auth().currentUser
        if let user = user {
            
            
            let uid = user.uid
            let ref = Database.database().reference()
            ref.child("users/" + uid + "/address").setValue(address.text)
            ref.child("users/" + uid + "/city").setValue(city.text)
            ref.child("users/" + uid + "/state").setValue(state.text)
            ref.child("users/" + uid + "/collegeAttended").setValue(attended.text)
            ref.child("users/" + uid + "/degree").setValue(degree.text)
            
        }
        
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        address.resignFirstResponder()
        state.resignFirstResponder()
        attended.resignFirstResponder()
        city.resignFirstResponder()
        degree.resignFirstResponder()
        self.view.endEditing(true)
        return true
    }
}
class mySkills: UIViewController,  UITableViewDataSource, UITableViewDelegate {
    
    var skills = [String]()
    var froms = [String]()
    var masterys = [String]()
    var experiences = [String]()
    @IBOutlet var tableView: UITableView!
    
    
    

    override func viewDidLoad() {
        tableView.delegate = self
                tableView.dataSource = self
            self.tableView.reloadData()
        super.viewDidLoad()
        let postsRef = Database.database().reference().child("users/"+Auth.auth().currentUser!.uid + "/skills")
        postsRef.observe(.value) { (snapshot) in
            
            for child in snapshot.children {
                if let childSnapshot = child as? DataSnapshot,
                    let dict = childSnapshot.value as? [String: Any],
                    
                    let skill = dict["skill"] as? String,
                    let from = dict["from"] as? String,
                    let mastery = dict["mastery"] as? String,
                    
                    let experience = dict["experience"] as? String {
                   
                    
                    
    
                    self.skills.append((skill))
                    self.froms.append((from))
                    self.masterys.append((mastery))
                    self.experiences.append((experience))
                    
                    self.tableView.reloadData()
                    
                    self.tableView.reloadData()

    
                }
            }
        }


    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            
            return skills.count
            
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
            //let cell = tableView.dequeueReusableCell(withIdentifier: "JobPost") as! jobPostingView
            let cell = tableView.dequeueReusableCell(withIdentifier: "SkillCell", for: indexPath) as! skillPostingView

            
            let useSkill = skills[indexPath.row]
            let useAcquired = froms[indexPath.row]
            let useExperience = masterys[indexPath.row]
            let useMastery = experiences[indexPath.row]
            cell.skillNameText.text = useSkill
            cell.acquiredFromText.text = useAcquired
            cell.experienceText.text = useExperience
            cell.masteryThing.value = (Float)(useMastery)!
                
            return cell
            
        }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            
            return 135
            
        }
}
class addSkills: UIViewController, UITextFieldDelegate {
    
    @IBOutlet var name: UITextField!
    @IBOutlet var from: UITextField!
    @IBOutlet var mastery: UITextField!
    @IBOutlet var experience: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    @IBAction func addSkill(_ sender: Any) {
        
        guard let skillName = name.text as? String else { return }
        guard let whereFrom = from.text as? String else { return }
        guard let masteryLevel = mastery.text as? String else { return }
        guard let levelExperience = experience.text as? String else { return }
        let user = Auth.auth().currentUser
        guard let uid =  (user?.uid)! as? String else { return }
        if let user = user {
            let uid = user.uid
            let postRef = Database.database().reference().child("users/" + (uid) + "/skills").childByAutoId()
            
            
            let postObject = [
                
                "skill": skillName,
                "from": whereFrom,
                "mastery": masteryLevel,
                "experience": levelExperience,
                "timestamp": [".sv": "timestamp"]
                
                ] as [String: Any]
            
            postRef.setValue(postObject) { (error, ref) in
                if error == nil {
                    self.dismiss(animated: true, completion: nil)
                } else {
                    print ("Error", error?.localizedDescription)
                }
            
          
        }
        
        
        
            
        }
    }
}
class bestLoan: UIViewController {
    
    @IBOutlet var loanAmount: UITextField!
    @IBOutlet var interestRate: UITextField!
    
    @IBOutlet var duration: UITextField!
    @IBOutlet var security: UITextField!
    @IBOutlet var imageViewTing: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    @IBAction func buttonLol(_ sender: Any) {
        guard let amt = loanAmount.text as? String else { return }
        guard let inst = interestRate.text as? String else { return }
        guard let dur = duration.text as? String else { return }
        guard let secur = security.text as? Int else { return }
        let bank = ""
        
        if (security == 1) {
            bank = "Patelco"
            let imageName = "132141676_162803565627658_8811870711475981484_n.png"
            let image = UIImage(named: imageName)
            imageViewTing = UIImageView(image: image!)
        }
        if (security == 2) {
            bank = "Citi"
            let imageName = "132040850_3757896707567154_5245483586342873397_n.png"
            let image = UIImage(named: imageName)
            imageViewTing = UIImageView(image: image!)
        }
        if (security == 3) {
            bank = "Union Bank"
            let imageName = "48415080_2302340576669675_5644961811615711232_n.png"
            let image = UIImage(named: imageName)
            imageViewTing = UIImageView(image: image!)
        }
        if (security == 4) {
            bank = "Chase"
            let imageName = "132029299_307074283936887_7172416951977058603_n.png"
            let image = UIImage(named: imageName)
            imageViewTing = UIImageView(image: image!)
        }
        if (security == 5) {
            bank = "Bank of America"
            let imageName = "132042848_411132100035995_7463449053841261681_n.png"
            let image = UIImage(named: imageName)
            imageViewTing = UIImageView(image: image!)
        } else {
            
            bank = "Bank of America"
            let imageName = "132042848_411132100035995_7463449053841261681_n.png"
            let image = UIImage(named: imageName)
            imageViewTing = UIImageView(image: image!)
            
        }
        
        let user = Auth.auth().currentUser
        guard let uid =  (user?.uid)! as? String else { return }
        if let user = user {
            let uid = user.uid
            let postRef = Database.database().reference().child("users/" + (uid) + "/loans").childByAutoId()
            let postRef1 = Database.database().reference().child("loans").childByAutoId()
            
//          let bank = dict["bankName"] as? String,
//          let duration = dict["duration"] as? String,
//          let principle = dict["loanAmount"] as? String,
//          let apr = dict["aprRate"] as? String,
//          let security = dict["security"] as? String {
            let postObject = [
                
                "loanAmount": amt,
                "aprRate": inst,
                "duration": dur,
                "security": secur,
                "bankName": bank,
                "timestamp": [".sv": "timestamp"]
                
                ] as [String: Any]
            
            postRef.setValue(postObject) { (error, ref) in
                if error == nil {
                    self.dismiss(animated: true, completion: nil)
                } else {
                    print ("Error", error?.localizedDescription)
                }
                postRef1.setValue(postObject) { (error, ref) in
                    if error == nil {
                        self.dismiss(animated: true, completion: nil)
                    } else {
                        print ("Error", error?.localizedDescription)
                    }
            
          
        }
        
        
        
            
        }
    }
    
    
}
class skillPostingView: UITableViewCell {
    
    @IBOutlet var skillNameText: UILabel!
    @IBOutlet var acquiredFromText: UILabel!
    @IBOutlet var experienceText: UILabel!
    @IBOutlet var masteryThing: UISlider!
    
    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//    }
    
    
}
