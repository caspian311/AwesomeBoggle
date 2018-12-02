import UIKit

class RegisterViewController: UIViewController {
    let coreDataManager: CoreDataManagerProtocol
    let registerView: RegisterView
    let registerModel: RegisterModel
    
    init(registerView: RegisterView = RegisterView(), registerModel: RegisterModel = RegisterModel(), coreDataManager: CoreDataManagerProtocol = CoreDataManager()) {
        self.registerView = registerView
        self.registerModel = registerModel
        self.coreDataManager = coreDataManager
        
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = self.registerView
        
        self.registerModel.delegate = self
        self.registerView.delegate = self
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

extension RegisterViewController: RegisterModelProtocol {
    func done(_ userOptional: UserData?) {
        DispatchQueue.main.async {
            if let user = userOptional {
                self.coreDataManager.save(user: user)
            }
            self.navigationController?.pushViewController(MainViewController(), animated: true)
        }
    }
    
    func usernameAvailable() {
        DispatchQueue.main.async {
            self.registerView.showUsernameAvailableMessage()
            self.registerView.enableRegisterButton()
        }
    }
    
    func usernameIsTaken() {
        DispatchQueue.main.async {
            self.registerView.showUsernameTakenMessage()
            self.registerView.disableRegisterButton()
        }
    }
    
    func showErrorMessage(_ errorMessage: String) {
        DispatchQueue.main.async {
            self.registerView.showErrorMessage(errorMessage)
        }
    }
}

extension RegisterViewController: RegisterViewProtocol {
    func cancelButtonPressed() {
        self.registerModel.cancel()
    }
    
    func usernameChanged(_ username: String) {
        self.registerModel.setUsername(username)
    }
    
    func checkUsernameButtonPressed() {
        self.registerModel.checkUsername()
    }
    
    func registerButtonPressed() {
        self.registerModel.register()
    }
}
