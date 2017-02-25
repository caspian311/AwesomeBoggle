import Foundation

protocol ResultsModelProtocol: class {
    func populateWordList(_ wordList: [BoggleWord])
    func populateScore(_ score: Int)
}

class ResultsModel {
    private var wordList: [BoggleWord] = []
    
    var delegate: ResultsModelProtocol?
    
    init(_ wordList: [String]) {
        self.wordList = wordList.map{ BoggleWord($0) }
    }
    
    func populate() {
        self.delegate?.populateWordList(self.wordList)
        self.delegate?.populateScore(aggregateScore())
    }
    
    private func aggregateScore() -> Int {
        return self.wordList.map { $0.score() }.reduce(0, +)
    }
}
