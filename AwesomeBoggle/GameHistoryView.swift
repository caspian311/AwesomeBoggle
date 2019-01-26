import UIKit

protocol GameHistoryViewProtocol: class {
    func backButtonPressed()
}

class GameHistoryView: GradientView, UITableViewDelegate, UITableViewDataSource {
    weak var delegate: GameHistoryViewProtocol?
    
    private let gameListTableView: UITableView
    private var gameList: [GameHistoryEntry] = []
    
    init() {
        self.gameListTableView = UITableView()
        let gamesLabel = UILabel()
        let backButton = UIButton()
        
        super.init(frame: CGRect.zero)
        
        self.startColor = UIColor(red: 0.6, green: 0.8, blue: 1.00, alpha: 1.00)
        self.endColor = UIColor(red: 0.2, green: 0.6, blue: 1.00, alpha: 1.00)
        
        self.addSubview(gamesLabel)
        self.addSubview(backButton)
        
        gamesLabel.textAlignment = .center
        
        let gameLabelTextAttributes = [
            NSAttributedStringKey.strokeColor : UIColor.black,
            NSAttributedStringKey.foregroundColor : UIColor.white,
            NSAttributedStringKey.strokeWidth : -4.0,
            NSAttributedStringKey.font : UIFont(name:"HelveticaNeue-Bold", size: 30)!]
            as [NSAttributedStringKey : Any]
        gamesLabel.attributedText = NSMutableAttributedString(string: "Games History", attributes: gameLabelTextAttributes)
        
        gamesLabel.translatesAutoresizingMaskIntoConstraints = false
        gamesLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 50).isActive = true
        gamesLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        
        
        backButton.setTitle("Back", for: .normal)
        backButton.setTitleColor(.black, for: .normal)
        
        backButton.backgroundColor = .white
        backButton.layer.borderColor = UIColor.black.cgColor
        backButton.layer.borderWidth = 2
        backButton.layer.cornerRadius = 10
        
        backButton.translatesAutoresizingMaskIntoConstraints = false
        backButton.widthAnchor.constraint(equalTo: self.widthAnchor, constant: -50).isActive = true
        backButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        backButton.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        backButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -20).isActive = true
        
        backButton.addTarget(self, action: #selector(backButtonPressed), for: .touchUpInside)
        
        
        self.gameListTableView.delegate = self
        self.gameListTableView.dataSource = self
        
        self.addSubview(gameListTableView)
        
        self.gameListTableView.register(BoggleGameTableViewCell.self, forCellReuseIdentifier: "BoggleGameTableViewCell")
        
        self.gameListTableView.translatesAutoresizingMaskIntoConstraints = false

        self.gameListTableView.topAnchor.constraint(equalTo: gamesLabel.bottomAnchor, constant: 10).isActive = true
        self.gameListTableView.bottomAnchor.constraint(equalTo: backButton.topAnchor, constant: -20).isActive = true
        self.gameListTableView.widthAnchor.constraint(equalTo: self.widthAnchor, constant: -20).isActive = true
        self.gameListTableView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        
        self.gameListTableView.layer.masksToBounds = true
        self.gameListTableView.layer.borderColor = UIColor.black.cgColor
        self.gameListTableView.layer.borderWidth = 2
        self.gameListTableView.layer.cornerRadius = 10
        self.gameListTableView.layer.contentsRect.insetBy(dx: 10, dy: 10)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.gameList.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdendifier = "BoggleGameTableViewCell"
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdendifier, for: indexPath) as! BoggleGameTableViewCell
        
        cell.gameDescription.text = self.gameList[indexPath.row].gameDescription
        cell.scores.text = self.gameList[indexPath.row].scores
        
        cell.sizeToFit()
        
        return cell
    }
    
    func populateGameList(_ gameList: [GameHistoryEntry]) {
        self.gameList = gameList
        self.gameListTableView.reloadData()
    }
    
    func showError(_ error: ErrorMessage) {
        print("Error: \(error.message)")
    }
    
    @objc
    private func backButtonPressed() {
        self.delegate?.backButtonPressed()
    }
}
