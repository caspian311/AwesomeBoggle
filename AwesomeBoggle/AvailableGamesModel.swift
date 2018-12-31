import Foundation
import UIKit

protocol AvailableGamesModelProtocol: class {
    func waitForOthersToJoin(_ invitations: [Invitation])
    func errorOcurred(_ errorMessage: ErrorMessage)
    func showNoUsersAreAvailable()
    func showGames(_ availableGames: [UserData])
}

class AvailableGamesModel {
    weak var delegate: AvailableGamesModelProtocol?
    
    private let gameService: GamesServiceProtocol
    private let dataLayer: DataLayerProtocol
    
    init(gameService: GamesServiceProtocol = GamesService(), dataLayer: DataLayerProtocol = DataLayer()) {
        self.gameService = gameService
        self.dataLayer = dataLayer
    }
    
    func fetchAvailableGames() {
        self.gameService.fetchAvailableGames { (errorOptional, availableUsers) in
            if let error = errorOptional {
                self.delegate!.errorOcurred(error)
                return
            }
            
            if (availableUsers!.count == 0) {
                self.delegate!.showNoUsersAreAvailable()
            } else {
                self.delegate!.showGames(availableUsers!)
            }
        }
    }
    
    func startGame(with opponentUserId: Int) {
        let userId = self.dataLayer.fetchUser()!.id
        
        self.gameService.startGame() {(errorOptional, gameOptional) in
            if let error = errorOptional {
                self.delegate!.errorOcurred(error)
                return
            }
            
            if let game = gameOptional {
                self.dataLayer.save(currentGame: game)
                
                self.gameService.inviteToGame(game.id, [userId, opponentUserId]) {(errorOptional, invitationsOptional) in
                    if let error = errorOptional {
                        self.delegate!.errorOcurred(error)
                        return
                    }
                    
                    if let invitations = invitationsOptional {
                        self.delegate!.waitForOthersToJoin(invitations)
                        return
                    }
                    
                    self.delegate!.errorOcurred(ErrorMessage(message: "Unknown error"))
                }
                return
            }
            
            self.delegate!.errorOcurred(ErrorMessage(message: "Unknown error"))
        }
    }
}
