import Foundation

class BaseService {
    let baseUrl: URL
    
    init() {
        baseUrl = URL(string: "http://localhost:8080/api/v1.0")!
    }
    
    func get<T:Decodable>(url: URL, callback: @escaping (ErrorMessage?, T?) -> ()) {
        var request = URLRequest(url: url)
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        makeCall(request, callback)
    }
    
    func get<T:Decodable>(url: URL, auth: String, callback: @escaping (ErrorMessage?, T?) -> ()) {
        var request = URLRequest(url: url)
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("Api-Key \(auth)", forHTTPHeaderField: "Authorization")
        
        makeCall(request, callback)
    }
    
    func post<T:Decodable>(url: URL, auth: String, requestData: [String:Any], callback: @escaping (ErrorMessage?, T?) -> ()) {
        let jsonData = try? JSONSerialization.data(withJSONObject: requestData)
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("Api-Key \(auth)", forHTTPHeaderField: "Authorization")
        request.httpBody = jsonData
        
        makeCall(request, callback)
    }
    
    func post<T:Decodable>(url: URL, requestData: [String:Any], callback: @escaping (ErrorMessage?, T?) -> ()) {
        let jsonData = try? JSONSerialization.data(withJSONObject: requestData)
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonData
        
        makeCall(request, callback)
    }

    private func makeCall<T:Decodable>(_ request: URLRequest, _ callback: @escaping (ErrorMessage?, T?) -> ()) {
        LogHelper.log(request: request)
        
        let task = URLSession.shared.dataTask(with: request) { (dataOptional, responseOptional, errorOptional) in
            let response = responseOptional as! HTTPURLResponse?
            LogHelper.log(data: dataOptional, response: response, error: errorOptional)
            
            if let error = errorOptional {
                callback(ErrorMessage(message: error.localizedDescription), nil)
            } else {
                var data: T?
                do {
                    if let jsonData = try JSONDecoder().decode(T?.self, from: dataOptional!) {
                        data = jsonData
                    }
                } catch let error {
                    callback(ErrorMessage(message: error.localizedDescription), nil)
                }
                
                callback(nil, data)
            }
        }
        task.resume()
    }
}
