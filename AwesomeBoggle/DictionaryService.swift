import Foundation
import UIKit

protocol DictionaryServiceProtocol: class {
    func checkValidityOf(word: String, callback: @escaping (Bool, Int?) -> ())
    func fetchAllWords(callback: @escaping (ErrorMessage?, [DictWord]?) -> ())
}

class DictionaryService: BaseService, DictionaryServiceProtocol {
    func checkValidityOf(word: String, callback: @escaping (Bool, Int?) -> ()) {
        callback(false, 0)
    }
    
    func fetchAllWords(callback: @escaping (ErrorMessage?, [DictWord]?) -> ()) {
        let url = self.baseUrl.appendingPathComponent("/words")
        
        self.get(url: url) { (errorOptional, dataOptional) in
            if let error = errorOptional {
                callback(error, nil)
                return
            }
            
            let data = dataOptional as! [[String:Any]]
            let words = data.map { DictWord(id: nil, text: $0["text"] as! String) }
            
            callback(nil, words)
        }
    }
}
