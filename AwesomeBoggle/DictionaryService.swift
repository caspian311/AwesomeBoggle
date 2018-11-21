import Foundation
import UIKit

protocol DictionaryServiceProtocol: class {
    func checkValidityOf(word: String, callback: @escaping (Bool, Int?) -> ())
}

class DictionaryService: DictionaryServiceProtocol {
    let appID = "72562bc6"
    let appKey = "1ca3b176a71b51ecb6bf5efdbf545bcf"
    let language = "en"
    let baseUrl: URL
    
    init() {
        baseUrl = URL(string: "https://od-api.oxforddictionaries.com:443/api/v1/entries/\(language)/")!
    }
    
    func checkValidityOf(word: String, callback: @escaping (Bool, Int?) -> ()) {
        let url = baseUrl.appendingPathComponent(word.lowercased())
        
        makeCall(url: url) { (response, data) in
            if response.statusCode == 200 {
                callback(true, word.count)
            } else {
                callback(false, 0)
            }
        }
    }
    
    private func makeCall(url: URL, callback: @escaping (HTTPURLResponse, Data?) -> ()) {
        var request = URLRequest(url: url)
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue(appID, forHTTPHeaderField: "app_id")
        request.addValue(appKey, forHTTPHeaderField: "app_key")
        
        let session = URLSession.shared
        
        let task = session.dataTask(with: request) { (dataOptional, responseOptional, errorOptional) in
            let httpResponse = responseOptional as! HTTPURLResponse
            
            callback(httpResponse, dataOptional)
        }
        task.resume()
    }
}
