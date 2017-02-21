import UIKit

protocol BoggleViewProtocol: class {
    func resetGrid()
    func letterSelected(_ letter: String?)
    func submitWord()
}

class BoggleView: UIView, UITableViewDelegate, UITableViewDataSource {
    private var gridButtons: [UIButton] = []
    private var currentWordLabel: PaddedUILabel
    private var wordList: [String] = []
    private var wordListTableView = UITableView()

    weak var delegate: BoggleViewProtocol?
    
    private let tableViewIdentifier = "wordCell"
    
    init() {
        self.currentWordLabel = PaddedUILabel()
        
        super.init(frame: CGRect.zero)
        self.backgroundColor = .gray
        
        let gridRows = UIStackView()
        
        let resetButton = UIButton()
        
        self.addSubview(resetButton)
        
        resetButton.setTitle("Reset", for: .normal)
        
        resetButton.translatesAutoresizingMaskIntoConstraints = false
        resetButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 20).isActive = true
        resetButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
        resetButton.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        
        self.addSubview(gridRows)
        
        gridRows.axis = .vertical
        gridRows.translatesAutoresizingMaskIntoConstraints = false
        gridRows.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        gridRows.topAnchor.constraint(equalTo: resetButton.bottomAnchor).isActive = true
        gridRows.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        gridRows.backgroundColor = .white
        
        createButtons(gridRows)
        
        resetButton.addTarget(self, action: #selector(resetButtonTapped), for: .touchUpInside)
        
        self.addSubview(self.currentWordLabel)
        
        self.currentWordLabel.translatesAutoresizingMaskIntoConstraints = false
        self.currentWordLabel.backgroundColor = .white
        self.currentWordLabel.layer.masksToBounds = true
        self.currentWordLabel.layer.borderColor = UIColor.red.cgColor
        self.currentWordLabel.layer.borderWidth = 1
        self.currentWordLabel.layer.cornerRadius = 10
        self.currentWordLabel.layer.contentsRect.insetBy(dx: 10, dy: 10)
        
        self.currentWordLabel.topAnchor.constraint(equalTo: gridRows.bottomAnchor, constant: 10).isActive = true
        self.currentWordLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        self.currentWordLabel.heightAnchor.constraint(equalToConstant: 60).isActive = true
        self.currentWordLabel.widthAnchor.constraint(equalTo: self.widthAnchor, constant: -110).isActive = true
        
        let submitWordButton = UIButton()
        self.addSubview(submitWordButton)
        
        submitWordButton.setTitle("Enter", for: .normal)
        submitWordButton.setTitleColor(.black, for: .normal)
        
        submitWordButton.backgroundColor = .white
        submitWordButton.layer.borderColor = UIColor.red.cgColor
        submitWordButton.layer.borderWidth = 1
        submitWordButton.layer.cornerRadius = 10
        
        submitWordButton.translatesAutoresizingMaskIntoConstraints = false
        submitWordButton.topAnchor.constraint(equalTo: self.currentWordLabel.topAnchor).isActive = true
        submitWordButton.leadingAnchor.constraint(equalTo: currentWordLabel.trailingAnchor, constant: 10).isActive = true
        submitWordButton.heightAnchor.constraint(equalTo: currentWordLabel.heightAnchor).isActive = true
        submitWordButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        
        submitWordButton.addTarget(self, action: #selector(submitWordButtonPressed), for: .touchUpInside)
        
        self.wordListTableView.register(UITableViewCell.self, forCellReuseIdentifier: self.tableViewIdentifier)
        self.wordListTableView.delegate = self
        self.wordListTableView.dataSource = self
        
        self.addSubview(wordListTableView)
        
        wordListTableView.register(BoggleTableViewCell.self, forCellReuseIdentifier: "BoggleTableViewCell")
        
        wordListTableView.translatesAutoresizingMaskIntoConstraints = false
        wordListTableView.topAnchor.constraint(equalTo: self.currentWordLabel.bottomAnchor, constant: 10).isActive = true
        wordListTableView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 10).isActive = true
        wordListTableView.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
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
    
    func setCurrentWord(_ currentWord: String) {
        self.currentWordLabel.text = currentWord
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateWordList(_ wordList: [String]) {
        self.wordList = wordList
        self.wordListTableView.reloadData()
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.wordList.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdendifier: String = "BoggleTableViewCell"
        
//        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdendifier, for: indexPath) as? TableViewCell
        let cell = BoggleTableViewCell(style: .default, reuseIdentifier: cellIdendifier)
        
        cell.column1Text = wordList[indexPath.row]
        cell.column2Text = "\(wordList[indexPath.row].characters.count)"
        
        cell.sizeToFit()
        
        return cell
    }
    
    @objc
    private func buttonTapped(sender: UIButton, forEvent event: UIEvent) {
        self.delegate?.letterSelected(sender.title(for: .normal))
    }
    
    @objc
    private func resetButtonTapped(sender: UIButton, forEvent event: UIEvent) {
        self.delegate?.resetGrid()
    }
    
    @objc
    private func submitWordButtonPressed(sender: UIButton, forEvent event: UIEvent) {
        self.delegate?.submitWord()
    }
}
