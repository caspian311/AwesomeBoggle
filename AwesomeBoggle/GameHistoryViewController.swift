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
    
    required init?(coder aDecorder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension GameHistoryViewController: GameHistoryViewProtocol {
    
}

extension GameHistoryViewController: GameHistoryModelProtocol {
    func showGameList(_ gameList: [GameHistoryEntry]) {
        self.gameHistoryView.populateGameList(gameList)
    }
}
