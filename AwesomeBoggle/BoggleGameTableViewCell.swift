import UIKit

class BoggleGameTableViewCell: UITableViewCell {
    let gameDescription: UILabel
    let scores: UILabel
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        gameDescription = UILabel()
        scores = UILabel()
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.contentView.addSubview(self.gameDescription)
        self.contentView.addSubview(self.scores)
        
        self.gameDescription.translatesAutoresizingMaskIntoConstraints = false
        self.gameDescription.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
        self.gameDescription.widthAnchor.constraint(equalTo: self.widthAnchor, constant: -20).isActive = true
        self.gameDescription.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        
        self.scores.translatesAutoresizingMaskIntoConstraints = false
        self.scores.topAnchor.constraint(equalTo: self.gameDescription.bottomAnchor).isActive = true
        self.scores.widthAnchor.constraint(equalTo: self.widthAnchor, constant: -40).isActive = true
        self.scores.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
    }
    
    required init(coder aDecoder: NSCoder) {
        gameDescription = UILabel()
        scores = UILabel()
        
        super.init(coder: aDecoder)!
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
