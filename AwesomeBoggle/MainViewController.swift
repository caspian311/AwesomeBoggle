import UIKit

class MainViewController: UIViewController {
    let mainView: MainView
    let mainModel: MainModel
    
    init(mainView: MainView = MainView(), mainModel: MainModel = MainModel()) {
        self.mainView = mainView
        self.mainModel = mainModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = self.mainView
        
        self.mainModel.delegate = self
        self.mainView.delegate = self
    }
    
    required init?(coder aDecorder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MainViewController: MainModelProtocol {
    func startGame() {
        self.present(BoggleViewController(), animated: true, completion: nil)
    }
    
    func showGameHistory() {
        self.navigationController?.pushViewController(GameHistoryViewController(), animated: true)
    }
}

extension MainViewController: MainViewProtocol {
    func newGameButtonPressed() {
        self.mainModel.startGame()
    }
    
    func gameHistoryButtonPressed() {
        self.mainModel.showGameHistory()
    }
}
