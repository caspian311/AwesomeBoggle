import UIKit

class MainViewController: UIViewController {
    private let mainView: MainView
    private let mainModel: MainModel
    private let dataLayer: DataLayerProtocol
    
    init(mainView: MainView = MainView(), mainModel: MainModel = MainModel(), dataLayer: DataLayerProtocol = DataLayer()) {
        self.mainView = mainView
        self.mainModel = mainModel
        self.dataLayer = dataLayer
        
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = self.mainView
        
        self.mainModel.delegate = self
        self.mainView.delegate = self
        
        self.mainView.initializeScreen()
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

extension MainViewController: MainModelProtocol {
    func startGame() {
        print("starting game...")
        self.navigationController?.pushViewController(AvailableGamesViewController(), animated: true)
    }
    
    func showGameHistory() {
        self.navigationController?.pushViewController(GameHistoryViewController(), animated: true)
    }
    
    func showRegistration() {
        self.navigationController?.pushViewController(RegisterViewController(), animated: true)
    }
}

extension MainViewController: MainViewProtocol {
    func newGameButtonPressed() {
        self.mainModel.startGame()
    }
    
    func gameHistoryButtonPressed() {
        self.mainModel.showGameHistory()
    }
    
    func registerButtonPressed() {
        self.mainModel.registerButton()
    }
    
    func initializeScreen() {
        self.mainModel.registrationCheck() { (isRegistered) in
            if isRegistered {
                if self.dataLayer.fetchCurrentGame() == nil {
                    self.mainView.showUserMainScreen()
                } else {
                    self.navigationController?.pushViewController(WaitingForOthersViewController(), animated: true)
                }
            } else {
                self.mainView.showNewUserMainScreen()
            }
        }
    }
}
