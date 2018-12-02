import Foundation

protocol AvailableGamesModelProtocol: class {
    func play()
}


class AvailableGamesModel {
    weak var delegate: AvailableGamesModelProtocol?
    
    func fetchAvailableGames() {
        
    }
}
