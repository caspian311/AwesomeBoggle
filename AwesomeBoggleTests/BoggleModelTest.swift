@testable import AwesomeBoggle
import XCTest

class BoggleModelTest: XCTestCase {
    var testObject: BoggleModel!
    var testDelegate: TestBoggleModelDelegate!
    var testDictionaryService: TestDictionaryService!
    
    override func setUp() {
        super.setUp()
        
        testDelegate = TestBoggleModelDelegate()
        testDictionaryService = TestDictionaryService()
        
        testObject = BoggleModel(dictionaryService: testDictionaryService)
        testObject.delegate = testDelegate
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func test_addLetter_AddsTheLetter() {
        testObject.addLetter("h")
        
        XCTAssertEqual("h", testObject.getCurrentWord())
    }
    
    func test_addLetter_AddsTheNextLetterToTheCurrentWord() {
        testObject.addLetter("h")
        testObject.addLetter("i")
        
        XCTAssertEqual("hi", testObject.getCurrentWord())
    }
    
    func test_clearWord_RetrievesTheCurrentWord() {
        testObject.addLetter("h")
        testObject.addLetter("i")
        
        testObject.clearWord()
        
        XCTAssertEqual("", testObject.getCurrentWord())
    }
    
    func test_addCurrentWordToList_ListGivenToDelegate() {
        testObject.addLetter("h")
        testObject.addLetter("i")
        
        testObject.addCurrentWordToList()
        testDictionaryService.callback!(true, 2)
        
        XCTAssertEqual(["hi"], (testDelegate?.updatedWordList)!)
    }
    
    func test_addCurrentWordToList_WhenNotAWord_NoListGivenToDelegate() {
        testObject.addLetter("h")
        testObject.addLetter("i")
        
        testObject.addCurrentWordToList()
        testDictionaryService.callback!(false, 2)
        
        XCTAssertEqual([], (testDelegate?.updatedWordList)!)
    }
    
    func test_addCurrentWordToList_whenThereIsNoCurrentWord_emptyListGivenToDelegate() {
        testObject.addCurrentWordToList()
        
        XCTAssertEqual(0, (testDelegate?.updatedWordList.count))
    }
    
    func test_populateGrid_givesDelegateArrayOf16Letters() {
        testObject.populateGrid()
        
        XCTAssertEqual(16, testDelegate?.populatedNewLettersToGrid.count)
    }
}

class TestDictionaryService: DictionaryServiceProtocol {
    var wordToBeChecked: String?
    var checkValidityCalled = false
    var callback: ((Bool, Int?) -> ())?
    
    func checkValidityOf(word: String, callback: @escaping (Bool, Int?) -> ()) {
        wordToBeChecked = word
        checkValidityCalled = true
        self.callback = callback
    }
}

class TestBoggleModelDelegate: BoggleModelProtocol {
    var populatedNewLettersToGrid = [String]()
    var updatedWordList = [String]()
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
