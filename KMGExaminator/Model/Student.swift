//
//  Student.swift
//  KMGExaminator
//
//  Created by Alexey Tsymlov on 2/20/15.
//  Copyright (c) 2015 Alexey Tsymlov. All rights reserved.
//

import Foundation
import Parse



class Student {
    var firstName: String
    var secondName: String
    var lastName: String
    var fullName: String{
        get{
            return "\(lastName) \(firstName) \(secondName)"
        }
    }
    var scores: Dictionary<String, String>
    var pfObject: PFObject
    
    func initScores(){
        for marker in Markers.values {
            scores[marker] = "+"
        }
    }
    
    var group: String
    var level: String
    
    init(_ firstName: String, _ secondName: String, _ lastName: String){
        self.firstName = firstName
        self.secondName = secondName
        self.lastName = lastName
        scores = Dictionary<String,String>()
        pfObject = PFObject(className: "Student")
        group = ""
        level = ""
        refreshPFObject()
        initScores()
    }
    
    class func downloadMarkers(){
        downloadMarkersFromParse()
    }
    
    private class func downloadMarkersFromParse(){
        let query = PFQuery(className: "Marker")
        query.orderByAscending("index")
        let objects = query.findObjects()
        println("Successfully retrieved \(objects.count) markers.")
        for object in objects {
            let markerName = object["name"] as String
            Markers.values.append(markerName)
            println("\(markerName)")
        }
    }
    
    class func getScoreTypes() -> Array<String>{
        return ["+", "+-", "-+", "-"]
    }
    
    func saveEventualy(){
        saveEventualyAtParse()
    }
    
    private func saveAtParse(success: ()->()){
        refreshPFObject();
        self.pfObject.saveEventually { (result, error) -> Void in
            println("Student \(self.pfObject.objectId) \(self.fullName) saved in Parse")
            success()
        }
    }
    
    private func refreshPFObject(){
        self.pfObject["firstName"] = self.firstName
        self.pfObject["secondName"] = self.secondName
        self.pfObject["lastName"] = self.lastName
        self.pfObject["scores"] = self.scores
        self.pfObject["level"] = self.level
        self.pfObject["group"] = self.group
    }
    
    private func saveEventualyAtParse(){
        saveAtParse({})
    }
    
    func update(){
        updateAtParse({})
    }
    
    private func updateAtParse(success: ()->()){
        refreshPFObject()
        self.pfObject.saveInBackgroundWithBlock { (flag, error) -> Void in
            if error != nil
            {
                println("Error: \(error.userInfo)")
            }else{
                println("Student \(self.pfObject.objectId) \(self.fullName) updated in Parse")
                success()
            }
        }
    }
    
    func delete(){
        deleteAtParse { (flag, error) -> Void in
            if error != nil
            {
                println("Error: \(error.userInfo)")
            }else{
                println("Student \(self.pfObject.objectId) \(self.fullName) deleted in Parse")
            }
        }
    }
    
    private func deleteAtParse(success: PFBooleanResultBlock){
        self.pfObject.deleteInBackgroundWithBlock (success)
    }
}

struct Markers {
    static var values = Array<String>()
}
