import Foundation
import UIKit

class AvailableGamesViewController: UIViewController {
    private let dataLayer: DataLayerProtocol
    private let availableGamesView: AvailableGamesView
    private let availableGamesModel: AvailableGamesModel
    
    init(availableGamesView: AvailableGamesView = AvailableGamesView(), availableGamesModel: AvailableGamesModel = AvailableGamesModel(), dataLayer: DataLayerProtocol = DataLayer()) {
        self.availableGamesView = availableGamesView
        self.availableGamesModel = availableGamesModel
        self.dataLayer = dataLayer
        
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
    func backButtonPressed() {
        self.availableGamesModel.goBack()
    }
    
    func startGame(with userId: Int) {
        DispatchQueue.main.async {
            self.availableGamesModel.startGame(with: userId)
        }
    }
}

extension AvailableGamesViewController: AvailableGamesModelProtocol {
    func navigateToMain() {
        self.navigationController?.pushViewController(MainViewController(), animated: true)
    }
    
    func waitForOthersToJoin(_ invititations: [Invitation]) {
        DispatchQueue.main.async {
            self.dataLayer.save(invitations: invititations)
            self.navigationController?.pushViewController(WaitingForOthersViewController(), animated: true)
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
