import Foundation

protocol ResultsModelProtocol: class {
    func populateWordList(_ wordList: [BoggleWord])
    func populateScore(_ score: Int)
    func showSentence(_ sentence: String)
    func showError()
}

class ResultsModel {
    private var wordList: [BoggleWord] = []
    private let dictionaryService: DictionaryServiceProtocol
    
    var delegate: ResultsModelProtocol?
    
    init(_ wordList: [String], dictionaryService: DictionaryServiceProtocol = DictionaryService()) {
        self.dictionaryService = dictionaryService
        self.wordList = wordList.map{ BoggleWord($0) }
    }
    
    func populate() {
        self.delegate?.populateWordList(self.wordList)
        self.delegate?.populateScore(aggregateScore())
    }
    
    private func aggregateScore() -> Int {
        return self.wordList.map { $0.score() }.reduce(0, +)
    }
    
    func fetchExampleFor(word: String) {
        self.dictionaryService.getSentenceFor(word: word) { (isValid, sentence) in
            if isValid {
                self.delegate?.showSentence(sentence)
            } else {
                self.delegate?.showError()
            }
        }
    }
}
