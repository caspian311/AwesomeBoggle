import Foundation
import UIKit

protocol LoadingViewProtocol: class {
}

class LoadingView: GradientView {
    weak var delegate: LoadingViewProtocol?
    
    private let loadingSpinner: UILabel;
    
    init() {
        let titleLabel = UILabel()
        self.loadingSpinner = UILabel()
        
        super.init(frame: CGRect.zero)
        
        self.startColor = UIColor(red: 0.6, green: 0.8, blue: 1.00, alpha: 1.00)
        self.endColor = UIColor(red: 0.2, green: 0.6, blue: 1.00, alpha: 1.00)
        
        self.addSubview(titleLabel)
        self.addSubview(loadingSpinner)
        
        titleLabel.textAlignment = .center
        titleLabel.backgroundColor = .clear
        titleLabel.font = UIFont(name:"HelveticaNeue-Bold", size: 60)
        titleLabel.numberOfLines = 0
        
        let strokeTextAttributes = [
            NSAttributedStringKey.strokeColor : UIColor.black,
            NSAttributedStringKey.foregroundColor : UIColor.white,
            NSAttributedStringKey.strokeWidth : -4.0,
            NSAttributedStringKey.font : UIFont(name:"HelveticaNeue-Bold", size: 60)!]
            as [NSAttributedStringKey : Any]
        titleLabel.attributedText = NSMutableAttributedString(string: "Awesome\nBoggle", attributes: strokeTextAttributes)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.bottomAnchor.constraint(equalTo: loadingSpinner.topAnchor, constant: -30).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        
        self.loadingSpinner.textAlignment = .center
        self.loadingSpinner.backgroundColor = .clear
        self.loadingSpinner.font = UIFont(name:"HelveticaNeue-Bold", size: 30)
        self.loadingSpinner.numberOfLines = 0
        self.loadingSpinner.text = "Loading..."
        
        self.loadingSpinner.translatesAutoresizingMaskIntoConstraints = false
        self.loadingSpinner.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        self.loadingSpinner.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func showError(_ message: String) {
        print("An error occurred while loading the data...")
        print(message)
    }
    
    func updateProgress(_ statusMessage: String) {
        self.loadingSpinner.text = statusMessage
    }
}
