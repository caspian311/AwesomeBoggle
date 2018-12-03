import Foundation
import UIKit

class AvailableGamesViewController: UIViewController {
    let coreDataManager: CoreDataManagerProtocol
    let availableGamesView: AvailableGamesView
    let availableGamesModel: AvailableGamesModel
    
    init(availableGamesView: AvailableGamesView = AvailableGamesView(), availableGamesModel: AvailableGamesModel = AvailableGamesModel(), coreDataManager: CoreDataManagerProtocol = CoreDataManager()) {
        self.availableGamesView = availableGamesView
        self.availableGamesModel = availableGamesModel
        self.coreDataManager = coreDataManager
        
        super.init(nibName: nil, bundle: nil)
        
        self.availableGamesModel.fetchAvailableGames()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = self.availableGamesView
        
        self.availableGamesModel.delegate = self
        self.availableGamesView.delegate = self
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

extension AvailableGamesViewController: AvailableGamesViewProtocol {
    func startGame(with userId: Int) {
        DispatchQueue.main.async {
            self.availableGamesModel.startGame(with: userId)
        }
    }
}

extension AvailableGamesViewController: AvailableGamesModelProtocol {
    func gameStarted(_ game: GameData) {
        DispatchQueue.main.async {
            self.coreDataManager.save(currentGame: game)
            self.navigationController?.pushViewController(BoggleViewController(), animated: true)
        }
    }
    
    func errorOcurred(_ errorMessage: ErrorMessage) {
        DispatchQueue.main.async {
            self.availableGamesView.showError(errorMessage.message)
        }
    }
    
    func showGames(_ availableGames: [UserData]) {
        DispatchQueue.main.async {
            self.availableGamesView.populateAvailableGames(availableGames)
        }
    }
    
    func showNoUsersAreAvailable() {
        DispatchQueue.main.async {
            self.availableGamesView.showNoUsersAreAvailable()
        }
    }
}
