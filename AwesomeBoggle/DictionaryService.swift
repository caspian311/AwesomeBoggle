import Foundation
import UIKit

protocol DictionaryServiceProtocol: class {
    func checkValidityOf(word: String, callback: @escaping (Bool, Int?) -> ())
    func getSentenceFor(word: String, callback: @escaping (Bool, String) -> ())
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
                callback(true, word.characters.count)
            } else {
                callback(false, 0)
            }
        }
    }
    
    func getSentenceFor(word: String, callback: @escaping (Bool, String) -> ()) {
        let url = baseUrl.appendingPathComponent("\(word.lowercased())/sentences")
        
        makeCall(url: url) { (response, dataOptional) in
            if response.statusCode == 200 {
                if let data = dataOptional {
                    do  {
                        let jsonObject = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as! Dictionary<String,Any>
                        let results = jsonObject["results"] as! Array<Dictionary<String, Any>>
                        let entries = results.first!["lexicalEntries"] as! Array<Dictionary<String, Any>>
                        let sentences = entries.first!["sentences"] as! Array<Dictionary<String, Any>>
                        let firstSentence = sentences.first!
                        let firstSentenceText = firstSentence["text"] as! String
                        
                        callback(true, firstSentenceText)
                    } catch {
                        callback(false, "Could not find a sentence for \(word)")
                    }
                } else {
                    callback(false, "Could not find a sentence for \(word)")
                }
                
            } else {
                callback(false, "Could not find a sentence for \(word)")
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
