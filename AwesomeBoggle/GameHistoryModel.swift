import Foundation
import UIKit

protocol GameHistoryModelProtocol: class {
    func showGameList(_ gameList: [GameHistoryEntry])
    func showError(_ error: ErrorMessage)
    func goBack()
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
        self.delegate?.goBack()
    }
}

class GameHistoryEntry {
    let gameResult: Bool
    let gameTime: String
    let scores: String
    
    init(gameResult: Bool, gameTime: String, scores: String) {
        self.gameResult = gameResult
        self.gameTime = gameTime
        self.scores = scores
    }
}
