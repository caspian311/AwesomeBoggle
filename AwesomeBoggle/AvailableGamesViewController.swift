import Foundation
import UIKit

class AvailableGamesViewController: UIViewController {
    let availableGamesView: AvailableGamesView
    let availableGamesModel: AvailableGamesModel
    
    init(availableGamesView: AvailableGamesView = AvailableGamesView(), availableGamesModel: AvailableGamesModel = AvailableGamesModel()) {
        self.availableGamesView = availableGamesView
        self.availableGamesModel = availableGamesModel
        
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
    
}

extension AvailableGamesViewController: AvailableGamesModelProtocol {
    func play() {
        self.navigationController?.pushViewController(BoggleViewController(), animated: true)
    }
}
