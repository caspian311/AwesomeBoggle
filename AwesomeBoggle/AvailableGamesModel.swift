import Foundation

protocol AvailableGamesModelProtocol: class {
    func play()
    func errorOcurred(_ errorMessage: ErrorMessage)
    func showNoUsersAreAvailable()
    func showGames(_ availableGames: [UserData])
}

class AvailableGamesModel {
    weak var delegate: AvailableGamesModelProtocol?
    
    let gameService: GamesServiceProtocol
    
    init(gameService: GamesServiceProtocol = GamesService()) {
        self.gameService = gameService
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
}
