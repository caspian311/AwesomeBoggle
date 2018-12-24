import Foundation
import UIKit

class DictionaryDataLoader {
    private let dataLayer: DataLayerProtocol;
    private let dictionaryService: DictionaryServiceProtocol;
    
    init(dataLayer: DataLayerProtocol = DataLayer(), dictionaryService: DictionaryServiceProtocol = DictionaryService()) {
        self.dataLayer = dataLayer
        self.dictionaryService = dictionaryService
    }

    func preloadData(_ callback: @escaping (DataLoadingStatus) -> ()) {
        if self.dataLayer.fetchDictionaryWords().count == 0 {
            print("need to get data")
            self.dictionaryService.fetchAllWords() { (errorOptional, dataOptional) in
                if let error = errorOptional {
                    print("Error when retrieving word list")
                    print(error.message)
                    let status = DataLoadingStatus()
                    status.status = .Error
                    status.message = error.message
                    callback(status)
                    return
                }
                
                if let data = dataOptional {
                    let status = DataLoadingStatus()
                    status.status = .Fetched
                    status.total = data.count
                    status.progress = 0
                    callback(status)
                    
                    if let data = dataOptional {
                        status.status = .Loading
                        callback(status)

                        let dictionaryWords = data.map{ DictWord(id: nil, text: $0.text) }
                        
                        for (index, word) in dictionaryWords.enumerated() {
                            print("saving \(index) out of \(dictionaryWords.count)")
                            
                            self.dataLayer.save(dictionaryWord: word)
                            
                            status.progress = index
                            callback(status)
                        }
                        
                        print("done processing the data")
                        status.status = .Done
                        callback(status)
                    }
                }
            }
        } else {
            print("already got the data")
            let status = DataLoadingStatus()
            status.status = .Done
            callback(status)
        }
    }
}
