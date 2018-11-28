import Foundation
import UIKit

protocol RegistrationServiceProtocol: class {
    func checkAvailability(username: String, callback: @escaping (Bool) -> ())
}

class RegistrationService: RegistrationServiceProtocol {
    let baseUrl: URL
    
    init() {
        baseUrl = URL(string: "http://localhost:8080/api/v1.0/")!
    }
    
    func checkAvailability(username: String, callback: @escaping (Bool) -> ()) {
        let url = baseUrl.appendingPathComponent("users/\(username.lowercased())")
        
        makeCall(url: url) { (response, data) in
            if response.statusCode == 200 {
                callback(true)
            } else {
                callback(false)
            }
        }
    }
    
    private func makeCall(url: URL, callback: @escaping (HTTPURLResponse, Data?) -> ()) {
        var request = URLRequest(url: url)
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let session = URLSession.shared
        
        let task = session.dataTask(with: request) { (dataOptional, responseOptional, errorOptional) in
            if let error = errorOptional {
                print("error \(error.localizedDescription)")
            } else if let httpResponse = responseOptional {
                callback(httpResponse as! HTTPURLResponse, dataOptional)
            }
            
            
        }
        task.resume()
    }

}
