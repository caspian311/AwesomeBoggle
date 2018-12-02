import Foundation
import UIKit

protocol AvailableGamesViewProtocol: class {
    func startGame(_ gameId: Int)
}

class AvailableGamesView: GradientView {
    weak var delegate: AvailableGamesViewProtocol?
    
    init() {
        super.init(frame: CGRect.zero)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func showError(_ error: String) {
        print("Error: \(error)")
    }
    
    func populateAvailableGames(_ games: [UserData]) {
        print("Error: \(games)")
    }
    
    func showNoUsersAreAvailable() {
        print("No users are available")
    }
    
    @objc private func chooseGame(_ gameId: Int) {
        self.delegate!.startGame(gameId)
    }
}
