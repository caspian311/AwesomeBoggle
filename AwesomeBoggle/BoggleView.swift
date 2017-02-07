import UIKit


class BoggleView: UIView {
    let colors: Array<UIColor>
    let gridRows: UIStackView
    var viewController: BoggleViewControllerProtocol?
    
    init() {
        self.colors = [UIColor.black, UIColor.white, UIColor.red, UIColor.purple,
                       UIColor.brown, UIColor.cyan, UIColor.darkGray, UIColor.green,
                       UIColor.magenta, UIColor.orange, UIColor.yellow, UIColor.lightGray,
                       UIColor.red, UIColor.blue, UIColor.green, UIColor.yellow]
        self.gridRows = UIStackView()
        
        super.init(frame: CGRect.zero)
        self.backgroundColor = .gray
        
        let mainVerticalStack = UIStackView()
        mainVerticalStack.axis = .vertical
        mainVerticalStack.backgroundColor = .gray
        
        let resultsStack = UIStackView()
        resultsStack.axis = .horizontal
        resultsStack.backgroundColor = .gray
        
        addSubview(mainVerticalStack)
        
        let resetButton = UIButton()
        
        mainVerticalStack.addArrangedSubview(resetButton)
        mainVerticalStack.addArrangedSubview(self.gridRows)
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
        
        self.gridRows.axis = .vertical
        self.gridRows.translatesAutoresizingMaskIntoConstraints = false
        self.gridRows.leadingAnchor.constraint(equalTo: mainVerticalStack.leadingAnchor).isActive = true
        self.gridRows.topAnchor.constraint(equalTo: resetButton.bottomAnchor, constant: 30).isActive = true
        self.gridRows.widthAnchor.constraint(equalTo: mainVerticalStack.widthAnchor).isActive = true
        self.gridRows.backgroundColor = .white
        
        resetButton.addTarget(self, action: #selector(resetButtonTapped), for: .touchUpInside)
        
        let currentWorldLabel = UILabel()
        resultsStack.addArrangedSubview(currentWorldLabel)
        
        currentWorldLabel.backgroundColor = .white
        currentWorldLabel.layer.masksToBounds = true
        currentWorldLabel.layer.borderColor = UIColor.red.cgColor
        currentWorldLabel.layer.borderWidth = 1
        currentWorldLabel.layer.cornerRadius = 10
        
        currentWorldLabel.translatesAutoresizingMaskIntoConstraints = false
        currentWorldLabel.topAnchor.constraint(equalTo: self.gridRows.bottomAnchor, constant: 20).isActive = true
        currentWorldLabel.leadingAnchor.constraint(equalTo: mainVerticalStack.leadingAnchor).isActive = true
        currentWorldLabel.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        let submitWordButton = UIButton()
        resultsStack.addArrangedSubview(submitWordButton)
        
        submitWordButton.setTitle("Enter", for: .normal)
        submitWordButton.setTitleColor(.black, for: .normal)
        
        submitWordButton.backgroundColor = .white
        submitWordButton.layer.borderColor = UIColor.red.cgColor
        submitWordButton.layer.borderWidth = 1
        submitWordButton.layer.cornerRadius = 10
        
        submitWordButton.translatesAutoresizingMaskIntoConstraints = false
        submitWordButton.topAnchor.constraint(equalTo: self.gridRows.bottomAnchor, constant: 20).isActive = true
        submitWordButton.leadingAnchor.constraint(equalTo: currentWorldLabel.trailingAnchor, constant: 10).isActive = true
        submitWordButton.heightAnchor.constraint(equalTo: currentWorldLabel.heightAnchor).isActive = true
        submitWordButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
    }
    
    func clearGrid() {
        self.gridRows.subviews.forEach({ $0.removeFromSuperview() })
    }
    
    func createButtonsFromLetters(_ letters: Array<String>) {
        var colorCounter = 0
        
        for _ in 0...3 {
            let stackView = UIStackView()
            stackView.axis = .horizontal
            self.gridRows.addArrangedSubview(stackView)
            
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
                
                
                buttonToAdd.setTitle(letters[colorCounter], for: .normal)
                
                colorCounter += 1
                
                buttonToAdd.setTitleColor(.black, for: .normal)
                
                buttonToAdd.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
            }
        }
    }
    
    func setViewController(_ viewController: BoggleViewControllerProtocol) {
        self.viewController = viewController
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc
    private func buttonTapped(sender: UIButton, forEvent event: UIEvent) {
        
    }
    
    @objc
    private func resetButtonTapped(sender: UIButton, forEvent event: UIEvent) {
        if let viewController = self.viewController {
            viewController.resetGrid()
        }
    }
}
