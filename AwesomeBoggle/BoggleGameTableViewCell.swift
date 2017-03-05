import UIKit

class BoggleGameTableViewCell: UITableViewCell {
    let column1: UILabel = UILabel()
    let column2: UILabel = UILabel()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.contentView.addSubview(column1)
        self.contentView.addSubview(column2)
        
        column1.translatesAutoresizingMaskIntoConstraints = false
        column1.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        column1.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1/2).isActive = true
        column1.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5).isActive = true
        
        column2.translatesAutoresizingMaskIntoConstraints = false
        column2.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        column2.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1/2).isActive = true
        column2.leadingAnchor.constraint(equalTo: column1.trailingAnchor).isActive = true
        column2.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 5).isActive = true
        
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
}
