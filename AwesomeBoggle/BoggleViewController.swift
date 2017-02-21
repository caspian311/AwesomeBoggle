import UIKit

class BoggleViewController: UIViewController {
    let boggleView: BoggleView
    let boggleModel: BoggleModel
    
    init(boggleView: BoggleView = BoggleView(), boggleModel: BoggleModel = BoggleModel()) {
        self.boggleView = boggleView
        self.boggleModel = boggleModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = boggleView
        
        self.boggleView.delegate = self
        self.boggleModel.delegate = self
        
        self.boggleModel.populateGrid()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension BoggleViewController: BoggleModelProtocol {
    func populateNewLettersToGrid(_ letters: Array<String>) {
        self.boggleView.updateLetters(letters)
    }
    
    func currentWordChanged() {
        self.boggleView.setCurrentWord(boggleModel.getCurrentWord())
    }
    
    func wordListUpdated(_ wordList: [String]) {
        DispatchQueue.main.async {
            self.boggleModel.clearWord()
            self.boggleView.updateWordList(wordList)
        }
    }
}

extension BoggleViewController: BoggleViewProtocol {
    func resetGrid() {
        self.boggleModel.populateGrid()
        self.boggleModel.clearWordList()
        self.boggleModel.clearWord()
    }
    
    func letterSelected(_ letter: String?) {
        if let letter = letter {
            self.boggleModel.addLetter(letter)
        }
    }
    
    func submitWord() {
        self.boggleModel.addCurrentWordToList()
    }
}
