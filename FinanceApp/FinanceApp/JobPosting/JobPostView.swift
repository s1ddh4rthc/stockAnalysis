//
//  JobPostView.swift
//  FinanceApp
//
//  Created by Arth Bohra on 12/18/20.
//

import UIKit

class JobPostView: UIViewController {
    
    var locations = [String]()
    var names = [String]()
    var others = [String]()
    var skillss = [String]()
    var titles = [String]()
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        let postsRef = Database.database().reference().child("jobPosts")
        postsRef.observe(.value) { (snapshot) in
            
            for child in snapshot.children {
                if let childSnapshot = child as? DataSnapshot,
                    let dict = childSnapshot.value as? [String: Any],
                    
                    let location = dict["location"] as? String,
                    let name = dict["name"] as? String,
                    let other = dict["other"] as? String,
                    let skills = dict["skills"] as? String,
                    let title = dict["title"] as? String {
                   
                    
                    
    
                    self.locations.append(String(location)!)
                    self.names.append(String(name)!)
                    self.others.append(String(other)!)
                    self.skillss.append(String(skills)!)
                    self.titles.append(String(title)!)
                    
    
                }
            }
        }


    }


}
class viewMyJobPosts: UIViewController {
    
    var locations = [String]()
    var names = [String]()
    var others = [String]()
    var skillss = [String]()
    var titles = [String]()
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        let postsRef = Database.database().reference().child("users/"+Auth.auth().currentUser.uid + "/posts")
        postsRef.observe(.value) { (snapshot) in
            
            for child in snapshot.children {
                if let childSnapshot = child as? DataSnapshot,
                    let dict = childSnapshot.value as? [String: Any],
                    
                    let location = dict["location"] as? String,
                    let name = dict["name"] as? String,
                    let other = dict["other"] as? String,
                    let skills = dict["skills"] as? String,
                    let title = dict["title"] as? String {
                   
                    
                    
    
                    self.locations.append(String(location)!)
                    self.names.append(String(name)!)
                    self.others.append(String(other)!)
                    self.skillss.append(String(skills)!)
                    self.titles.append(String(title)!)
                    
    
                }
            }
        }


    }
}
