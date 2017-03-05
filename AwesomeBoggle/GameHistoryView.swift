import UIKit

protocol GameHistoryViewProtocol: class {
}

class GameHistoryView: UIView, UITableViewDelegate, UITableViewDataSource {
    weak var delegate: GameHistoryViewProtocol?
    
    private let gameListTableView: UITableView
    private var gameList: [GameHistoryEntry] = []
    
    init() {
        self.gameListTableView = UITableView()
        
        super.init(frame: CGRect.zero)
        
        self.backgroundColor = .gray
        
        self.gameListTableView.delegate = self
        self.gameListTableView.dataSource = self
        
        self.addSubview(gameListTableView)
        
        self.gameListTableView.register(BoggleGameTableViewCell.self, forCellReuseIdentifier: "BoggleGameTableViewCell")
        
        self.gameListTableView.translatesAutoresizingMaskIntoConstraints = false

        self.gameListTableView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        self.gameListTableView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        self.gameListTableView.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.gameList.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdendifier: String = "BoggleGameTableViewCell"
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdendifier, for: indexPath) as! BoggleGameTableViewCell
        
        cell.column1.text = self.gameList[indexPath.row].date
        cell.column2.text = "\(self.gameList[indexPath.row].score)"
        
        cell.sizeToFit()
        
        return cell
    }
    
    func populateGameList(_ gameList: [GameHistoryEntry]) {
        self.gameList = gameList
        self.gameListTableView.reloadData()
    }
}
