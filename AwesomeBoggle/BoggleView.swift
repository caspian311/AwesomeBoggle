import UIKit


class BoggleView: UIView {
    private var gridButtons = [UIButton]()
    private var currentWorldLabel: UILabel
    private var viewController: BoggleViewControllerProtocol?
    
    init() {
        self.currentWorldLabel = UILabel()
        
        super.init(frame: CGRect.zero)
        self.backgroundColor = .gray
        
        let mainVerticalStack = UIStackView()
        mainVerticalStack.axis = .vertical
        mainVerticalStack.backgroundColor = .gray
        
        let resultsStack = UIStackView()
        resultsStack.axis = .horizontal
        resultsStack.backgroundColor = .gray
        
        let gridRows = UIStackView()
        
        
        addSubview(mainVerticalStack)
        
        let resetButton = UIButton()
        
        mainVerticalStack.addArrangedSubview(resetButton)
        mainVerticalStack.addArrangedSubview(gridRows)
        mainVerticalStack.addArrangedSubview(resultsStack)
        
        mainVerticalStack.translatesAutoresizingMaskIntoConstraints = false
        mainVerticalStack.topAnchor.constraint(equalTo: self.topAnchor, constant: 20).isActive = true
        mainVerticalStack.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        mainVerticalStack.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        
        resetButton.backgroundColor = .white
        resetButton.layer.borderColor = UIColor.red.cgColor
        resetButton.layer.borderWidth = 1
        resetButton.layer.cornerRadius = 10
        
        resetButton.setTitle("Reset", for: .normal)
        resetButton.setTitleColor(.black, for: .normal)
        
        resetButton.translatesAutoresizingMaskIntoConstraints = false
        resetButton.topAnchor.constraint(equalTo: mainVerticalStack.topAnchor, constant: 20).isActive = true
        resetButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
        resetButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        gridRows.axis = .vertical
        gridRows.translatesAutoresizingMaskIntoConstraints = false
        gridRows.leadingAnchor.constraint(equalTo: mainVerticalStack.leadingAnchor).isActive = true
        gridRows.topAnchor.constraint(equalTo: resetButton.bottomAnchor, constant: 30).isActive = true
        gridRows.widthAnchor.constraint(equalTo: mainVerticalStack.widthAnchor).isActive = true
        gridRows.backgroundColor = .white
        
        createButtons(gridRows)
        
        resetButton.addTarget(self, action: #selector(resetButtonTapped), for: .touchUpInside)
        
        
        resultsStack.addArrangedSubview(self.currentWorldLabel)
        
        self.currentWorldLabel.backgroundColor = .white
        self.currentWorldLabel.layer.masksToBounds = true
        self.currentWorldLabel.layer.borderColor = UIColor.red.cgColor
        self.currentWorldLabel.layer.borderWidth = 1
        self.currentWorldLabel.layer.cornerRadius = 10
        
        self.currentWorldLabel.translatesAutoresizingMaskIntoConstraints = false
        self.currentWorldLabel.topAnchor.constraint(equalTo: gridRows.bottomAnchor, constant: 20).isActive = true
        self.currentWorldLabel.leadingAnchor.constraint(equalTo: mainVerticalStack.leadingAnchor).isActive = true
        self.currentWorldLabel.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        let submitWordButton = UIButton()
        resultsStack.addArrangedSubview(submitWordButton)
        
        submitWordButton.setTitle("Enter", for: .normal)
        submitWordButton.setTitleColor(.black, for: .normal)
        
        submitWordButton.backgroundColor = .white
        submitWordButton.layer.borderColor = UIColor.red.cgColor
        submitWordButton.layer.borderWidth = 1
        submitWordButton.layer.cornerRadius = 10
        
        submitWordButton.translatesAutoresizingMaskIntoConstraints = false
        submitWordButton.topAnchor.constraint(equalTo: gridRows.bottomAnchor, constant: 20).isActive = true
        submitWordButton.leadingAnchor.constraint(equalTo: currentWorldLabel.trailingAnchor, constant: 10).isActive = true
        submitWordButton.heightAnchor.constraint(equalTo: currentWorldLabel.heightAnchor).isActive = true
        submitWordButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        
        submitWordButton.addTarget(self, action: #selector(submitWordButtonPressed), for: .touchUpInside)
    }
    
    func createButtons(_ gridRows: UIStackView) {
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
                buttonToAdd.layer.borderColor = UIColor.red.cgColor
                buttonToAdd.layer.borderWidth = 1
                buttonToAdd.layer.cornerRadius = 10
                
                buttonToAdd.setTitleColor(.black, for: .normal)
                
                buttonToAdd.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
                
                self.gridButtons.append(buttonToAdd)
            }
        }
    }

    
    func updateLetters(_ letters: Array<String>) {
        for (index, button) in self.gridButtons.enumerated() {
            button.setTitle(letters[index], for: .normal)
        }
    }
    
    func setViewController(_ viewController: BoggleViewControllerProtocol) {
        self.viewController = viewController
    }
    
    func setCurrentWord(_ currentWord: String) {
        self.currentWorldLabel.text = currentWord
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc
    private func buttonTapped(sender: UIButton, forEvent event: UIEvent) {
        if let viewController = self.viewController {
            viewController.letterSelected(sender.title(for: .normal))
        }
    }
    
    @objc
    private func resetButtonTapped(sender: UIButton, forEvent event: UIEvent) {
        if let viewController = self.viewController {
            viewController.resetGrid()
        }
    }
    
    @objc
    private func submitWordButtonPressed(sender: UIButton, forEvent event: UIEvent) {
        if let viewController = self.viewController {
            viewController.submitWord()
        }
    }
}
