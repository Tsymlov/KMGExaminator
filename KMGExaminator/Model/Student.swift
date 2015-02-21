//
//  Student.swift
//  KMGExaminator
//
//  Created by Alexey Tsymlov on 2/20/15.
//  Copyright (c) 2015 Alexey Tsymlov. All rights reserved.
//

import Foundation

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
    
    init(){
        lastName = "Новый"
        firstName = "студент"
        secondName = ""
        scores = Dictionary<String,String>()
        initScores()
    }
    
    func initScores(){
        let markers = Student.getMarkers()
        for marker in markers {
            scores[marker] = "+"
        }
    }
    
    init(_ firstName: String, _ secondName: String, _ lastName: String){
        self.firstName = firstName
        self.secondName = secondName
        self.lastName = lastName
        scores = Dictionary<String,String>()
        initScores()
    }
    
    class func getMarkers() -> Array<String>{
        return ["Стойки и перемещения ПП", "Стойки и перемещения БС", "Прямые удары"]
    }
    
    class func getScoreTypes() -> Array<String>{
        return ["+", "+-", "-+", "-"]
    }
}
