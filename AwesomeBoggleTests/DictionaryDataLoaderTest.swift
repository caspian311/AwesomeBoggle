@testable import AwesomeBoggle
import XCTest

class DictionaryDataLoaderTest: XCTestCase {
    var testObject: DictionaryDataLoader!
    var testDataLayer: DataLayerProtocol!
    
    var temporaryFileURL: URL!
    
    override func setUp() {
        super.setUp()
        
        let temporaryDirectoryURL = URL(fileURLWithPath: NSTemporaryDirectory(), isDirectory: true)
        let temporaryFilename = ProcessInfo().globallyUniqueString

        temporaryFileURL = temporaryDirectoryURL.appendingPathComponent(temporaryFilename)
        let dataFile = temporaryFileURL.absoluteString
        
        testDataLayer = DataLayer(dataFile)
        
        testObject = DictionaryDataLoader(dataLayer: testDataLayer)
    }
    
    override func tearDown() {
        super.tearDown()
        
        try! FileManager.default.removeItem(at: temporaryFileURL)
    }
    
    func test_doing_stuff() {
        let expectation = XCTestExpectation(description: "preload the data")
        
        var errorOccurred = false
        var count = 0
        var initialized = 0
        var fetched = 0
        var loading = 0
        testObject.preloadData {status in
            count = count + 1
            switch status.status {
            case .Error:
                errorOccurred = true
            case .Initialized:
                initialized = count
            case .Fetched:
                fetched = count
            case.Loading:
                loading = count
            case.Done:
                expectation.fulfill()
            }
        }
        
        wait(for: [expectation], timeout: 30.0)
        
        XCTAssertFalse(errorOccurred)
        XCTAssertEqual(initialized, 0)
        XCTAssertEqual(fetched, 1)
        XCTAssertGreaterThan(loading, 400)
        
        XCTAssertEqual(415767, testDataLayer.fetchWordCount())
        
        [ "aardvark", "bad", "land", "monkey", "yourself", "zany" ].forEach { word in
            let dictWord = testDataLayer.fetchWordBy(text: word)
            XCTAssertEqual(word, dictWord?.text, "could not find \(word)")
        }
    }
}

