import Foundation

protocol MainModelProtocol: class {
    func startGame()
    func showGameHistory()
    func showRegistration()
}

class MainModel {
    weak var delegate: MainModelProtocol?
    
    init() {
    }
    
    func startGame() {
        self.delegate?.startGame()
    }
    
    func showGameHistory() {
        self.delegate?.showGameHistory()
    }
    
    func registerButton() {
        self.delegate?.showRegistration()
    }
}
