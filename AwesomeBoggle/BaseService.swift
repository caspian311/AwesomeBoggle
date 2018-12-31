import Foundation
import Alamofire

class BaseService {
    let baseUrl: URL
    private let queue: DispatchQueue
    
    init() {
        baseUrl = URL(string: "http://localhost:8080/api/v1.0")!
        queue = DispatchQueue(label: "net.todd.AwesomeBoggle.response-queue", qos: .utility, attributes: [.concurrent])
    }
    
    func get(url: URL, callback: @escaping (HttpErrorMessage?, Any?) -> ()) {
        let headers = ["Accept": "application/json"]
        Alamofire.request(url, encoding: JSONEncoding.default, headers: headers)
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .responseJSON(queue: queue) { response in
                switch response.result {
                case .success:
                    callback(nil, response.result.value)
                case .failure(let error):
                    callback(HttpErrorMessage(status: response.response?.statusCode, message: error.localizedDescription), nil)
                }
        }
    }
    
    func get(url: URL, auth: String, callback: @escaping (ErrorMessage?, Any?) -> ()) {
        let headers = [
            "Accept": "application/json",
            "Authorization": "Api-Key \(auth)"
        ]
        Alamofire.request(url, encoding: JSONEncoding.default, headers: headers)
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .responseJSON(queue: queue) { response in
                switch response.result {
                case .success:
                    callback(nil, response.result.value)
                case .failure(let error):
                    callback(ErrorMessage(message: error.localizedDescription), nil)
                }
        }
    }
    
    func post(url: URL,requestData: Parameters?, callback: @escaping (ErrorMessage?, Any?) -> ()) {
        let headers = [
            "Accept": "application/json",
        ]
        let parameters = requestData
        Alamofire.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .responseJSON(queue: queue) { response in
                switch response.result {
                case .success:
                    callback(nil, response.result.value)
                case .failure(let error):
                    callback(ErrorMessage(message: error.localizedDescription), nil)
                }
        }
    }
    
    func post(url: URL, auth: String, requestData: Parameters?, callback: @escaping (ErrorMessage?, Any?) -> ()) {
        let headers = [
            "Accept": "application/json",
            "Authorization": "Api-Key \(auth)"
        ]
        let parameters = requestData
        Alamofire.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .responseJSON(queue: queue) { response in
                switch response.result {
                case .success:
                    callback(nil, response.result.value)
                case .failure(let error):
                    callback(ErrorMessage(message: error.localizedDescription), nil)
                }
        }
    }
    
    func put(url: URL, auth: String, requestData: Parameters?, callback: @escaping (ErrorMessage?, Any?) -> ()) {
        let headers = [
            "Accept": "application/json",
            "Authorization": "Api-Key \(auth)"
        ]
        let parameters = requestData
        Alamofire.request(url, method: .put, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .responseJSON(queue: queue) { response in
                switch response.result {
                case .success:
                    callback(nil, response.result.value)
                case .failure(let error):
                    callback(ErrorMessage(message: error.localizedDescription), nil)
                }
        }
    }
}
