//
//  JobPostView.swift
//  FinanceApp
//
//  Created by Arth Bohra on 12/18/20.
//

import UIKit

class JobPostView: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var locations = [String]()
    var names = [String]()
    var others = [String]()
    var skillss = [String]()
    var titles = [String]()
    
    @IBOutlet var tableView: UITableView!
    
    

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
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            
            return locations.count
            
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "JobPost") as? AvailableRestTableViewCell
            
            let useLocation = locations[indexPath.row]
            let useName = names[indexPath.row]
            let useOther = others[indexPath.row]
            let useTitle = titles[indexPath.row]
            let useSkills = skillss[indexPath.row]
            cell.jobTitleText = useTitle
            cell.nameText = useName
            cell.locationText = useLocation
            cell.skillText = useSkills
            cell.requirementText = useOther

                    
            return cell!
            
        }
        
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            
            return 65
            
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
class jobPostingView: UITableViewCell {
    
    @IBOutlet weak var jobTitleText: UILabel!
    @IBOutlet weak var nameText: UILabel!
    @IBOutlet weak var locationText: UILabel!
    @IBOutlet weak var skillText: UILabel!
    @IBOutlet weak var requirementText: UILabel!
    
    
}
