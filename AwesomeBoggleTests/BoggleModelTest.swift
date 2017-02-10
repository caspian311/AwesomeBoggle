@testable import AwesomeBoggle
import XCTest

class BoggleModelTest: XCTestCase {
    var testObject: BoggleModel?
    var testDelegate: TestBoggleModelDelegate?
    
    override func setUp() {
        super.setUp()
        
        testDelegate = TestBoggleModelDelegate()
        
        testObject = BoggleModel()
        testObject?.delegate = testDelegate
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func test_addLetter_AddsTheLetter() {
        testObject?.addLetter("h")
        
        XCTAssertEqual("h", testObject?.getCurrentWord())
    }
    
    func test_addLetter_AddsTheNextLetterToTheCurrentWord() {
        testObject?.addLetter("h")
        testObject?.addLetter("i")
        
        XCTAssertEqual("hi", testObject?.getCurrentWord())
    }
    
    func test_clearWord_RetrievesTheCurrentWord() {
        testObject?.addLetter("h")
        testObject?.addLetter("i")
        
        testObject?.clearWord()
        
        XCTAssertEqual("", testObject?.getCurrentWord())
    }
    
    func test_addCurrentWordToList_ListGivenToDelegate() {
        testObject?.addLetter("h")
        testObject?.addLetter("i")
        
        testObject?.addCurrentWordToList()
        
        XCTAssertEqual(["hi"], (testDelegate?.updatedWordList!)!)
    }
    
    func test_populateGrid_givesDelegateArrayOf16Letters() {
        testObject?.populateGrid()
        
        XCTAssertEqual(16, testDelegate?.populatedNewLettersToGrid?.count)
    }
}

class TestBoggleModelDelegate: BoggleModelProtocol {
    var populatedNewLettersToGrid: [String]?
    var updatedWordList: [String]?
    var currentWordHasChanged = false
    
    func populateNewLettersToGrid(_ letters: [String]) {
        populatedNewLettersToGrid = letters
    }
    
    func currentWordChanged() {
        currentWordHasChanged = true
    }
    
    func wordListUpdated(_ wordList: [String]) {
        updatedWordList = wordList
    }
}
