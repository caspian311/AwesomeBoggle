import Foundation
import UIKit

protocol ResultsViewProtocol: class {
    func done()
}

class ResultsView: GradientView, UITableViewDelegate, UITableViewDataSource {
    var delegate: ResultsViewProtocol?
    weak var navigationItem: UINavigationItem?
    
    private var wordListTableView: UITableView
    private var wordList: [BoggleWord] = []
    
    private let scoreLabel: UILabel
    
    private var resultsTextAttributes: [NSAttributedStringKey : Any] = [:]
    
    init(){
        self.scoreLabel = UILabel()
        self.wordListTableView = UITableView()
        
        super.init(frame: CGRect.zero)
        
        self.startColor = UIColor(red: 0.6, green: 0.8, blue: 1.00, alpha: 1.00)
        self.endColor = UIColor(red: 0.2, green: 0.6, blue: 1.00, alpha: 1.00)
        
        self.addSubview(self.scoreLabel)
        
        self.addSubview(scoreLabel)
        
        scoreLabel.textAlignment = .center
        
        self.resultsTextAttributes = [
            NSAttributedStringKey.strokeColor : UIColor.black,
            NSAttributedStringKey.foregroundColor : UIColor.white,
            NSAttributedStringKey.strokeWidth : -4.0,
            NSAttributedStringKey.font : UIFont(name:"HelveticaNeue-Bold", size: 30)!]
            as [NSAttributedStringKey : Any]
        scoreLabel.attributedText = NSMutableAttributedString(string: "", attributes: self.resultsTextAttributes)
        
        scoreLabel.translatesAutoresizingMaskIntoConstraints = false
        scoreLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 50).isActive = true
        scoreLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        
        self.wordListTableView.delegate = self
        self.wordListTableView.dataSource = self
        
        self.addSubview(wordListTableView)
        
        self.wordListTableView.register(BoggleTableViewCell.self, forCellReuseIdentifier: "BoggleTableViewCell")
        
        self.wordListTableView.translatesAutoresizingMaskIntoConstraints = false
        self.wordListTableView.topAnchor.constraint(equalTo: self.scoreLabel.bottomAnchor, constant: 10).isActive = true
        self.wordListTableView.widthAnchor.constraint(equalTo: self.widthAnchor, constant: -20).isActive = true
        self.wordListTableView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        
        self.wordListTableView.layer.masksToBounds = true
        self.wordListTableView.layer.borderColor = UIColor.black.cgColor
        self.wordListTableView.layer.borderWidth = 2
        self.wordListTableView.layer.cornerRadius = 10
        self.wordListTableView.layer.contentsRect.insetBy(dx: 10, dy: 10)
        
        let doneButton = UIButton()
        self.addSubview(doneButton)
        
        doneButton.setTitle("Done", for: .normal)
        doneButton.setTitleColor(.black, for: .normal)
        
        doneButton.backgroundColor = .white
        doneButton.layer.borderColor = UIColor.black.cgColor
        doneButton.layer.borderWidth = 2
        doneButton.layer.cornerRadius = 10
        
        doneButton.translatesAutoresizingMaskIntoConstraints = false
        doneButton.widthAnchor.constraint(equalTo: self.widthAnchor, constant: -30).isActive = true
        doneButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        doneButton.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        doneButton.topAnchor.constraint(equalTo: self.wordListTableView.bottomAnchor, constant: 10).isActive = true
        doneButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -20).isActive = true
        
        doneButton.addTarget(self, action: #selector(doneButtonClicked), for: .touchUpInside)
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
        let text = "Your score is \(score)!"
        scoreLabel.attributedText = NSMutableAttributedString(string: text, attributes: self.resultsTextAttributes)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
