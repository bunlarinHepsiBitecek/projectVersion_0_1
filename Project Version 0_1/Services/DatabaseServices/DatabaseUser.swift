//
//  DatabaseUser.swift
//  Project Version 0_1
//
//  Created by Erkut Baş on 25.11.2017.
//  Copyright © 2017 Erkut Baş. All rights reserved.
//

import Foundation
import FirebaseDatabase
import SwiftKeychainWrapper

let databaseReferenceObject = Database.database().reference()

class DatabaseUser {

    static let ds = DatabaseUser()
    
    // firebase database reference definitions
    private var _database_reference = databaseReferenceObject
    private var _database_reference_User = databaseReferenceObject.child("Users")
    
    var getDatabaseReference : DatabaseReference {
        
        return _database_reference
        
    }
    
    var getDatabaseReferenceUser : DatabaseReference {
        
        return _database_reference_User
        
    }
    
    var getDatabaseCurrentUser : DatabaseReference {
        
        let userIDKeyChainObject = KeychainWrapper.standard.string(forKey: USER_ID)
        
        let user = getDatabaseReferenceUser.child(userIDKeyChainObject!)
       
        return user
        
    }
    
    func createFirbaseDatabaseUser(userID: String, userData: Dictionary<String, String>) {
        
        getDatabaseReferenceUser.child(userID).updateChildValues(userData)
        
    }
    
}
