import Foundation
import UIKit

protocol RegistrationServiceProtocol: class {
    func checkAvailability(username: String, callback: @escaping (ErrorMessage?, Bool) -> ())
    func register(username: String, callback: @escaping (ErrorMessage?, UserData?) -> ())
}

class RegistrationService: BaseService, RegistrationServiceProtocol {
    func checkAvailability(username: String, callback: @escaping (ErrorMessage?, Bool) -> ()) {
        let url = self.baseUrl.appendingPathComponent("users/\(username.lowercased())")
        
        self.get(url: url) { (errorOptional, responseOptional) in
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
        let url = baseUrl.appendingPathComponent("users")
        let requestData: [String : Any] = ["username": username.lowercased()]
        
        self.post(url: url, requestData: requestData) { (errorOptional, responseOptional) in
            if let error = errorOptional {
                callback(error, nil)
            } else if let response = responseOptional {
                if response.status == 200 {
                    let user = UserData(id: response.data["userId"] as! Int,
                                        username: response.data["username"] as! String,
                                        authToken: response.data["authToken"] as! String)
                    
                    callback(nil, user)
                } else {
                    callback(ErrorMessage(message: response.data["message"] as! String), nil)
                }
            }
        }
    }
}
