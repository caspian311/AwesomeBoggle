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
    private let availabilityLabel: PaddedUILabel
    private let availabilityLabelTextAttributes: [NSAttributedStringKey : Any]
    
    weak var delegate: RegisterViewProtocol?
    
    init() {
        self.cancelButton = UIButton()
        self.checkUsernameButton = UIButton()
        self.registerButton = UIButton()
        self.usernameField =  TextField(frame: CGRect(x: 20, y: 100, width: 300, height: 40))
        self.availabilityLabel = PaddedUILabel()
        self.availabilityLabelTextAttributes = [
            NSAttributedStringKey.foregroundColor : UIColor.black,
            NSAttributedStringKey.font : UIFont(name:"HelveticaNeue-Bold", size: 15)!]
            as [NSAttributedStringKey : Any]
        let screenTitle = PaddedUILabel()
        
        super.init(frame: CGRect.zero)
        
        self.addSubview(usernameField)
        self.addSubview(self.cancelButton)
        self.addSubview(self.checkUsernameButton)
        self.addSubview(self.registerButton)
        self.addSubview(self.availabilityLabel)
        self.addSubview(screenTitle)
        
        self.startColor = UIColor(red: 0.6, green: 0.8, blue: 1.00, alpha: 1.00)
        self.endColor = UIColor(red: 0.2, green: 0.6, blue: 1.00, alpha: 1.00)
        
        screenTitle.textAlignment = .center
        screenTitle.backgroundColor = .clear
        let screenTitleTextAttributes = [
            NSAttributedStringKey.strokeColor : UIColor.black,
            NSAttributedStringKey.foregroundColor : UIColor.white,
            NSAttributedStringKey.strokeWidth : -4.0,
            NSAttributedStringKey.font : UIFont(name:"HelveticaNeue-Bold", size: 40)!]
            as [NSAttributedStringKey : Any]
        screenTitle.attributedText = NSMutableAttributedString(string: "Register", attributes: screenTitleTextAttributes)
        
        screenTitle.translatesAutoresizingMaskIntoConstraints = false
        screenTitle.bottomAnchor.constraint(equalTo: self.usernameField.topAnchor, constant: -10).isActive = true
        screenTitle.widthAnchor.constraint(equalTo: self.widthAnchor, constant: -20).isActive = true
        
        self.cancelButton.setTitle("Cancel", for: .normal)
        self.cancelButton.setTitleColor(.black, for: .normal)
        self.cancelButton.setTitleColor(.gray, for: .disabled)
        
        self.cancelButton.backgroundColor = .white
        self.cancelButton.layer.borderColor = UIColor.black.cgColor
        self.cancelButton.layer.borderWidth = 2
        self.cancelButton.layer.cornerRadius = 10
        
        self.cancelButton.translatesAutoresizingMaskIntoConstraints = false
        self.cancelButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        self.cancelButton.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        self.cancelButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
        self.cancelButton.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1/4).isActive = true
        
        self.checkUsernameButton.setTitle("Check Availability", for: .normal)
        self.checkUsernameButton.setTitleColor(.black, for: .normal)
        self.checkUsernameButton.setTitleColor(.gray, for: .disabled)
        
        self.checkUsernameButton.backgroundColor = .white
        self.checkUsernameButton.layer.borderColor = UIColor.black.cgColor
        self.checkUsernameButton.layer.borderWidth = 2
        self.checkUsernameButton.layer.cornerRadius = 10
        
        self.checkUsernameButton.translatesAutoresizingMaskIntoConstraints = false
        self.checkUsernameButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        self.checkUsernameButton.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        self.checkUsernameButton.leadingAnchor.constraint(equalTo: self.cancelButton.trailingAnchor, constant: 10).isActive = true
        self.checkUsernameButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10).isActive = true
        
        
        self.usernameField.backgroundColor = .white
        self.usernameField.layer.borderColor = UIColor.black.cgColor
        self.usernameField.layer.borderWidth = 2
        self.usernameField.layer.cornerRadius = 10
        self.usernameField.placeholder = "Enter username here"
        self.usernameField.delegate = self
        
        self.usernameField.translatesAutoresizingMaskIntoConstraints = false
        self.usernameField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        self.usernameField.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        self.usernameField.widthAnchor.constraint(equalTo: self.widthAnchor, constant: -20).isActive = true
        self.usernameField.bottomAnchor.constraint(equalTo: self.cancelButton.topAnchor, constant: -30).isActive = true
        
        self.availabilityLabel.textAlignment = .center
        self.availabilityLabel.backgroundColor = .clear
        
        self.availabilityLabel.translatesAutoresizingMaskIntoConstraints = false
        self.availabilityLabel.topAnchor.constraint(equalTo: self.usernameField.bottomAnchor, constant: 5).isActive = true
        self.availabilityLabel.widthAnchor.constraint(equalTo: self.widthAnchor, constant: -20).isActive = true
        
        self.registerButton.setTitle("Register", for: .normal)
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

        
        self.cancelButton.addTarget(self, action: #selector(cancelButtonPressed), for: .touchUpInside)
        self.checkUsernameButton.addTarget(self, action: #selector(checkUsernameButtonPressed), for: .touchUpInside)
        self.usernameField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
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
    
    @objc private func textFieldDidChange() -> Bool {
        if let username = self.usernameField.text {
            self.delegate?.usernameChanged(username)
        } else {
            self.delegate?.usernameChanged("")
        }
        
        return true
    }
    
    func showUsernameAvailableMessage() {
        let message = "Username is available"
        self.availabilityLabel.attributedText = NSMutableAttributedString(string: message, attributes: self.availabilityLabelTextAttributes)
    }
    
    func showUsernameTakenMessage() {
        let message = "Username is NOT available"
        self.availabilityLabel.attributedText = NSMutableAttributedString(string: message, attributes: self.availabilityLabelTextAttributes)
    }
    
    func enableRegisterButton() {
        self.registerButton.isEnabled = true
    }
    
    func disableRegisterButton() {
        self.registerButton.isEnabled = false
    }
    
    func showErrorMessage(_ errorMessage: String) {
        // TODO display error message
        print("Error: \(errorMessage)")
    }
}
