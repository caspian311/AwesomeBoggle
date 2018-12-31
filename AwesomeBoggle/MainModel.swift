import Foundation
import UIKit

protocol MainModelProtocol: class {
    func startGame()
    func showGameHistory()
    func showRegistration()
}

class MainModel {
    weak var delegate: MainModelProtocol?
    let dataLayer: DataLayerProtocol
    
    init(dataLayer: DataLayerProtocol = DataLayer()) {
        self.dataLayer = dataLayer
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
    
    func registrationCheck(_ callback: (Bool) -> ()) {
        let userOptional = self.dataLayer.fetchUser()
        
        if userOptional != nil {
            callback(true)
        } else {
            callback(false)
        }
    }
}
