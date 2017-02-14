import XCTest

class AwesomeBoggleUITests: XCTestCase {
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        XCUIApplication().launch()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func test_addingAWord() {
        let app = XCUIApplication()
        
        let buttonPredicate = NSPredicate(format: "label.length == 1")
        let buttons = app.buttons.matching(buttonPredicate)
        XCTAssertEqual(buttons.count, 16)
        
        let firstButton = buttons.element(boundBy: 2)
        let firstLetter = firstButton.label
        
        firstButton.tap()
        
        let currentWordField = app.staticTexts.element(boundBy: 0)
        
        XCTAssertEqual(currentWordField.label, firstLetter)
        
        app.buttons["Enter"].tap()
        
        XCTAssertEqual(currentWordField.label, "")
        
        XCTAssertEqual(app.tables.staticTexts.element(boundBy: 0).label, firstLetter)
    }
}
