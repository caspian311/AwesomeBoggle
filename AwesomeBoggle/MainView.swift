import UIKit

protocol MainViewProtocol: class {
    func newGameButtonPressed()
    func gameHistoryButtonPressed()
}

class MainView: UIView {
    weak var delegate: MainViewProtocol?
    
    init() {
        super.init(frame: CGRect.zero)
        
        self.backgroundColor = .gray
        
        let startGameButton = UIButton()
        
        self.addSubview(startGameButton)
        
        startGameButton.setTitle("New Game", for: .normal)
        startGameButton.setTitleColor(.black, for: .normal)
        
        startGameButton.backgroundColor = .white
        startGameButton.layer.borderColor = UIColor.red.cgColor
        startGameButton.layer.borderWidth = 1
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
        gameHistoryButton.layer.borderColor = UIColor.red.cgColor
        gameHistoryButton.layer.borderWidth = 1
        gameHistoryButton.layer.cornerRadius = 10
        
        gameHistoryButton.translatesAutoresizingMaskIntoConstraints = false
        gameHistoryButton.widthAnchor.constraint(equalTo: self.widthAnchor, constant: -30).isActive = true
        gameHistoryButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        gameHistoryButton.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        gameHistoryButton.topAnchor.constraint(equalTo: startGameButton.bottomAnchor, constant: 10).isActive = true
        
        gameHistoryButton.addTarget(self, action: #selector(gameHistoryButtonPressed), for: .touchUpInside)
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
}
