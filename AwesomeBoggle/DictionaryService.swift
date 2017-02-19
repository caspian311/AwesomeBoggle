import Foundation
import UIKit

class DictionaryService {
    
    let appID = "72562bc6"
    let appKey = "1ca3b176a71b51ecb6bf5efdbf545bcf"
    let language = "en"
    let baseUrl = URL(string: "https://od-api.oxforddictionaries.com:443/api/v1/")!
    
    func checkValidityOf(word: String, callback: @escaping (Bool, Int?) -> ()) {
        let word_id = word.lowercased()
        let url = baseUrl.appendingPathComponent("entries/\(language)/\(word_id)")
        var request = URLRequest(url: url)
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue(appID, forHTTPHeaderField: "app_id")
        request.addValue(appKey, forHTTPHeaderField: "app_key")
        
        let session = URLSession.shared
        
        let task = session.dataTask(with: request) { (dataOptional, responseOptional, errorOptional) in
            let httpResponse = responseOptional as! HTTPURLResponse
            
            if httpResponse.statusCode == 200 {
                callback(true, word.characters.count)
            } else {
                callback(false, 0)
            }
        }
        task.resume()
    }
    
}
