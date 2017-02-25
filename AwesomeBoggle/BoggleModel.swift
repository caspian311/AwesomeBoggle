import Foundation

protocol BoggleModelProtocol: class {
    func populateNewLettersToGrid(_ letters: Array<String>)
    func currentWordChanged()
    func updateSubmissionResultMessage(_ message: String)
}

class BoggleModel {
    private var currentWord = ""
    private var submittedWords = [String]()
    
    weak var delegate: BoggleModelProtocol?
    
    private let dictionaryService: DictionaryServiceProtocol
    
    init(dictionaryService: DictionaryServiceProtocol = DictionaryService()) {
        self.dictionaryService = dictionaryService
    }
    
    func populateGrid() {
        var letters = [String]()
        for _ in 0...15 {
            letters += [getRandomString()]
        }
            
        self.delegate?.populateNewLettersToGrid(letters)
    }
    
    func addLetter(_ letter: String) {
        self.currentWord.append(letter)
        self.delegate?.currentWordChanged()
    }
    
    func getCurrentWord() -> String {
        return self.currentWord
    }
    
    func clearWordList() {
        self.submittedWords = []
    }
    
    func getWordList() -> [String] {
        return self.submittedWords
    }
    
    func addCurrentWordToList() {
        if (!self.currentWord.isEmpty) {
            self.dictionaryService.checkValidityOf(word: self.currentWord) { (isValid, score) in
                let message: String
                if isValid {
                    self.submittedWords.append(self.currentWord)
                    message = self.createSuccessMessage()
                } else {
                    message = self.createFailureMessage()
                }
                self.self.delegate?.updateSubmissionResultMessage(message)
            }
        }
    }
    
    func clearWord() {
        self.currentWord = ""
        self.delegate?.currentWordChanged()
    }
    
    private func createSuccessMessage() -> String {
        return "\(self.currentWord) is worth \(self.currentWord.characters.count) points!"
    }
    
    private func createFailureMessage() -> String {
        return "No, \(self.currentWord) is not a word."
    }
    
    private func getRandomString() -> String {
        let letters = Array("ABCDEFGHIJKLMNOPQRSTUVWXYZ".characters)
        let random_int = Int(arc4random_uniform(26))
        return String(letters[random_int])
    }
}
