import Foundation
import UIKit

class AvailableGameTableViewCell: UITableViewCell {
    weak var delegate: AvailableGamesViewProtocol?
    
    private let usernameLabel: UILabel = UILabel()
    private let joinButton: UIButton = UIButton()
    
    private var userId: Int = 0
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.contentView.addSubview(self.usernameLabel)
        self.contentView.addSubview(self.joinButton)
        
        self.usernameLabel.translatesAutoresizingMaskIntoConstraints = false
        self.usernameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
        self.usernameLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1/2).isActive = true
        self.usernameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20).isActive = true
        
        self.joinButton.translatesAutoresizingMaskIntoConstraints = false
        self.joinButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
        self.joinButton.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1/2).isActive = true
        self.joinButton.leadingAnchor.constraint(equalTo: self.usernameLabel.trailingAnchor).isActive = true
        self.joinButton.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        
        self.joinButton.addTarget(self, action: #selector(joinButtonPressed), for: .touchUpInside)
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func populate(userId: Int, username: String) {
        self.userId = userId
        self.usernameLabel.text = username
    }
    
    @objc private func joinButtonPressed() {
        self.delegate!.startGame(with: userId)
    }
}
