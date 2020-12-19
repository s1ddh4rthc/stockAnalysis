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
            let code = user?.uid

            ref.child("users/" + String(code!) + "/address").observeSingleEvent(of: .value) { (snapshot) in
                guard let goalsCurrent = snapshot.value as? String else { return }
                self.address.text = String(goalsCurrent)
            }
            ref.child("users/" + String(code!) + "/city").observeSingleEvent(of: .value) { (snapshot) in
                guard let goalsCurrent = snapshot.value as? String else { return }
                self.city.text = String(goalsCurrent)
            }
            ref.child("users/" + String(code!) + "/state").observeSingleEvent(of: .value) { (snapshot) in
                guard let goalsCurrent = snapshot.value as? String else { return }
                self.state.text = String(goalsCurrent)
            }
            ref.child("users/" + String(code!) + "/collegeAttended").observeSingleEvent(of: .value) { (snapshot) in
                guard let goalsCurrent = snapshot.value as? String else { return }
                self.attended.text = String(goalsCurrent)
            }
            ref.child("users/" + String(code!) + "/degree").observeSingleEvent(of: .value) { (snapshot) in
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
