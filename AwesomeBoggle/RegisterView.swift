import UIKit

protocol RegisterViewProtocol: class {
    func cancelButtonPressed()
    func usernameChanged(_ username: String)
    func checkUsernameButtonPressed()
    func registerButtonPressed()
}

class RegisterView: GradientView, UITextFieldDelegate {
    private let cancelButton: UIButton
    private let checkUsernameButton: UIButton
    private let registerButton: UIButton
    private let usernameField: UITextField
    private let availabilityLabel: UILabel
    
    weak var delegate: RegisterViewProtocol?
    
    init() {
        self.cancelButton = UIButton()
        self.checkUsernameButton = UIButton()
        self.registerButton = UIButton()
        self.usernameField =  TextField(frame: CGRect(x: 20, y: 100, width: 300, height: 40))
        self.availabilityLabel = UILabel()
        
        super.init(frame: CGRect.zero)
        
        self.addSubview(usernameField)
        self.addSubview(self.cancelButton)
        self.addSubview(self.checkUsernameButton)
        self.addSubview(self.registerButton)
        self.addSubview(self.availabilityLabel)
        
        self.startColor = UIColor(red: 0.6, green: 0.8, blue: 1.00, alpha: 1.00)
        self.endColor = UIColor(red: 0.2, green: 0.6, blue: 1.00, alpha: 1.00)
        
        self.cancelButton.setTitle("CANCEL", for: .normal)
        self.cancelButton.setTitleColor(.black, for: .normal)
        self.cancelButton.setTitleColor(.gray, for: .disabled)
        
        self.cancelButton.backgroundColor = .white
        self.cancelButton.layer.borderColor = UIColor.black.cgColor
        self.cancelButton.layer.borderWidth = 2
        self.cancelButton.layer.cornerRadius = 10
        
        self.cancelButton.translatesAutoresizingMaskIntoConstraints = false
        self.cancelButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        self.cancelButton.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        self.cancelButton.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        self.cancelButton.widthAnchor.constraint(equalTo: self.widthAnchor, constant: -30).isActive = true
        
        self.cancelButton.addTarget(self, action: #selector(cancelButtonPressed), for: .touchUpInside)
        
        self.usernameField.backgroundColor = .white
        self.usernameField.layer.borderColor = UIColor.black.cgColor
        self.usernameField.layer.borderWidth = 2
        self.usernameField.layer.cornerRadius = 10
        self.usernameField.placeholder = "Enter username here"
        self.usernameField.delegate = self
        
        self.usernameField.translatesAutoresizingMaskIntoConstraints = false
        self.usernameField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        self.usernameField.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        self.usernameField.widthAnchor.constraint(equalTo: self.widthAnchor, constant: -30).isActive = true
        self.usernameField.bottomAnchor.constraint(equalTo: self.cancelButton.topAnchor, constant: -30).isActive = true
        
        self.usernameField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        
        
        self.checkUsernameButton.setTitle("Check Availability", for: .normal)
        self.checkUsernameButton.setTitleColor(.black, for: .normal)
        self.checkUsernameButton.setTitleColor(.gray, for: .disabled)

        self.checkUsernameButton.backgroundColor = .white
        self.checkUsernameButton.layer.borderColor = UIColor.black.cgColor
        self.checkUsernameButton.layer.borderWidth = 2
        self.checkUsernameButton.layer.cornerRadius = 10

        self.checkUsernameButton.translatesAutoresizingMaskIntoConstraints = false
        self.checkUsernameButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        self.checkUsernameButton.leadingAnchor.constraint(equalTo: self.cancelButton.trailingAnchor, constant: -10).isActive = true
        self.checkUsernameButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10).isActive = true

        self.checkUsernameButton.addTarget(self, action: #selector(checkUsernameButtonPressed), for: .touchUpInside)

        
        self.registerButton.setTitle("REGISTER", for: .normal)
        self.registerButton.setTitleColor(.black, for: .normal)
        self.registerButton.setTitleColor(.gray, for: .disabled)

        self.registerButton.backgroundColor = .white
        self.registerButton.layer.borderColor = UIColor.black.cgColor
        self.registerButton.layer.borderWidth = 2
        self.registerButton.layer.cornerRadius = 10

        self.registerButton.translatesAutoresizingMaskIntoConstraints = false
        self.registerButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        self.registerButton.topAnchor.constraint(equalTo: self.cancelButton.bottomAnchor, constant: 10).isActive = true
        self.registerButton.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        self.registerButton.widthAnchor.constraint(equalTo: self.widthAnchor, constant: -30).isActive = true

        self.registerButton.isEnabled = false

        self.registerButton.addTarget(self, action: #selector(registrationButtonPressed), for: .touchUpInside)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func cancelButtonPressed() {
        self.delegate?.cancelButtonPressed()
    }

    @objc private func checkUsernameButtonPressed() {
        self.delegate?.checkUsernameButtonPressed()
    }
    
    @objc private func registrationButtonPressed() {
        self.delegate?.registerButtonPressed()
    }
    
    @objc func textFieldDidChange() -> Bool {
        if let username = self.usernameField.text {
            self.delegate?.usernameChanged(username)
        } else {
            self.delegate?.usernameChanged("")
        }
        
        return true
    }
    
    func showUsernameAvailableMessage() {
        print("username is available")
    }
    
    func showUsernameTakenMessage() {
        print("username is NOT available")
    }
    
    func enableRegisterButton() {
        self.registerButton.isEnabled = true
    }
    
    func disableRegisterButton() {
        self.registerButton.isEnabled = false
    }
}
