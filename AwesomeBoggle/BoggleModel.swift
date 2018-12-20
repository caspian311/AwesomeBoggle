import Foundation
import UIKit

protocol BoggleModelProtocol: class {
    func populateNewLettersToGrid(_ letters: Array<String>)
    func currentWordChanged()
    func updateSubmissionResultMessage(_ message: String)
    func readyToReceiveWord(_ ready: Bool)
    func goToScoreBoard()
    func startTimer()
}

class BoggleModel {
    private var currentWord = ""
    private var submittedWords = [String]()
    private var timeRemaining = 60
    
    weak var delegate: BoggleModelProtocol?
    
    private let coreDataManager: CoreDataManagerProtocol
    private let dictionaryService: DictionaryServiceProtocol
    private var currentGame: BoggleGame?
    
    init(dictionaryService: DictionaryServiceProtocol = DictionaryService(),
         coreDataManager: CoreDataManager = CoreDataManager(UIApplication.shared.delegate! as! AppDelegate)) {
        self.dictionaryService = dictionaryService
        self.coreDataManager = coreDataManager
    }
    
    func populateGrid() {
        let grid = self.coreDataManager.fetchCurrentGame()!.grid
        let letters = Array(grid).map(String.init)
        self.delegate?.populateNewLettersToGrid(letters)
        updateReadyToReceive()
    }
    
    func addLetter(_ letter: String) {
        self.currentWord.append(letter)
        self.delegate?.currentWordChanged()
        updateReadyToReceive()
    }
    
    private func updateReadyToReceive() {
        let longEnough = self.currentWord.count > 1
        let isOriginalWord = !self.submittedWords.contains(self.currentWord)
        self.delegate?.readyToReceiveWord(longEnough && isOriginalWord)
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
    
    func clearWord() {
        self.currentWord = ""
        updateReadyToReceive()
        self.delegate?.currentWordChanged()
    }
    
    func saveGame() {
        let game = BoggleGame(
            id: UUID.init().uuidString,
            date: Date(),
            score: self.submittedWords.map{ $0.count }.reduce(0, { $0 + $1 }))
        
        self.coreDataManager.save(game: game)
        
        self.delegate?.goToScoreBoard()
    }
    
    func isGameOver() -> Bool {
        return self.timeRemaining == 0
    }
    
    func getTimeRemaining() -> String {
        self.timeRemaining -= 1
        
        return String(self.timeRemaining)
    }
    
    private func createSuccessMessage() -> String {
        return "\(self.currentWord) is worth \(self.currentWord.count) points!"
    }
    
    private func createFailureMessage() -> String {
        return "No, \(self.currentWord) is not a word."
    }
    
    private func getRandomString() -> String {
        let letters = Array("ABCDEFGHIJKLMNOPQRSTUVWXYZ")
        let random_int = Int(arc4random_uniform(26))
        return String(letters[random_int])
    }
}
