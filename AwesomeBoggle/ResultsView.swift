import Foundation
import UIKit

protocol ResultsViewProtocol: class {
    func done()
}

class ResultsView: UIView, UITableViewDelegate, UITableViewDataSource {
    var delegate: ResultsViewProtocol?
    weak var navigationItem: UINavigationItem?
    
    private var wordListTableView: UITableView
    private var wordList: [BoggleWord] = []
    
    private let scoreLabel: UILabel
    
    init(){
        self.scoreLabel = UILabel()
        self.wordListTableView = UITableView()
        
        super.init(frame: CGRect.zero)
        
        self.backgroundColor = .gray
        
        self.addSubview(self.scoreLabel)
        
        self.scoreLabel.backgroundColor = .white
        self.scoreLabel.layer.masksToBounds = true
        self.scoreLabel.layer.borderColor = UIColor.red.cgColor
        self.scoreLabel.layer.borderWidth = 1
        self.scoreLabel.layer.cornerRadius = 10
        self.scoreLabel.layer.contentsRect.insetBy(dx: 10, dy: 10)
        self.scoreLabel.textAlignment = NSTextAlignment.center
        
        self.scoreLabel.translatesAutoresizingMaskIntoConstraints = false
        self.scoreLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
        self.scoreLabel.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        self.scoreLabel.heightAnchor.constraint(equalToConstant: 60).isActive = true
        self.scoreLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        
        self.wordListTableView.delegate = self
        self.wordListTableView.dataSource = self
        
        self.addSubview(wordListTableView)
        
        self.wordListTableView.register(BoggleTableViewCell.self, forCellReuseIdentifier: "BoggleTableViewCell")
        
        self.wordListTableView.translatesAutoresizingMaskIntoConstraints = false
        self.wordListTableView.topAnchor.constraint(equalTo: self.scoreLabel.bottomAnchor, constant: 10).isActive = true
        self.wordListTableView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        self.wordListTableView.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
    }
    
    func setupNavigationBar(_ navigationItem: UINavigationItem) {
        navigationItem.rightBarButtonItem =
            UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(doneButtonClicked))
    }
    
    @objc
    private func doneButtonClicked() {
        self.delegate?.done()
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.wordList.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdendifier: String = "BoggleTableViewCell"
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdendifier, for: indexPath) as! BoggleTableViewCell
        
        cell.column1.text = wordList[indexPath.row].text()
        cell.column2.text = "\(wordList[indexPath.row].score())"
        
        cell.sizeToFit()
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func updateWordList(_ wordList: [BoggleWord]) {
        self.wordList = wordList
        self.wordListTableView.reloadData()
    }
    
    func updateScore(_ score: Int) {
        self.scoreLabel.text = "Your score is \(score)!"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
