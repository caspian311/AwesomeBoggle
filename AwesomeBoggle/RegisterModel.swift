import Foundation

protocol RegisterModelProtocol: class {
    func done(_ user: UserData)
    func cancel()
    func usernameAvailable()
    func usernameIsTaken()
    func showErrorMessage(_ errorMessage: String)
}

class RegisterModel {
    weak var delegate: RegisterModelProtocol?
    private var username = ""
    private let registrationService: RegistrationServiceProtocol
    
    init(registrationService: RegistrationServiceProtocol = RegistrationService()) {
        self.registrationService = registrationService
    }
    
    func setUsername(_ username: String) {
        self.username = username
    }
    
    func cancel() {
        self.delegate?.cancel()
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
            if let error = errorOptional {
                self.delegate?.showErrorMessage(error.message)
                return
            }
            
            if let user = userOptional {
                print("user has been registered: \(user)")
                self.delegate?.done(user)
            } else {
                self.delegate?.showErrorMessage("No error reported and no user returned")
            }
        }
    }
}
