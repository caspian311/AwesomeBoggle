import Foundation
import UIKit

protocol RegistrationServiceProtocol: class {
    func checkAvailability(username: String, callback: @escaping (ErrorMessage?, Bool) -> ())
    func register(username: String, callback: @escaping (ErrorMessage?, UserData?) -> ())
}

class RegistrationService: BaseService, RegistrationServiceProtocol {
    func checkAvailability(username: String, callback: @escaping (ErrorMessage?, Bool) -> ()) {
        let url = self.baseUrl.appendingPathComponent("/users/\(username.lowercased())")
        
        self.get(url: url) { (errorOptional, dataOptional) in
            if let error = errorOptional {
                if error.status == 409 {
                    callback(nil, false)
                    return
                }
                
                callback(ErrorMessage(message: error.message), false)
                return
            }
            
            callback(nil, true)
        }
    }
    
    func register(username: String, callback: @escaping (ErrorMessage?, UserData?) -> ()) {
        let url = baseUrl.appendingPathComponent("/users")
        let requestData: [String : Any] = ["username": username.lowercased()]
        
        self.post(url: url, requestData: requestData) { (errorOptional, userOptional) in
            if let error = errorOptional {
                callback(error, nil)
                return
            }
            
            let userData = userOptional as! [String:Any]
            let user = UserData(id: userData["id"] as! Int, username: userData["username"] as! String, authToken: userData["authToken"] as? String)
            callback(nil, user)
        }
    }
}
