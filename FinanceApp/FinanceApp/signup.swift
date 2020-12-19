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
