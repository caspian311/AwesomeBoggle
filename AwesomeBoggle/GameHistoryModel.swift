import Foundation
import UIKit

protocol GameHistoryModelProtocol: class {
    func showGameList(_ gameList: [GameHistoryEntry])
    func showError(_ error: ErrorMessage)
    func navigateToMain()
}

class GameHistoryModel {
    weak var delegate: GameHistoryModelProtocol?
    
    private let gameService: GamesServiceProtocol
    
    init(gameService: GamesServiceProtocol = GamesService()) {
        self.gameService = gameService
    }
    
    func populate() {
        self.gameService.fetchGameHistory{ (errorOptional, gameHistoryOptional) in
            if let error = errorOptional {
                self.delegate?.showError(error)
                return
            }
            
            let gameHistory = gameHistoryOptional!
            self.delegate?.showGameList(gameHistory)
        }
    }
    
    func goToMainView() {
        self.delegate?.navigateToMain()
    }
}

class GameHistoryEntry {
    let date: String
    let score: Int
    
    init(score: Int, date: String) {
        self.date = date
        self.score = score
    }
}
