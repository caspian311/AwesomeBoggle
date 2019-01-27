import UIKit

class BoggleGameTableViewCell: UITableViewCell {
    private let gameResult: UILabel
    private let gameTime: UILabel
    private let scores: UILabel
    
    private var winningTextAttributes: [NSAttributedStringKey : Any] = [:]
    private var losingTextAttributes: [NSAttributedStringKey : Any] = [:]
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        gameResult = UILabel()
        gameTime = UILabel()
        scores = UILabel()
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.contentView.addSubview(self.gameResult)
        self.contentView.addSubview(self.gameTime)
        self.contentView.addSubview(self.scores)
        
        self.winningTextAttributes = [
            NSAttributedStringKey.strokeColor : UIColor.black,
            NSAttributedStringKey.foregroundColor : UIColor(red: 0.6, green: 0.8, blue: 1.00, alpha: 1.00),
            NSAttributedStringKey.strokeWidth : -1.0,
            NSAttributedStringKey.font : UIFont(name:"HelveticaNeue-Bold", size: 25)!]
            as [NSAttributedStringKey : Any]
        self.losingTextAttributes = [
            NSAttributedStringKey.strokeColor : UIColor.black,
            NSAttributedStringKey.foregroundColor : UIColor(red: 1.0, green: 0.3, blue: 0.3, alpha: 1.00),
            NSAttributedStringKey.strokeWidth : -1.0,
            NSAttributedStringKey.font : UIFont(name:"HelveticaNeue-Bold", size: 25)!]
            as [NSAttributedStringKey : Any]
        
        self.gameResult.translatesAutoresizingMaskIntoConstraints = false
        self.gameResult.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
        self.gameResult.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
        self.gameResult.widthAnchor.constraint(equalTo: self.widthAnchor, constant: -250).isActive = true
        
        self.gameTime.translatesAutoresizingMaskIntoConstraints = false
        self.gameTime.topAnchor.constraint(equalTo: self.topAnchor, constant: 18).isActive = true
        self.gameTime.leadingAnchor.constraint(equalTo: self.gameResult.trailingAnchor).isActive = true
        
        self.scores.translatesAutoresizingMaskIntoConstraints = false
        self.scores.topAnchor.constraint(equalTo: self.gameResult.bottomAnchor).isActive = true
        self.scores.widthAnchor.constraint(equalTo: self.widthAnchor, constant: -40).isActive = true
        self.scores.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
    }
    
    required init(coder aDecoder: NSCoder) {
        gameResult = UILabel()
        gameTime = UILabel()
        scores = UILabel()
        
        super.init(coder: aDecoder)!
    }
    
    func update(entry: GameHistoryEntry) {
        gameTime.text = entry.gameTime
        scores.text = entry.scores
        
        if entry.gameResult {
            gameResult.attributedText = NSMutableAttributedString(string: "You won", attributes: self.winningTextAttributes)
        } else {
            gameResult.attributedText = NSMutableAttributedString(string: "You lost", attributes: self.losingTextAttributes)
        }
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
