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
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.isHidden = true
        
        resetGrid()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }
}

extension BoggleViewController: BoggleModelProtocol {
    func populateNewLettersToGrid(_ letters: Array<String>) {
        self.boggleView.updateLetters(letters)
    }
    
    func currentWordChanged() {
        self.boggleView.setCurrentWord(boggleModel.getCurrentWord())
    }
    
    func updateSubmissionResultMessage(_ message: String) {
        DispatchQueue.main.async {
            self.boggleView.updateSubmitResults(message)
            self.boggleModel.clearWord()
            self.boggleView.enableInputs()
        }
    }
    
    func readyToReceiveWord(_ ready: Bool) {
        self.boggleView.readyToReceiveWord(ready)
    }
    
    func goToScoreBoard() {
        let resultsModel = ResultsModel(self.boggleModel.getWordList())
        self.navigationController?.pushViewController(ResultsViewController(resultsModel: resultsModel), animated: true)
    }
}

extension BoggleViewController: BoggleViewProtocol {
    func resetGrid() {
        self.boggleModel.populateGrid()
        self.boggleModel.clearWordList()
        self.boggleModel.clearWord()
        self.boggleView.updateSubmitResults("")
    }
    
    func letterSelected(_ letter: String?) {
        if let letter = letter {
            self.boggleModel.addLetter(letter)
        }
    }
    
    func submitWord() {
        self.boggleView.disableInputs()
        self.boggleModel.addCurrentWordToList()
    }
    
    func done() {
        self.boggleModel.saveGame()
    }
    
    func clearWord() {
        self.boggleModel.clearWord()
        self.boggleView.enableInputs()
    }
}
