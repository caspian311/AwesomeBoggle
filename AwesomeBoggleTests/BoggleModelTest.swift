//
//  BoggleModelTest.swift
//  AwesomeBoggle
//
//  Created by mtodd on 2/9/17.
//  Copyright © 2017 Matt Todd. All rights reserved.
//
@testable import AwesomeBoggle
import XCTest

class BoggleModelTest: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func test_AddLetter_AddsTheLetter() {
        let testObject = BoggleModel()
        testObject.addLetter("h")
        
        XCTAssertEqual("h", testObject.getCurrentWord())
    }
    
    func test_AddLetter_AddsTheNextLetterToTheCurrentWord() {
        let testObject = BoggleModel()
        testObject.addLetter("h")
        testObject.addLetter("i")
        
        XCTAssertEqual("hi", testObject.getCurrentWord())
    }
}
