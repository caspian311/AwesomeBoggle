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
        if self.dataLayer.fetchWordCount() == 0 {
            print("need to get data")
            self.dictionaryService.fetchAllWords() { (errorOptional, dataOptional) in
                let status = DataLoadingStatus()
                
                if let error = errorOptional {
                    print("Error when retrieving word list")
                    print(error.message)
                    
                    status.status = .Error
                    status.message = error.message
                    callback(status)
                    return
                }
                
                if let data = dataOptional {
                    status.status = .Fetched
                    status.total = data.count
                    status.progress = 0
                    callback(status)

                    var dictionaryWords = data.map{ $0.text }

                    status.status = .Loading
                    callback(status)

                    let batchSize = 1000
                    while !dictionaryWords.isEmpty {
                        let bunch = Array(dictionaryWords.prefix(batchSize))
                        
                        print("saving \(batchSize) - \(dictionaryWords.count) out of \(String(describing: status.total))")
                        
                        self.dataLayer.save(dictionaryWords: bunch)
                        
                        status.progress = status.total! - dictionaryWords.count
                        callback(status)
                        
                        dictionaryWords = Array(dictionaryWords.dropLast(batchSize))
                    }

                    print("done processing the data")
                    status.status = .Done
                    callback(status)
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
