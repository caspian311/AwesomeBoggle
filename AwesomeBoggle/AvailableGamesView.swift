import Foundation
import UIKit

protocol AvailableGamesViewProtocol: class {
    func startGame(with userId: Int)
    func backButtonPressed()
}

class AvailableGamesView: GradientView, UITableViewDelegate, UITableViewDataSource  {
    weak var delegate: AvailableGamesViewProtocol?
    
    private var availableGamesTableView: UITableView
    private var availableGames: [UserData] = []
    
    private let gamesLabel: UILabel
    
    init() {
        self.gamesLabel = UILabel()
        self.availableGamesTableView = UITableView()
        let backButton = UIButton()
        
        super.init(frame: CGRect.zero)
        
        self.startColor = UIColor(red: 0.6, green: 0.8, blue: 1.00, alpha: 1.00)
        self.endColor = UIColor(red: 0.2, green: 0.6, blue: 1.00, alpha: 1.00)
        
        self.addSubview(self.gamesLabel)
        self.addSubview(self.availableGamesTableView)
        self.addSubview(backButton)
        
        
        self.gamesLabel.textAlignment = .center
        
        let gameLabelTextAttributes = [
            NSAttributedStringKey.strokeColor : UIColor.black,
            NSAttributedStringKey.foregroundColor : UIColor.white,
            NSAttributedStringKey.strokeWidth : -3.0,
            NSAttributedStringKey.font : UIFont(name:"HelveticaNeue-Bold", size: 35)!]
            as [NSAttributedStringKey : Any]
        self.gamesLabel.attributedText = NSMutableAttributedString(string: "Pick your opponent", attributes: gameLabelTextAttributes)
        
        self.gamesLabel.translatesAutoresizingMaskIntoConstraints = false
        self.gamesLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 50).isActive = true
        self.gamesLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        
        
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
        
        
        self.availableGamesTableView.delegate = self
        self.availableGamesTableView.dataSource = self
        
        
        self.availableGamesTableView.register(AvailableGameTableViewCell.self, forCellReuseIdentifier: "AvailableGameTableViewCell")
        
        self.availableGamesTableView.translatesAutoresizingMaskIntoConstraints = false
        self.availableGamesTableView.topAnchor.constraint(equalTo: self.gamesLabel.bottomAnchor, constant: 10).isActive = true
        self.availableGamesTableView.bottomAnchor.constraint(equalTo: backButton.topAnchor, constant: -20).isActive = true
        self.availableGamesTableView.widthAnchor.constraint(equalTo: self.widthAnchor, constant: -20).isActive = true
        self.availableGamesTableView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        
        self.availableGamesTableView.layer.masksToBounds = true
        self.availableGamesTableView.layer.borderColor = UIColor.black.cgColor
        self.availableGamesTableView.layer.borderWidth = 2
        self.availableGamesTableView.layer.cornerRadius = 10
        self.availableGamesTableView.layer.contentsRect.insetBy(dx: 10, dy: 10)
        
        
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.availableGames.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdendifier: String = "AvailableGameTableViewCell"
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdendifier, for: indexPath) as! AvailableGameTableViewCell
        
        let userId = self.availableGames[indexPath.row].id
        let username = self.availableGames[indexPath.row].username
        
        cell.populate(userId: userId, username: username)
        cell.delegate = self.delegate
        
        cell.sizeToFit()
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func showError(_ error: String) {
        print("Error: \(error)")
    }
    
    func populateAvailableGames(_ games: [UserData]) {
        self.availableGames = games
        self.availableGamesTableView.reloadData()
    }
    
    func showNoUsersAreAvailable() {
        print("No users are available")
    }
    
    @objc
    private func backButtonPressed() {
        self.delegate?.backButtonPressed()
    }
}
