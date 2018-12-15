import Foundation

class DictionaryDataLoeader {
    private let coreDataManager: CoreDataManagerProtocol;
    private let dictionaryService: DictionaryServiceProtocol;
    
    init(coreDataManager: CoreDataManagerProtocol = CoreDataManager(), dictionaryService: DictionaryServiceProtocol = DictionaryService()) {
        self.coreDataManager = coreDataManager
        self.dictionaryService = dictionaryService
    }

    func preloadData() {
        if self.coreDataManager.fetchDictionaryWords().count == 0 {
            self.dictionaryService.fetchAllWords() { (errorOptional, dataOptional) in
                if let error = errorOptional {
                    print("Error when retrieving word list")
                    print(error.message)
                    return
                }
                
                if let data = dataOptional {
                    data
                        .map{ DictWord(text: $0) }
                        .forEach{ self.coreDataManager.save(dictionaryWord: $0) }
                }
            }
        }
    }
}
