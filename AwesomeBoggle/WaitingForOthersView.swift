import Foundation
import UIKit

protocol WaitingForOthersViewProtocol: class {
    
}

class WaitingForOthersView: GradientView {
    weak var delegate: WaitingForOthersViewProtocol?
    
    init() {
        super.init(frame: CGRect.zero)
        
        self.startColor = UIColor(red: 0.6, green: 0.8, blue: 1.00, alpha: 1.00)
        self.endColor = UIColor(red: 0.2, green: 0.6, blue: 1.00, alpha: 1.00)
        
        let titleLabel = UILabel()
        
        self.addSubview(titleLabel)
        
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 0
        
        let strokeTextAttributes = [
            NSAttributedStringKey.strokeColor : UIColor.black,
            NSAttributedStringKey.foregroundColor : UIColor.white,
            NSAttributedStringKey.strokeWidth : -4.0,
            NSAttributedStringKey.font : UIFont(name:"HelveticaNeue-Bold", size: 20)!]
            as [NSAttributedStringKey : Any]
        titleLabel.attributedText = NSMutableAttributedString(string: "Waiting for others to join...", attributes: strokeTextAttributes)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func showError(_ errorMessage: String) {
        print("Error: \(errorMessage)")
    }
}
