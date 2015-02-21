//
//  StudentTests.swift
//  KMGExaminator
//
//  Created by Alexey Tsymlov on 2/20/15.
//  Copyright (c) 2015 Alexey Tsymlov. All rights reserved.
//

import XCTest

class StudentTests: XCTestCase {
    
    var testStudent: Student = Student("John", "Edward", "Scally")

    func testInit(){
        XCTAssertEqual("John", testStudent.firstName)
        XCTAssertEqual("Edward", testStudent.secondName)
        XCTAssertEqual("Scally", testStudent.lastName)
        XCTAssertTrue(testStudent.scores.count > 0)
    }
    
    func testInit_WithoutParameter(){
        var anotherTestStudent = Student()
        XCTAssertEqual("Новый студент ", anotherTestStudent.fullName)
    }
    
    func testFullName(){
        XCTAssertEqual("Scally John Edward", testStudent.fullName)
    }
    
    func testGetMarkers(){
        let scores = Student.getMarkers()
        XCTAssertTrue((scores as Any)is Array<String>)
        XCTAssertTrue(scores.count > 0)
    }
    
    func testGetScoreTypes(){
        let actualTypes = Student.getScoreTypes()
        XCTAssertEqual(["+","+-","-+","-"], actualTypes)
    }

}
