import Foundation
import UIKit

class WaitingForOthersViewController: UIViewController {
    let coreDataManager: CoreDataManagerProtocol
    let waitingForOthersView: WaitingForOthersView
    let waitingForOthersModel: WaitingForOthersModel
    
    init(waitingForOthersView: WaitingForOthersView = WaitingForOthersView(), waitingForOthersModel: WaitingForOthersModel = WaitingForOthersModel(), coreDataManager: CoreDataManager = CoreDataManager(UIApplication.shared.delegate! as! AppDelegate)) {
        self.waitingForOthersView = waitingForOthersView
        self.waitingForOthersModel = waitingForOthersModel
        self.coreDataManager = coreDataManager
        
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = self.waitingForOthersView
        
        self.waitingForOthersModel.delegate = self
        self.waitingForOthersView.delegate = self
        
        self.waitingForOthersModel.waitForOthers()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.isHidden = true
    }
    
    required init?(coder aDecorder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension WaitingForOthersViewController: WaitingForOthersViewProtocol {
}

extension WaitingForOthersViewController: WaitingForOthersModelProtocol {
    func errorOccurred(_ errorMessage: String) {
        self.waitingForOthersView.showError(errorMessage)
    }
}
