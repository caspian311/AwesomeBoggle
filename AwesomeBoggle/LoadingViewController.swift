import Foundation
import UIKit

class LoadingViewController: UIViewController {
    let loadingView: LoadingView
    let loadingModel: LoadingModel
    
    init(loadingView: LoadingView = LoadingView(), loadingModel: LoadingModel = LoadingModel()) {
        self.loadingView = loadingView
        self.loadingModel = loadingModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = self.loadingView
        
        self.loadingModel.delegate = self
        self.loadingView.delegate = self
        
        print("loading data...")
        self.loadingModel.loadData()
    }
    
    required init?(coder aDecorder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.isHidden = true
    }
}

extension LoadingViewController: LoadingViewProtocol {
    
}

extension LoadingViewController: LoadingModelProtocol {
    func updateProgress(_ statusMessage: String) {
        DispatchQueue.main.async {
            self.loadingView.updateProgress(statusMessage)
        }
    }
    
    func showError(_ message: String) {
        DispatchQueue.main.async {
            self.loadingView.showError(message)
        }
    }
    
    func dataLoaded() {
        DispatchQueue.main.async {
            self.navigationController?.pushViewController(MainViewController(), animated: true)
        }
    }
}
