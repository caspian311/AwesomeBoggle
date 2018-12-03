import Foundation

protocol AvailableGamesModelProtocol: class {
    func gameStarted(_ game: GameData)
    func errorOcurred(_ errorMessage: ErrorMessage)
    func showNoUsersAreAvailable()
    func showGames(_ availableGames: [UserData])
}

class AvailableGamesModel {
    weak var delegate: AvailableGamesModelProtocol?
    
    private let gameService: GamesServiceProtocol
    private let coreDataManager: CoreDataManagerProtocol
    
    init(gameService: GamesServiceProtocol = GamesService(), coreDataManager: CoreDataManagerProtocol = CoreDataManager()) {
        self.gameService = gameService
        self.coreDataManager = coreDataManager
    }
    
    func fetchAvailableGames() {
        self.gameService.fetchAvailableGames { (errorOptional, availableUsersOptional) in
            if let error = errorOptional {
                self.delegate!.errorOcurred(error)
            } else if let availableGames = availableUsersOptional {
                if (availableGames.count == 0) {
                    self.delegate!.showNoUsersAreAvailable()
                } else {
                    self.delegate!.showGames(availableGames)
                }
            } else {
                self.delegate!.errorOcurred(ErrorMessage(message: "Unknown error"))
            }
        }
    }
    
    func startGame(with opponentUserId: Int) {
        let userId = self.coreDataManager.fetchUser()!.id
        
        self.gameService.joinGame([userId, opponentUserId]) {(errorOptional, gameOptional) in
            if let error = errorOptional {
                self.delegate!.errorOcurred(error)
            } else if let game = gameOptional {
                self.delegate!.gameStarted(game)
            } else {
                self.delegate!.errorOcurred(ErrorMessage(message: "Unknown error"))
            }
        }
    }
}
