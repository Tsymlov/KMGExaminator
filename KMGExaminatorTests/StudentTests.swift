//
//  StudentTests.swift
//  KMGExaminator
//
//  Created by Alexey Tsymlov on 2/20/15.
//  Copyright (c) 2015 Alexey Tsymlov. All rights reserved.
//

import XCTest

class StudentTests: XCTestCase {
    
    var testStudent: Student = Student(firstName: "John", secondName: "Edward", lastName: "Scally")

    func testInit(){
        XCTAssertEqual("John", testStudent.firstName)
        XCTAssertEqual("Edward", testStudent.secondName)
        XCTAssertEqual("Scally", testStudent.lastName)
    }
    
    func testFullName(){
        XCTAssertEqual("John Edward Scally", testStudent.fullName)
    }

}
