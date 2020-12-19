//
//  JobPost.swift
//  FinanceApp
//
//  Created by Arth Bohra on 12/18/20.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class JobPost: UIViewController {

    @IBOutlet var jobTitle: UITextField!
    @IBOutlet var necessarySkills: UITextField!
    @IBOutlet var employerName: UITextField!
    @IBOutlet var jobLocation: UITextField!
    @IBOutlet var otherRequirements: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func postJob(_ sender: Any) {
        guard let post = jobTitle.text as? String else { return }
        guard let employName = employerName.text as? String else { return }
        guard let necSkills = necessarySkills.text as? String else { return }
        guard let jobLocate = jobLocation.text as? String else { return }
        guard let otherStuffZ = otherRequirements.text as? String else { return }
        let user = Auth.auth().currentUser
        guard let uid =  (user?.uid)! as? String else { return }
        if let user = user {
            let uid = user.uid
            let postRef = Database.database().reference().child("users/" + (uid) + "/posts").childByAutoId()
            let postRef1 = Database.database().reference().child("jobPosts").childByAutoId()
            
            let postObject = [
                
                "title": post,
                "skills": necSkills,
                "name": employName,
                "location": jobLocate,
                "other": otherStuffZ,
                "timestamp": [".sv": "timestamp"]
                
                ] as [String: Any]
            
            postRef.setValue(postObject) { (error, ref) in
                if error == nil {
                    self.dismiss(animated: true, completion: nil)
                } else {
                    print ("Error", error?.localizedDescription)
                }
            
          
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

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
