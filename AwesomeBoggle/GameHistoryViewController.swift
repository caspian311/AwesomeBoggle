import UIKit

class GameHistoryViewController: UIViewController {
    let gameHistoryView: GameHistoryView
    let gameHistoryModel: GameHistoryModel
    
    init(gameHistoryView: GameHistoryView = GameHistoryView(), gameHistoryModel: GameHistoryModel = GameHistoryModel()) {
        self.gameHistoryView = gameHistoryView
        self.gameHistoryModel = gameHistoryModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = self.gameHistoryView
        
        self.gameHistoryModel.delegate = self
        self.gameHistoryView.delegate = self
        
        self.gameHistoryModel.populate()
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

extension GameHistoryViewController: GameHistoryViewProtocol {
    func backButtonPressed() {
        self.gameHistoryModel.goToMainView()
    }
}

extension GameHistoryViewController: GameHistoryModelProtocol {
    func goBack() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func showError(_ error: ErrorMessage) {
        self.gameHistoryView.showError(error)
    }
    
    func showGameList(_ gameList: [GameHistoryEntry]) {
        DispatchQueue.main.async {
            self.gameHistoryView.populateGameList(gameList)
        }
    }
}
