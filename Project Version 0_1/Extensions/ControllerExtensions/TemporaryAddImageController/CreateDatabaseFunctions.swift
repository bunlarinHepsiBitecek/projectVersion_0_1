//
//  CreateDatabaseFunctions.swift
//  Project Version 0_1
//
//  Created by Erkut Baş on 28.11.2017.
//  Copyright © 2017 Erkut Baş. All rights reserved.
//

import Foundation
import UIKit
import FirebaseAuth
import FirebaseStorage

extension TempoaryAddImageViewController {
    
    func createUserAndLoadDataToStorage() {
        
        let imageName = NSUUID().uuidString
        
        let storageReference = Storage.storage().reference().child(CONSTANT_STRING_PROFILE_IMAGES).child("\(imageName).png")
        
        if let uploadData = UIImagePNGRepresentation(self.imageView.image!) {
           
            storageReference.putData(uploadData, metadata: nil, completion: { (metadata, error) in
                
                if error != nil {
                    
                    if let errorMessage = error as NSError? {
                        
                        print("errorMessage : \(errorMessage.localizedDescription)")
                        print("errorMessage : \(errorMessage.userInfo)")
                        
                    }
                    
                } else {
                    
                    self.userObject.setUserProfilePicture(inputUserProfileImage: self.imageView.image!)
                    self.setUserData(inputUrl: (metadata?.downloadURL()?.absoluteString)!, inputImageUniqueID: imageName)
                    self.createUser()
                    
                }
            })
        }
    }

    func setUserData(inputUrl : String, inputImageUniqueID : String) {
        
        self.userObject.setUserProfilePictureUrl(inputUrl: inputUrl)
        self.userObject.setUserProfilePictureUniqueID(inputUserProfilePictureUniqueID: inputImageUniqueID)
        
        self.userObject.appendAttributeToDictionary(inputKey: CONSTANT_STRING_PROFILE_PICTURE_UNIQUE_ID, inputValue: self.userObject.userProfilePictureUniqueID)
        self.userObject.appendAttributeToDictionary(inputKey: CONSTANT_URL, inputValue: self.userObject.userProfilePictureUrl)
        
        print("userProfilePictureURL : \(self.userObject.userProfilePictureUrl)")
        print("userEmail :\(self.userObject.email)")
        
    }
    
    func createUser() {
        
        DatabaseUser.ds.createFirbaseDatabaseUser(userID: self.userObject.userID, userData: self.userObject.userDictionary)
        
    }
    
    
    
}
