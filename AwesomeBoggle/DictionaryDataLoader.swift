import Foundation
import UIKit

class DictionaryDataLoader {
    private let coreDataManager: CoreDataManagerProtocol;
    private let dictionaryService: DictionaryServiceProtocol;
    
    init(coreDataManager: CoreDataManager = CoreDataManager(UIApplication.shared.delegate! as! AppDelegate), dictionaryService: DictionaryServiceProtocol = DictionaryService()) {
        self.coreDataManager = coreDataManager
        self.dictionaryService = dictionaryService
    }

    func preloadData(_ callback: @escaping (DataLoadingStatus) -> ()) {
        if self.coreDataManager.fetchDictionaryWords().count == 0 {
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
                    
                    status.status = .Loading
                    var dictionaryWords = data.map{ DictWord(text: $0.text) }
                    
                    let batchSize = 100
                    while !dictionaryWords.isEmpty {
                        print("saving \(batchSize) elements - \(data.count - dictionaryWords.count) out of \(data.count)")
                        
                        let bunch = dictionaryWords.prefix(batchSize)
                        self.coreDataManager.save(dictionaryWords: Array(bunch))
                        dictionaryWords = Array(dictionaryWords.dropFirst(batchSize))
                    }
                    
//                    self.coreDataManager.save(dictionaryWords: dictionaryWords)
//                    for (index, element) in (dictionaryWords).enumerated() {
//                        print("saving: \(element) - \(index) out of \(data.count)")
//
//                        self.coreDataManager.save(dictionaryWord: element)
//
//                        if index % 100 == 0 {
//                            status.progress = index
//                            callback(status)
//                        }
//
//                        if index == data.count {
//                            print("done processing the data")
//                            status.status = .Done
//                            callback(status)
//                        }
//                    }
                    
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
