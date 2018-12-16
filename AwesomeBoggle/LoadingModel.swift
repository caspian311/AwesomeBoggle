import Foundation

protocol LoadingModelProtocol: class {
    func dataLoaded()
    func showError()
}

class LoadingModel {
    weak var delegate: LoadingModelProtocol?
    
    func loadData() {
        DictionaryDataLoeader().preloadData { (success) in
            if success {
                
                self.delegate!.dataLoaded()
            } else
            {
                self.delegate!.showError()
            }
        }
        
    }
}
