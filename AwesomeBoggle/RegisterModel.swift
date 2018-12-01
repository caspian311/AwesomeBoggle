import Foundation

protocol RegisterModelProtocol: class {
    func done()
    func usernameAvailable()
    func usernameIsTaken()
    func showErrorMessage(_ errorMessage: String)
}

class RegisterModel {
    let coreDataManager: CoreDataManagerProtocol
    
    weak var delegate: RegisterModelProtocol?
    private var username = ""
    private let registrationService: RegistrationServiceProtocol
    
    init(registrationService: RegistrationServiceProtocol = RegistrationService(), coreDataManager: CoreDataManagerProtocol = CoreDataManager()) {
        self.registrationService = registrationService
        self.coreDataManager = coreDataManager
    }
    
    func setUsername(_ username: String) {
        self.username = username
    }
    
    func cancel() {
        self.delegate?.done()
    }
    
    func checkUsername() {
        self.registrationService.checkAvailability(username: self.username) { (errorOptional, isAvailable) in
            if let error = errorOptional {
                self.delegate?.showErrorMessage(error.message)
            } else {
                if (isAvailable) {
                    self.delegate?.usernameAvailable()
                } else {
                    self.delegate?.usernameIsTaken()
                }
            }
        }
    }

    func register() {
        self.registrationService.register(username: self.username) { (errorOptional, userOptional) in
            if let user = userOptional {
                self.coreDataManager.save(user: user)
                self.delegate?.done()
            } else if let error = errorOptional {
                self.delegate?.showErrorMessage(error.message)
            }
        }
    }
}
