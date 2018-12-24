import Foundation
import UIKit

protocol WaitingForOthersModelProtocol: class {
    func errorOccurred(_ errorMessage: String)
}

class WaitingForOthersModel {
    weak var delegate: WaitingForOthersModelProtocol?
    
    private let dataLayer: DataLayerProtocol
    private let gamesService: GamesServiceProtocol
    
    private var haveAllPlayersJoined: Bool
    private var errorOccurred: Bool
    
    init(dataLayer: DataLayerProtocol = DataLayer(), gamesService: GamesServiceProtocol = GamesService()) {
        self.dataLayer = dataLayer
        self.gamesService = gamesService
        
        self.haveAllPlayersJoined = false
        self.errorOccurred = false
    }

    func joinGame() {
        let currentGame = self.dataLayer.fetchCurrentGame()!
        
        self.gamesService.joinGame(currentGame.id) { (errorOptional) in
            if let error = errorOptional {
                self.errorOccurred = true
                self.delegate!.errorOccurred(error.message)
            }
        }
    }
    
    func waitForOthers() {
        let currentGame = self.dataLayer.fetchCurrentGame()!
        
        Timer.scheduledTimer(withTimeInterval: 2.0, repeats: true) { timer in
            if self.haveAllPlayersJoined || self.errorOccurred {
                timer.invalidate()
            }
            
            self.gamesService.isGameReady(currentGame.id) {(errorOptional, isReady: Bool?) in
                if let error = errorOptional {
                    self.errorOccurred = true
                    self.delegate!.errorOccurred(error.message)
                }
                self.haveAllPlayersJoined = isReady!
            }
        }
    }
}
