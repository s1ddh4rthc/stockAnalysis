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
    
    func errorMessage(title: String, message: String) {
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alertController, animated: true, completion: nil)
        
    }
    
    @IBAction func loginButtonPressed(_ sender: Any) {
        
        if let username = usernameTextField.text {
            
            if let password = passwordTextField.text {
                
                Auth.auth().signIn(withEmail: username, password: password) { (result, error) in
                    
                    if error != nil {
                        
                        self.errorMessage(title: "Login Error", message: error!.localizedDescription)
    
                    } else {
                        
                        self.performSegue(withIdentifier: "loginSegue", sender: self)
                        
                    }
                    
                }
                
            }
            
        }
        guard let emailLolz = email.text as? String else { return };
        
        if posPicker.selectedSegmentIndex == 0 {
            
            var values = ["email": emailLolz
                
                
                ]] as [String : Any]
            var user = Auth.auth().currentUser
            if let user = user {
                let uid = user.uid
                Database.database().reference().child("volunteers").child(uid).updateChildValues(values,withCompletionBlock: {(error, ref) in
                    if let error = error {
                        print ("Failed to update database value with errors: ", error.localizedDescription)
                        
                        return
                    }
                    
                })
            }
            
        }
        if posPicker.selectedSegmentIndex == 1 {
            
            var values = ["email": emailLolz
                
                
                ]] as [String : Any]
            var user = Auth.auth().currentUser
            if let user = user {
                let uid = user.uid
                Database.database().reference().child("employee").child(uid).updateChildValues(values,withCompletionBlock: {(error, ref) in
                    if let error = error {
                        print ("Failed to update database value with errors: ", error.localizedDescription)
                        
                        return
                    }
                    
                })
            }
            
        }
        if posPicker.selectedSegmentIndex == 2 {
            
            var values = ["email": emailLolz
                
                
                ]] as [String : Any]
            var user = Auth.auth().currentUser
            if let user = user {
                let uid = user.uid
                Database.database().reference().child("employer").child(uid).updateChildValues(values,withCompletionBlock: {(error, ref) in
                    if let error = error {
                        print ("Failed to update database value with errors: ", error.localizedDescription)
                        
                        return
                    }
                    
                })
            }
            
        }
        if posPicker.selectedSegmentIndex == 3 {
            
            var values = ["email": emailLolz
                
                
                ]] as [String : Any]
            var user = Auth.auth().currentUser
            if let user = user {
                let uid = user.uid
                Database.database().reference().child("bank").child(uid).updateChildValues(values,withCompletionBlock: {(error, ref) in
                    if let error = error {
                        print ("Failed to update database value with errors: ", error.localizedDescription)
                        
                        return
                    }
                    
                })
            }
            
        }
        
        
        
        
        
        
        
        
        let uid = Auth.auth().currentUser?.uid
        
        
        let  values = ["lastName": lastName.text, "name": firstName.text, "teamName": nameTeam.text, "school": school.text
            ] as [String : Any]
        
        
        
        let ref = Database.database().reference()
        ref.child("someid/" + String(uid!) + "/teamName").observeSingleEvent(of: .value) { (snapshot) in
            guard let coachUID = snapshot.value as? String else { return }
            Database.database().reference().child("coaches/" + coachUID + "/players").child(uid ?? " ").updateChildValues(values,withCompletionBlock: {(error, ref) in
                        if let error = error {
                            print ("Failed to update database value with errors: ", error.localizedDescription)
                            DispatchQueue.main.async {
                                let navController = UINavigationController(rootViewController: Homepage())
                                
                            }
                            return
                        }
                        Database.database().reference().child("someid").child(String(uid!)).updateChildValues(values,withCompletionBlock: {(error, ref) in
                            if let error = error {
                                print ("Failed to update database value with errors: ", error.localizedDescription)
                                DispatchQueue.main.async {
                                    let navController = UINavigationController(rootViewController: Homepage())
                                    
                                }
                                
                            }
                          
                            
                            
                            
                        })
                }
                
                
            )}
        
        
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
