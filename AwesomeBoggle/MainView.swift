import UIKit

protocol MainViewProtocol: class {
    func newGameButtonPressed()
    func gameHistoryButtonPressed()
    func registerButtonPressed()
}

class MainView: GradientView {
    weak var delegate: MainViewProtocol?
    
    init() {
        super.init(frame: CGRect.zero)
        
        self.startColor = UIColor(red: 0.6, green: 0.8, blue: 1.00, alpha: 1.00)
        self.endColor = UIColor(red: 0.2, green: 0.6, blue: 1.00, alpha: 1.00)
        
        let startGameButton = UIButton()
        
        self.addSubview(startGameButton)
        
        startGameButton.setTitle("New Game", for: .normal)
        startGameButton.setTitleColor(.black, for: .normal)
        
        startGameButton.backgroundColor = .white
        startGameButton.layer.borderColor = UIColor.black.cgColor
        startGameButton.layer.borderWidth = 2
        startGameButton.layer.cornerRadius = 10
        
        startGameButton.translatesAutoresizingMaskIntoConstraints = false
        startGameButton.widthAnchor.constraint(equalTo: self.widthAnchor, constant: -30).isActive = true
        startGameButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        startGameButton.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        startGameButton.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        
        startGameButton.addTarget(self, action: #selector(newGameButtonPressed), for: .touchUpInside)
        
        let gameHistoryButton = UIButton()
        
        self.addSubview(gameHistoryButton)
        
        gameHistoryButton.setTitle("Game History", for: .normal)
        gameHistoryButton.setTitleColor(.black, for: .normal)
        
        gameHistoryButton.backgroundColor = .white
        gameHistoryButton.layer.borderColor = UIColor.black.cgColor
        gameHistoryButton.layer.borderWidth = 2
        gameHistoryButton.layer.cornerRadius = 10
        
        gameHistoryButton.translatesAutoresizingMaskIntoConstraints = false
        gameHistoryButton.widthAnchor.constraint(equalTo: self.widthAnchor, constant: -30).isActive = true
        gameHistoryButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        gameHistoryButton.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        gameHistoryButton.topAnchor.constraint(equalTo: startGameButton.bottomAnchor, constant: 10).isActive = true
        
        gameHistoryButton.addTarget(self, action: #selector(gameHistoryButtonPressed), for: .touchUpInside)
        
        
        let registerButton = UIButton()
        
        self.addSubview(registerButton)
        
        registerButton.setTitle("Register", for: .normal)
        registerButton.setTitleColor(.black, for: .normal)
        
        registerButton.backgroundColor = .white
        registerButton.layer.borderColor = UIColor.black.cgColor
        registerButton.layer.borderWidth = 2
        registerButton.layer.cornerRadius = 10
        
        registerButton.translatesAutoresizingMaskIntoConstraints = false
        registerButton.widthAnchor.constraint(equalTo: self.widthAnchor, constant: -30).isActive = true
        registerButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        registerButton.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        registerButton.topAnchor.constraint(equalTo: gameHistoryButton.bottomAnchor, constant: 10).isActive = true
        
        registerButton.addTarget(self, action: #selector(registerButtonPressed), for: .touchUpInside)
        
        
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
}
