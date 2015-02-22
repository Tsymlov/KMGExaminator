//
//  StudentTests.swift
//  KMGExaminator
//
//  Created by Alexey Tsymlov on 2/20/15.
//  Copyright (c) 2015 Alexey Tsymlov. All rights reserved.
//

import XCTest

class StudentTests: XCTestCase {
    
    var testStudent: Student!
    
    override func setUp() {
        Student.downloadMarkers()
        testStudent = Student("John", "Edward", "Scally")
    }

    func testInit(){
        XCTAssertEqual("John", testStudent.firstName)
        XCTAssertEqual("Edward", testStudent.secondName)
        XCTAssertEqual("Scally", testStudent.lastName)
        XCTAssertTrue(testStudent.scores.count > 0)
    }
    
    func testInit_WithoutParameter(){
        var anotherTestStudent = Student("студент", "", "Новый")
        XCTAssertEqual("Новый студент ", anotherTestStudent.fullName)
    }
    
    func testFullName(){
        XCTAssertEqual("Scally John Edward", testStudent.fullName)
    }
    
    func testGetScoreTypes(){
        let actualTypes = Student.getScoreTypes()
        XCTAssertEqual(["+","+-","-+","-"], actualTypes)
    }
    
//    func testSaveAtParse(){
//        let expectation = expectationWithDescription("Parse")
//        testStudent.scores = ["1": "1", "2": "2", "3": "3", "4": "1", "5": "2", "6": "3", "7": "1", "8": "2", "9": "3"]
//        testStudent.saveAtParse {()->() in expectation.fulfill()}
//        waitForExpectationsWithTimeout(10, handler: { (error) -> Void in
//            if error != nil{
//                XCTFail()
//            }
//        })
//    }
    
    func testDownloadMarkers(){
        Student.downloadMarkers()
        XCTAssertTrue(Markers.values.count > 0)
    }
    
//    func testUpdateAtParse(){
//        let expectation = expectationWithDescription("Parse")
//        testStudent.save()
//        testStudent.firstName = "TEST"
//        testStudent.scores = ["1": "1", "2": "2", "3": "3", "4": "1", "5": "2", "6": "3", "7": "1", "8": "2", "9": "3"]
//        testStudent.updateAtParse {()->() in expectation.fulfill()}
//        waitForExpectationsWithTimeout(60, handler: { (error) -> Void in
//            if error != nil{
//                XCTFail()
//            }
//        })
//    }

}
