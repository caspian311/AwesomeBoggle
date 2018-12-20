import Foundation
import UIKit

protocol MainModelProtocol: class {
    func startGame()
    func showGameHistory()
    func showRegistration()
}

class MainModel {
    weak var delegate: MainModelProtocol?
    let coreDataManager: CoreDataManager
    
    init(coreDataManager: CoreDataManager = CoreDataManager(UIApplication.shared.delegate! as! AppDelegate)) {
        self.coreDataManager = coreDataManager
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
        let userOptional = coreDataManager.fetchUser()
        
        if userOptional != nil {
            callback(true)
        } else {
            callback(false)
        }
    }
}
