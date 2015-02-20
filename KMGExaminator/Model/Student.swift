//
//  Student.swift
//  KMGExaminator
//
//  Created by Alexey Tsymlov on 2/20/15.
//  Copyright (c) 2015 Alexey Tsymlov. All rights reserved.
//

import Foundation

class Student {
    var firstName = ""
    var secondName = ""
    var lastName = ""
    var fullName: String{
        get{
            return "\(firstName) \(secondName) \(lastName)"
        }
    }
    
    init(firstName: String, secondName: String, lastName: String){
        self.firstName = firstName
        self.secondName = secondName
        self.lastName = lastName
    }
    
    
}
