import Foundation

class BaseService {
    let baseUrl: URL
    
    init() {
        baseUrl = URL(string: "http://localhost:8080/api/v1.0/")!
    }
    
    func makeCall(url: URL, callback: @escaping (ErrorMessage?, HttpResponse?) -> ()) {
        var request = URLRequest(url: url)
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let task = URLSession.shared.dataTask(with: request) { (dataOptional, responseOptional, errorOptional) in
            if let error = errorOptional {
                callback(ErrorMessage(message: error.localizedDescription), nil)
            } else if let httpResponse = responseOptional {
                let response = httpResponse as! HTTPURLResponse
                
                if let data = dataOptional {
                    do {
                        let serializedData = try JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                        
                        callback(nil, HttpResponse(status: response.statusCode, data: serializedData))
                    } catch let parsingError {
                        callback(ErrorMessage(message: parsingError.localizedDescription), HttpResponse(status: response.statusCode, data: [:]))
                    }
                } else {
                    callback(nil, HttpResponse(status: response.statusCode, data: [:]))
                }
            } else {
                callback(ErrorMessage(message: "Unknown error"), nil)
            }
        }
        task.resume()
    }
}
