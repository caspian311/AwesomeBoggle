import Foundation
import UIKit

protocol RegistrationServiceProtocol: class {
    func checkAvailability(username: String, callback: @escaping (ErrorMessage?, Bool) -> ())
    func register(username: String, callback: @escaping (ErrorMessage?, UserData?) -> ())
}

class RegistrationService: BaseService, RegistrationServiceProtocol {
    func checkAvailability(username: String, callback: @escaping (ErrorMessage?, Bool) -> ()) {
        let url = self.baseUrl.appendingPathComponent("users/\(username.lowercased())")
        
        self.makeCall(url: url) { (errorOptional, responseOptional) in
            if let error = errorOptional {
                callback(ErrorMessage(message: error.message), false)
            } else if let response = responseOptional {
                if response.status == 200 {
                    callback(nil, true)
                } else {
                    callback(nil, false)
                }
            }
        }
    }
    
    func register(username: String, callback: @escaping (ErrorMessage?, UserData?) -> ()) {
        let url = baseUrl.appendingPathComponent("users/\(username.lowercased())")
        
        self.makeCall(url: url) { (errorOptional, responseOptional) in
            if let error = errorOptional {
                callback(error, nil)
            } else if let response = responseOptional {
                if response.status == 200 {
                    let user = UserData(id: response.data["id"] as! Int,
                                        username: response.data["username"] as! String,
                                        authToken: response.data["authToken"] as! String,
                                        createdDate: response.data["createdDate"] as! Date)
                    
                    callback(nil, user)
                } else {
                    callback(ErrorMessage(message: response.data["message"] as! String), nil)
                }
            }
        }
    }
}
