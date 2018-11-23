import UIKit

protocol BoggleViewProtocol: class {
    func resetGrid()
    func letterSelected(_ letter: String?)
    func submitWord()
    func done()
    func clearWord()
}

class BoggleView: GradientView {
    private var gridButtons: [UIButton] = []
    private var currentWordLabel: PaddedUILabel
    private var wordList: [String] = []
    private var submitResultsLabel: UILabel
    private let quitButton: UIButton
    private let submitWordButton: UIButton
    private var timer = PaddedUILabel()
    private var timerTextAttributes: [NSAttributedStringKey : Any] = [:]

    weak var delegate: BoggleViewProtocol?
    
    init() {
        self.currentWordLabel = PaddedUILabel()
        self.submitResultsLabel = UILabel()
        self.quitButton = UIButton()
        self.submitWordButton = UIButton()
        self.timer = PaddedUILabel()
        
        super.init(frame: CGRect.zero)
        
        self.startColor = UIColor(red: 0.6, green: 0.8, blue: 1.00, alpha: 1.00)
        self.endColor = UIColor(red: 0.2, green: 0.6, blue: 1.00, alpha: 1.00)
        
        let gridRows = UIStackView()
        
        self.addSubview(gridRows)
        
        gridRows.axis = .vertical
        gridRows.translatesAutoresizingMaskIntoConstraints = false
        gridRows.topAnchor.constraint(equalTo: self.topAnchor, constant: 20).isActive = true
        gridRows.widthAnchor.constraint(equalTo: self.widthAnchor, constant: -20).isActive = true
        gridRows.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        gridRows.backgroundColor = .white
        
        createButtons(gridRows)
        
        self.addSubview(self.currentWordLabel)
        
        self.currentWordLabel.translatesAutoresizingMaskIntoConstraints = false
        self.currentWordLabel.backgroundColor = .white
        self.currentWordLabel.layer.masksToBounds = true
        self.currentWordLabel.layer.borderColor = UIColor.black.cgColor
        self.currentWordLabel.layer.borderWidth = 2
        self.currentWordLabel.layer.cornerRadius = 10
        self.currentWordLabel.layer.contentsRect.insetBy(dx: 10, dy: 10)
        
        self.currentWordLabel.topAnchor.constraint(equalTo: gridRows.bottomAnchor, constant: 10).isActive = true
        self.currentWordLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
        self.currentWordLabel.heightAnchor.constraint(equalToConstant: 60).isActive = true
        self.currentWordLabel.widthAnchor.constraint(equalTo: self.widthAnchor, constant: -110).isActive = true
        
        self.currentWordLabel.isUserInteractionEnabled = true
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(currentWordLabelTapped))
        self.currentWordLabel.addGestureRecognizer(tap)
        
        self.addSubview(self.submitWordButton)
        
        self.submitWordButton.setTitle("SUBMIT", for: .normal)
        self.submitWordButton.setTitleColor(.black, for: .normal)
        self.submitWordButton.setTitleColor(.gray, for: .disabled)
        
        self.submitWordButton.backgroundColor = .white
        self.submitWordButton.layer.borderColor = UIColor.black.cgColor
        self.submitWordButton.layer.borderWidth = 2
        self.submitWordButton.layer.cornerRadius = 10
        
