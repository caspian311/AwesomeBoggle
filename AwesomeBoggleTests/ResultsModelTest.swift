@testable import AwesomeBoggle
import XCTest

class ResultsModelTest: XCTestCase {
    var testDelegate: TestResultsModelDelegate!
    var wordList: [String] = []
    
    func createTestObject() -> ResultsModel {
        super.setUp()
        
        self.testDelegate = TestResultsModelDelegate()
        
        let testObject = ResultsModel(wordList)
        testObject.delegate = testDelegate
        return testObject
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func test_populate_populatesScore() {
        self.wordList += ["1", "to", "333"]
        let testObject = createTestObject()
        
        testObject.populate()
        
        XCTAssertEqual(6, self.testDelegate!.populatedScore)
    }
    
    
    func test_populate_populatesWordList() {
        self.wordList += ["first", "second", "third"]
        let testObject = createTestObject()
        
        testObject.populate()
        
        XCTAssertEqual(self.wordList, self.testDelegate!.populatedWordList.map { $0.text() })
    }
}

class TestResultsModelDelegate: ResultsModelProtocol {
    var populatedWordList: [BoggleWord] = []
    var populatedScore: Int = 0
    
    func populateWordList(_ wordList: [BoggleWord]) {
        self.populatedWordList = wordList
    }
    
    func populateScore(_ score: Int) {
        self.populatedScore = score
    }
}
