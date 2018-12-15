import Foundation
import UIKit

protocol DictionaryServiceProtocol: class {
    func checkValidityOf(word: String, callback: @escaping (Bool, Int?) -> ())
    func fetchAllWords(callback: @escaping (ErrorMessage?, [String]?) -> ())
}

class DictionaryService: BaseService, DictionaryServiceProtocol {
    func checkValidityOf(word: String, callback: @escaping (Bool, Int?) -> ()) {
        callback(false, 0)
    }
    
    func fetchAllWords(callback: @escaping (ErrorMessage?, [String]?) -> ()) {
        let url = self.baseUrl.appendingPathComponent("/words")
        
        self.get(url: url) { (errorOptional, dataOptional: [String]?) in
            if let error = errorOptional {
                callback(ErrorMessage(message: error.message), nil)
            } else if let data = dataOptional {
                callback(nil, data)
            }
        }
    }
}
