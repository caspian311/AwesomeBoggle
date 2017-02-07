import UIKit

protocol BoggleViewProtocol: class {
    func setRandomizedLetters(_ letters: Array<String>)
}

class BoggleView: UIView, BoggleViewProtocol {
    let colors: Array<UIColor>
    let verticalStackView: UIStackView
    
    init() {
        self.colors = [UIColor.black, UIColor.white, UIColor.red, UIColor.purple,
                       UIColor.brown, UIColor.cyan, UIColor.darkGray, UIColor.green,
                       UIColor.magenta, UIColor.orange, UIColor.yellow, UIColor.lightGray,
                       UIColor.red, UIColor.blue, UIColor.green, UIColor.yellow]
        self.verticalStackView = UIStackView()
        
        super.init(frame: CGRect.zero)
        self.backgroundColor = .blue
        
        self.verticalStackView.axis = .vertical
        addSubview(self.verticalStackView)
        
        self.verticalStackView.translatesAutoresizingMaskIntoConstraints = false
        self.verticalStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        self.verticalStackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 20).isActive = true
        self.verticalStackView.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        self.verticalStackView.backgroundColor = .white
    }
    
    func setRandomizedLetters(_ letters: Array<String>) {
        var colorCounter = 0
        
        for _ in 0...3 {
            let stackView = UIStackView()
            stackView.axis = .horizontal
            self.verticalStackView.addArrangedSubview(stackView)
            
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
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc
    private func buttonTapped(sender: UIButton, forEvent event: UIEvent) {
        
    }
}
