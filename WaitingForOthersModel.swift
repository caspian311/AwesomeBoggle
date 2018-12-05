import Foundation

protocol WaitingForOthersModelProtocol: class {
    func errorOccurred(_ errorMessage: String)
}

class WaitingForOthersModel {
    weak var delegate: WaitingForOthersModelProtocol?
    
    private let coreDataManager: CoreDataManagerProtocol
    private let gamesService: GamesServiceProtocol
    
    private var haveAllPlayersJoined: Bool
    private var errorOccurred: Bool
    
    init(coreDataManager: CoreDataManagerProtocol = CoreDataManager(), gamesService: GamesServiceProtocol = GamesService()) {
        self.coreDataManager = coreDataManager
        self.gamesService = gamesService
        
        self.haveAllPlayersJoined = false
        self.errorOccurred = false
    }
    
    func waitForOthers() {
        let currentGame = self.coreDataManager.fetchCurrentGame()!
        self.gamesService.readyToPlay(currentGame.id) { (errorOptional) in
            if let error = errorOptional {
                self.errorOccurred = true
                self.delegate!.errorOccurred(error.message)
            }
        }
        
        Timer.scheduledTimer(withTimeInterval: 2.0, repeats: true) { timer in
            if self.haveAllPlayersJoined || self.errorOccurred {
                timer.invalidate()
            }
            
            self.gamesService.isGameReady(currentGame.id) {(errorOptional: ErrorMessage?, isReady: Bool?) in
                if let error = errorOptional {
                    self.errorOccurred = true
                    self.delegate!.errorOccurred(error.message)
                }
                self.haveAllPlayersJoined = isReady!
            }
        }
    }
}
