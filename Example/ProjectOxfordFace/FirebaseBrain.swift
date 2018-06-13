//
//  FirebaseBrain.swift
//  ProjectOxfordFace_Example
//
//  Created by Neha Nish on 6/1/18.
//  Copyright © 2018 David Porter. All rights reserved.
//

import Foundation
import UIKit
import FirebaseDatabase
import FirebaseCore
import FirebaseStorage

class FirebaseBrain: NSObject {
    
    //var groupNames: [NSString] = []
    var groupName: NSString = ""
    var personNames: [NSString] = []
    var faces: [UIImage] = []
    
    var personDictionary = Dictionary<NSString, [UIImage]>()
    
    var ref: DatabaseReference!
    
    //LAST THING: LOAD FIREBASE SAVED DATA AT THE BEGINNING OF EACH APP
    
    func ssave(){ //call firebase each time because a new brain is created with each new group
        print("works")
        print(groupName)
        print(personNames)
        
        ref = Database.database().reference().child("groups")
        
        
        
        
        var groupDictionary = Dictionary<NSString, Any>()
        groupDictionary = ["Group Name": groupName, "person": personDictionary]
        
        
        ref.childByAutoId().setValue(groupDictionary)
        
        let imageName = NSUUID().uuidString
        let storageRef=Storage.storage().reference().child("\(imageName).png")
        if let uploadData = UIImagePNGRepresentation(faces[0]){
            storageRef.putData(uploadData, metadata: nil, completion: { (metadata, error) in
                if (error != nil) {
                    print(error)
                    return
                }
                print(metadata)
            }) //WHAT THE FREAK IS METADATA?????????
        }
        
        
        //self.ref.child("Group").setValue("Name", [groupNames[0])//"Person" : personNames[0]])
        
        //self.ref.child(groupName as String)
        
        //self.ref.child("Group").setValue(["GroupName": groupNames[0], "Person" : personNames[0]]) //creates group/groupname reference and assigns groupname value
        //self.ref.child("Group").child("GroupName").child("People").child("PersonName").setValue(personNames[0]) //rewrites a new group/groupName/People/PersonName refererence with value over the original group/groupname reference from the line above, so the original reference obsolete (thus groupName doesn't save)- find out how to add info and access existing info instead of rewriting info
    }
    
    func saveGroupName(_ gN: NSString){
        groupName=gN
    }
    
    func savePersonName(_ personName: NSString){
        personNames.append(personName)
    }
    
    func savePersonFace(_ personName: NSString, _ personFace: UIImage){ //use firebase storage to save images
        faces.append(personFace)
        
    }
    
    func clearPersonFaces(_ personName: NSString){
        personDictionary[personName]=faces
        faces=[]
    }

}
