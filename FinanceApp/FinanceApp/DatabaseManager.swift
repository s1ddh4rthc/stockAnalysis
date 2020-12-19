//
//  DatabaseManager.swift
//  FinanceApp
//
//  Created by Siddharth on 12/18/20.
//

import Foundation
import FirebaseDatabase

final class DatabaseManager {
    
    static let shared = DatabaseManager()
       
       private let database = Database.database().reference()
       
       static func safeEmail(emailAddress: String) -> String {
           
           var safeEmail = emailAddress.replacingOccurrences(of: ".", with: "-").replacingOccurrences(of: "@", with: "-")
           return safeEmail
           
       }
       
   }


extension DatabaseManager {
    
    public func insertVolunteer(with user: Volunteer, completion: @escaping (Bool) -> Void) {
        database.child(user.safeEmail).setValue([
            "firstName" : user.firstName,
            "lastName" : user.lastName,
        ], withCompletionBlock: { error, _ in
            guard error == nil else {
                completion(false)
                return
            }
        })
        
    }
    
    public func insertEmployee(with user: Employee, completion: @escaping (Bool) -> Void) {
        database.child(user.safeEmail).setValue([
            "firstName" : user.firstName,
            "lastName" : user.lastName,
        ], withCompletionBlock: { error, _ in
            guard error == nil else {
                completion(false)
                return
            }
        })
        
    }
    
    public func insertEmployer(with user: Employer, completion: @escaping (Bool) -> Void) {
        database.child(user.safeEmail).setValue([
            "name" : user.name,
            "geolocation" : user.geolocation,
            "jobsProvided" : user.jobsProvided,
        ], withCompletionBlock: { error, _ in
            guard error == nil else {
                completion(false)
                return
            }
        })
        
    }
    
    public func insertBank(with user: Bank, completion: @escaping (Bool) -> Void) {
        database.child(user.safeEmail).setValue([
            "name" : user.name,
            "geolocation" : user.geolocation,
            "interestRate" : user.interestRate
        ], withCompletionBlock: { error, _ in
            guard error == nil else {
                completion(false)
                return
            }
        })
        
    }
}


struct Volunteer {
    let firstName: String
    let lastName: String
    let email: String
    
    var safeEmail: String {
        let safeEmail = email.replacingOccurrences(of: ".", with: "-").replacingOccurrences(of: "@", with: "-")
        return safeEmail
    }
    
}

struct Employee {
    
    let firstName: String
    let lastName: String
    let email: String
    
    var safeEmail: String {
        let safeEmail = email.replacingOccurrences(of: ".", with: "-").replacingOccurrences(of: "@", with: "-")
        return safeEmail
    }
    
}

struct Employer {
    
    let geolocation: [Double]
    let name: String
    let jobsProvided: Int
    let email: String
    
    var safeEmail: String {
        let safeEmail = email.replacingOccurrences(of: ".", with: "-").replacingOccurrences(of: "@", with: "-")
        return safeEmail
    }
    
}

struct Bank {
    
    let geolocation: [Double]
    let name: String
    let interestRate: Double
    let email: String
    
    var safeEmail: String {
        let safeEmail = email.replacingOccurrences(of: ".", with: "-").replacingOccurrences(of: "@", with: "-")
        return safeEmail
    }
    
}

