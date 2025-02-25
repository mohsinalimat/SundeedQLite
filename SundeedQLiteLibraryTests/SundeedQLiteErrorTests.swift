//
//  SundeedQLiteErrorTests.swift
//  SundeedQLiteLibraryTests
//
//  Created by Nour Sandid on 10/8/19.
//  Copyright © 2019 LUMBERCODE. All rights reserved.
//

import XCTest
@testable import SundeedQLiteLibrary

class SundeedQLiteErrorTests: XCTestCase {
    var employer: EmployerForTesting?
    var error: SundeedQLiteError?

    override func setUp() {
        employer = EmployerForTesting()
        employer?.fillData()
    }
    
    override func tearDown() {
        error = nil
        employer = nil
    }

    func testPrimaryKeyError() {
        guard let employer = employer else {
            XCTFail("Employer nil")
            return
        }
        error = .PrimaryKeyError(object: employer)
        let errorString = "SundeedQLiteError with class \(employer.getTableName()): \n No Primary Key \n - To add a primary key add a '+' sign in the mapping function in the class after the designated primary map \n  e.g: self.id = map[\"ID\"]+"
        XCTAssertEqual(error?.description, errorString)
    }
    
    func testUnsupportedTypeError() {
        guard let employer = employer else {
            XCTFail("Employer nil")
            return
        }
        error = .UnsupportedType(object: employer, attribute: "Test")
        let errorString = "SundeedQLiteError with class \(employer.getTableName()): \n Unsupported Type Test \n - Try to change the type of this attribute, or send us a suggestion so we can add it"
        XCTAssertEqual(error?.description, errorString)
    }
    
    func testNoColumnWithThisNameError() {
        guard let employer = employer else {
            XCTFail("Employer nil")
            return
        }
        error = .NoColumnWithThisName(object: employer, columnName: "Test")
        let errorString = "SundeedQLiteError with class \(employer.getTableName()): \n No Column With Title Test \n - Try to change the column name and try again"
        XCTAssertEqual(error?.description, errorString)
    }
    
    func testCantUseNameIndexError() {
        guard let employer = employer else {
            XCTFail("Employer nil")
            return
        }
        error = .CantUseNameIndex(object: employer)
        let errorString = "SundeedQLiteError with class \(employer.getTableName()): \n Unsupported column name \"index\" because it is reserved \n - Try to change it and try again"
        XCTAssertEqual(error?.description, errorString)
    }
    
    func testNoChangesMadeError() {
        guard let employer = employer else {
            XCTFail("Employer nil")
            return
        }
        error = .NoChangesMade(object: employer)
        let errorString = "SundeedQLiteError with class \(employer.getTableName()): \n Trying to perform global update statement with no changes \n - Try to add some changes and try again"
        XCTAssertEqual(error?.description, errorString)
    }
    
    func testErrorInConnectionError() {
        error = .ErrorInConnection
        let errorString = "SundeedQLiteError with Connection : \n Unable to create a connection to the local database \n Make sure that you have access and permissions to device's files"
        XCTAssertEqual(error?.description, errorString)
    }
}
