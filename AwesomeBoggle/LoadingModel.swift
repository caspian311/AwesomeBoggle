import Foundation

protocol LoadingModelProtocol: class {
    func dataLoaded()
    func updateProgress(_ statusMessage: String)
    func showError(_ message: String)
}

class LoadingModel {
    weak var delegate: LoadingModelProtocol?
    
    func loadData() {
        DictionaryDataLoader().preloadData { (status) in
            switch status.status {
            case .Error:
                self.delegate!.showError(status.message!)
            case .Initialized:
                self.delegate!.updateProgress("Initialized...")
            case .Fetched:
                self.delegate!.updateProgress("Fetched data...")
            case.Loading:
                let text = "Progress: \(status.progress!) / \(status.total!)"
                self.delegate!.updateProgress(text)
            case.Done:
                self.delegate!.dataLoaded()
            }
        }
    }
}
