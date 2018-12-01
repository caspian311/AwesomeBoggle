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
