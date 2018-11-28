import Foundation

protocol RegisterModelProtocol: class {
    func done()
    func usernameAvailable()
    func usernameIsTaken()
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
        self.delegate?.done()
    }
    
    func checkUsername() {
        self.registrationService.checkAvailability(username: self.username) { (isAvailable) in
            if (isAvailable) {
                self.delegate?.usernameAvailable()
            } else {
                self.delegate?.usernameIsTaken()
            }
        }
    }

    func register() {
        self.delegate?.done()
    }
}
