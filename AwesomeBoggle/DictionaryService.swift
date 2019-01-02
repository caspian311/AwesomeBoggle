import Foundation
import UIKit

protocol DictionaryServiceProtocol: class {
    func checkValidityOf(word: String, callback: @escaping (Bool, Int) -> ())
    func fetchAllWords(callback: @escaping (ErrorMessage?, [DictWord]?) -> ())
}

class DictionaryService: BaseService, DictionaryServiceProtocol {
    private let dataLayer: DataLayerProtocol
    
    init(dataLayer: DataLayerProtocol = DataLayer()) {
        self.dataLayer = dataLayer
    }
    
    func checkValidityOf(word text: String, callback: @escaping (Bool, Int) -> ()) {
        print("checking for \(text) for validity...")
        if let word = dataLayer.fetchWordBy(text: text) {
            print("it is worth \(word.text.count) points")
            
            callback(true, word.text.count)
        } else {
            print("not a word")
            
            callback(false, 0)
        }
    }
    
    func fetchAllWords(callback: @escaping (ErrorMessage?, [DictWord]?) -> ()) {
        let url = self.baseUrl.appendingPathComponent("/words")
        
        self.get(url: url) { (errorOptional, dataOptional) in
            if let error = errorOptional {
                callback(ErrorMessage(message: error.message), nil)
                return
            }
            
            let data = dataOptional as! [[String:Any]]
            let words = data.map { DictWord(id: nil, text: $0["text"] as! String) }
            
            callback(nil, words)
        }
    }
}
