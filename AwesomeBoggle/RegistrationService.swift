import Foundation
import UIKit

protocol RegistrationServiceProtocol: class {
    func checkAvailability(username: String, callback: @escaping (ErrorMessage?, Bool) -> ())
    func register(username: String, callback: @escaping (ErrorMessage?, UserData?) -> ())
}

class RegistrationService: BaseService, RegistrationServiceProtocol {
    func checkAvailability(username: String, callback: @escaping (ErrorMessage?, Bool) -> ()) {
        let url = self.baseUrl.appendingPathComponent("/users/\(username.lowercased())")
        
        self.get(url: url) { (errorOptional, dataOptional: CheckAvailabilityData?) in
            if let error = errorOptional {
                callback(ErrorMessage(message: error.message), false)
            } else if let data = dataOptional {
                callback(nil, data.isAvailable)
            }
        }
    }
    
    func register(username: String, callback: @escaping (ErrorMessage?, UserData?) -> ()) {
        let url = baseUrl.appendingPathComponent("/users")
        let requestData: [String : Any] = ["username": username.lowercased()]
        
        self.post(url: url, requestData: requestData) { (errorOptional, userOptional: UserData?) in
            if let error = errorOptional {
                callback(error, nil)
            } else if let user = userOptional {
                callback(nil, user)
            }
        }
    }
}