        self.submitWordButton.translatesAutoresizingMaskIntoConstraints = false
        self.submitWordButton.topAnchor.constraint(equalTo: self.currentWordLabel.topAnchor).isActive = true
        self.submitWordButton.leadingAnchor.constraint(equalTo: currentWordLabel.trailingAnchor, constant: 10).isActive = true
        self.submitWordButton.heightAnchor.constraint(equalTo: currentWordLabel.heightAnchor).isActive = true
        self.submitWordButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10).isActive = true
        
        self.submitWordButton.addTarget(self, action: #selector(submitWordButtonPressed), for: .touchUpInside)
        
        self.addSubview(self.submitResultsLabel)
        
        self.submitResultsLabel.translatesAutoresizingMaskIntoConstraints = false
        self.submitResultsLabel.backgroundColor = .white
        self.submitResultsLabel.layer.masksToBounds = true
        self.submitResultsLabel.layer.borderColor = UIColor.black.cgColor
        self.submitResultsLabel.layer.borderWidth = 2
        self.submitResultsLabel.layer.cornerRadius = 10
        self.submitResultsLabel.layer.contentsRect.insetBy(dx: 10, dy: 10)
        
        self.submitResultsLabel.topAnchor.constraint(equalTo: submitWordButton.bottomAnchor, constant: 10).isActive = true
        self.submitResultsLabel.widthAnchor.constraint(equalTo: self.widthAnchor, constant: -20).isActive = true
        self.submitResultsLabel.heightAnchor.constraint(equalToConstant: 100).isActive = true
        self.submitResultsLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        self.submitResultsLabel.textAlignment = NSTextAlignment.center

        self.addSubview(self.timer)
        
        self.timer.textAlignment = .center
        self.timer.backgroundColor = .clear
        self.timer.text = "0:00"
        
        self.timerTextAttributes = [
            NSAttributedStringKey.strokeColor : UIColor.black,
            NSAttributedStringKey.foregroundColor : UIColor.white,
            NSAttributedStringKey.strokeWidth : -4.0,
            NSAttributedStringKey.font : UIFont(name:"HelveticaNeue-Bold", size: 30)!]
            as [NSAttributedStringKey : Any]
        self.updateTimer("0:00")
        
        self.timer.translatesAutoresizingMaskIntoConstraints = false
        self.timer.topAnchor.constraint(equalTo: self.submitResultsLabel.bottomAnchor, constant: 10).isActive = true
        self.timer.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        self.timer.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        
        self.addSubview(quitButton)
        
        self.quitButton.setTitle("QUIT", for: .normal)
        
        self.quitButton.translatesAutoresizingMaskIntoConstraints = false
        self.quitButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
        self.quitButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        self.quitButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 10).isActive = true
        self.quitButton.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        
        self.quitButton.addTarget(self, action: #selector(quitButtonTapped), for: .touchUpInside)
    }
    
    @objc
    private func currentWordLabelTapped() {
        self.delegate?.clearWord()
    }
    
    private func createButtons(_ gridRows: UIStackView) {
        for _ in 0...3 {
            let stackView = UIStackView()
            stackView.axis = .horizontal
            gridRows.addArrangedSubview(stackView)
            
            stackView.backgroundColor = .white
            
            for _ in 0...3 {
                let buttonToAdd = UIButton()
                stackView.addArrangedSubview(buttonToAdd)
                
                buttonToAdd.translatesAutoresizingMaskIntoConstraints = false
                buttonToAdd.widthAnchor.constraint(equalTo: stackView.widthAnchor, multiplier: 1/4).isActive = true
                buttonToAdd.heightAnchor.constraint(equalTo: buttonToAdd.widthAnchor).isActive = true
                
                buttonToAdd.backgroundColor = .white
                buttonToAdd.layer.borderColor = UIColor.black.cgColor
                buttonToAdd.layer.borderWidth = 2
                buttonToAdd.layer.cornerRadius = 10
                
                buttonToAdd.setTitleColor(.black, for: .normal)
                buttonToAdd.setTitleColor(.gray, for: .disabled)
                
                buttonToAdd.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
                
                self.gridButtons.append(buttonToAdd)
            }
        }
    }
    
    func readyToReceiveWord(_ ready: Bool) {
        self.submitWordButton.isEnabled = ready
    }
    
    func updateSubmitResults(_ message: String) {
        self.submitResultsLabel.text = message
    }
    
    func updateLetters(_ letters: Array<String>) {
        for (index, button) in self.gridButtons.enumerated() {
            button.setTitle(letters[index], for: .normal)
        }
    }
    
    func setCurrentWord(_ currentWord: String) {
        self.currentWordLabel.text = currentWord
    }
    
    func disableInputs() {
        for button in self.gridButtons {
            button.isEnabled = false
        }
        self.quitButton.isEnabled = false
        self.submitWordButton.isEnabled = false
    }
    
    func enableInputs() {
        for button in self.gridButtons {
            button.isEnabled = true
        }
        self.quitButton.isEnabled = true
    }
    
    func updateTimer(_ timerText: String) {
        self.timer.attributedText = NSMutableAttributedString(string: timerText, attributes: self.timerTextAttributes)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc
    private func buttonTapped(sender: UIButton, forEvent event: UIEvent) {
        sender.isEnabled = false
        self.delegate?.letterSelected(sender.title(for: .normal))
    }
    
    @objc
    private func quitButtonTapped() {
        self.delegate?.done()
    }
    
    @objc
    private func submitWordButtonPressed(sender: UIButton, forEvent event: UIEvent) {
        self.delegate?.submitWord()
    }
}
