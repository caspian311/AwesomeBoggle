import UIKit

protocol MainViewProtocol: class {
    func newGameButtonPressed()
    func gameHistoryButtonPressed()
    func registerButtonPressed()
    func initializeScreen()
}

class MainView: GradientView {
    let startGameButton: UIButton
    let gameHistoryButton: UIButton
    let registerButton: UIButton
    
    weak var delegate: MainViewProtocol?
    
    init() {
        self.startGameButton = UIButton()
        self.gameHistoryButton = UIButton()
        self.registerButton = UIButton()
        
        super.init(frame: CGRect.zero)
        
        self.addSubview(self.startGameButton)
        self.addSubview(self.gameHistoryButton)
        self.addSubview(self.registerButton)
        
        self.startColor = UIColor(red: 0.6, green: 0.8, blue: 1.00, alpha: 1.00)
        self.endColor = UIColor(red: 0.2, green: 0.6, blue: 1.00, alpha: 1.00)

        
        self.startGameButton.setTitle("New Game", for: .normal)
        self.startGameButton.setTitleColor(.black, for: .normal)
        
        self.startGameButton.backgroundColor = .white
        self.startGameButton.layer.borderColor = UIColor.black.cgColor
        self.startGameButton.layer.borderWidth = 2
        self.startGameButton.layer.cornerRadius = 10
        
        self.startGameButton.translatesAutoresizingMaskIntoConstraints = false
        self.startGameButton.widthAnchor.constraint(equalTo: self.widthAnchor, constant: -30).isActive = true
        self.startGameButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        self.startGameButton.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        self.startGameButton.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        
        self.startGameButton.addTarget(self, action: #selector(newGameButtonPressed), for: .touchUpInside)
        
        
        self.gameHistoryButton.setTitle("Game History", for: .normal)
        self.gameHistoryButton.setTitleColor(.black, for: .normal)
        
        self.gameHistoryButton.backgroundColor = .white
        self.gameHistoryButton.layer.borderColor = UIColor.black.cgColor
        self.gameHistoryButton.layer.borderWidth = 2
        self.gameHistoryButton.layer.cornerRadius = 10
        
        self.gameHistoryButton.translatesAutoresizingMaskIntoConstraints = false
        self.gameHistoryButton.widthAnchor.constraint(equalTo: self.widthAnchor, constant: -30).isActive = true
        self.gameHistoryButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        self.gameHistoryButton.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        self.gameHistoryButton.topAnchor.constraint(equalTo: startGameButton.bottomAnchor, constant: 10).isActive = true
        
        self.gameHistoryButton.addTarget(self, action: #selector(gameHistoryButtonPressed), for: .touchUpInside)
        
        self.registerButton.setTitle("Register", for: .normal)
        self.registerButton.setTitleColor(.black, for: .normal)
        
        self.registerButton.backgroundColor = .white
        self.registerButton.layer.borderColor = UIColor.black.cgColor
        self.registerButton.layer.borderWidth = 2
        self.registerButton.layer.cornerRadius = 10
        
        self.registerButton.translatesAutoresizingMaskIntoConstraints = false
        self.registerButton.widthAnchor.constraint(equalTo: self.widthAnchor, constant: -30).isActive = true
        self.registerButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        self.registerButton.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        self.registerButton.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        
        self.registerButton.addTarget(self, action: #selector(registerButtonPressed), for: .touchUpInside)
        
        
        let titleLabel = UILabel()
        
        self.addSubview(titleLabel)
        
        titleLabel.text = "Awesome\nBoggle"
        
        titleLabel.textAlignment = .center
        titleLabel.backgroundColor = .clear
        titleLabel.font = UIFont(name:"HelveticaNeue-Bold", size: 60)
        titleLabel.numberOfLines = 0
        
        let strokeTextAttributes = [
            NSAttributedStringKey.strokeColor : UIColor.black,
            NSAttributedStringKey.foregroundColor : UIColor.white,
            NSAttributedStringKey.strokeWidth : -4.0,
            NSAttributedStringKey.font : UIFont(name:"HelveticaNeue-Bold", size: 60)!]
            as [NSAttributedStringKey : Any]
        titleLabel.attributedText = NSMutableAttributedString(string: "Awesome\nBoggle", attributes: strokeTextAttributes)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.bottomAnchor.constraint(equalTo: startGameButton.topAnchor, constant: -30).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc
    private func newGameButtonPressed() {
        self.delegate?.newGameButtonPressed()
    }
    
    @objc
    private func gameHistoryButtonPressed() {
        self.delegate?.gameHistoryButtonPressed()
    }
    
    @objc
    private func registerButtonPressed() {
        self.delegate?.registerButtonPressed()
    }
    
    func initializeScreen() {
        self.delegate?.initializeScreen()
    }
    
    func showNewUserMainScreen(){
        self.registerButton.isHidden = false
        self.startGameButton.isHidden = true
        self.gameHistoryButton.isHidden = true
    }
    
    func showUserMainScreen() {
        self.registerButton.isHidden = true
        self.startGameButton.isHidden = false
        self.gameHistoryButton.isHidden = false
    }
}
