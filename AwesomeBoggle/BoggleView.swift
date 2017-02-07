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
        self.backgroundColor = .blue
        
        let mainVerticalStack = UIStackView()
        mainVerticalStack.axis = .vertical
        
        addSubview(mainVerticalStack)
        
        let resetButton = UIButton()
        resetButton.backgroundColor = .white
        resetButton.setTitle("Reset", for: .normal)
        resetButton.setTitleColor(.black, for: .normal)
        
        mainVerticalStack.addArrangedSubview(resetButton)
        mainVerticalStack.addArrangedSubview(self.gridRows)
        
        mainVerticalStack.translatesAutoresizingMaskIntoConstraints = false
        mainVerticalStack.topAnchor.constraint(equalTo: self.topAnchor, constant: 20).isActive = true
        mainVerticalStack.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        mainVerticalStack.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        
        resetButton.translatesAutoresizingMaskIntoConstraints = false
        resetButton.topAnchor.constraint(equalTo: mainVerticalStack.topAnchor, constant: 20).isActive = true
        resetButton.leadingAnchor.constraint(equalTo: mainVerticalStack.leadingAnchor).isActive = true
        resetButton.widthAnchor.constraint(equalTo: mainVerticalStack.widthAnchor).isActive = true
        resetButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        self.gridRows.axis = .vertical
        self.gridRows.translatesAutoresizingMaskIntoConstraints = false
        self.gridRows.leadingAnchor.constraint(equalTo: mainVerticalStack.leadingAnchor).isActive = true
        self.gridRows.topAnchor.constraint(equalTo: resetButton.bottomAnchor, constant: 20).isActive = true
        self.gridRows.widthAnchor.constraint(equalTo: mainVerticalStack.widthAnchor).isActive = true
        self.gridRows.backgroundColor = .white
        
        resetButton.addTarget(self, action: #selector(resetButtonTapped), for: .touchUpInside)
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
                
                buttonToAdd.backgroundColor = colors[colorCounter]
                
                
                buttonToAdd.setTitle(letters[colorCounter], for: .normal)
                
                colorCounter += 1
                
                buttonToAdd.setTitleColor(.purple, for: .normal)
                
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
