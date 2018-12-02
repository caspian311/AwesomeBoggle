import Foundation

class BaseService {
    let baseUrl: URL
    
    init() {
        baseUrl = URL(string: "http://localhost:8080/api/v1.0/")!
    }
    
    func get(url: URL, callback: @escaping (ErrorMessage?, HttpResponse?) -> ()) {
        var request = URLRequest(url: url)
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let task = URLSession.shared.dataTask(with: request) { (dataOptional, responseOptional, errorOptional) in
            if let error = errorOptional {
                callback(ErrorMessage(message: error.localizedDescription), nil)
            } else {
                do {
                    let response = responseOptional as! HTTPURLResponse
                    let serializedData = try JSONSerialization.jsonObject(with: dataOptional!, options: []) as! [String: Any]
                    
                    callback(nil, HttpResponse(status: response.statusCode, data: serializedData))
                } catch let parsingError {
                    print("Parsing error: \(parsingError.localizedDescription)")
                    callback(ErrorMessage(message: parsingError.localizedDescription), nil)
                }
            }
        }
        task.resume()
    }
    
    func post(url: URL, requestData: [String:Any], callback: @escaping (ErrorMessage?, HttpResponse?) -> ()) {
        let jsonData = try? JSONSerialization.data(withJSONObject: requestData)
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonData
        
        let task = URLSession.shared.dataTask(with: request) { (dataOptional, responseOptional, errorOptional) in
            if let error = errorOptional {
                callback(ErrorMessage(message: error.localizedDescription), nil)
            } else {
                do {
                    let response = responseOptional as! HTTPURLResponse
                    let serializedData = try JSONSerialization.jsonObject(with: dataOptional!, options: []) as! [String: Any]
                    
                    callback(nil, HttpResponse(status: response.statusCode, data: serializedData))
                } catch let parsingError {
                    print("Parsing error: \(parsingError.localizedDescription)")
                    callback(ErrorMessage(message: parsingError.localizedDescription), nil)
                }
            }
        }
        task.resume()
    }

}
