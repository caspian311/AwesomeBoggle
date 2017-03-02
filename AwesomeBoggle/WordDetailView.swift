import Foundation
import UIKit

protocol WordDetailViewProtocol: class {
    func modalTapped()
}

class WordDetailView: UIView {
    weak var delegate: WordDetailViewProtocol?
    let sentenceLabel: UILabel
    
    init() {
        self.sentenceLabel = UILabel()
        
        super.init(frame: CGRect.zero)
        self.backgroundColor = UIColor(white: 1, alpha: 0.5)
        
        self.addSubview(self.sentenceLabel)
        
        self.sentenceLabel.translatesAutoresizingMaskIntoConstraints = false
        self.sentenceLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        self.sentenceLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -50).isActive = true
        self.sentenceLabel.widthAnchor.constraint(equalTo: self.widthAnchor, constant: -10).isActive = true
        self.sentenceLabel.numberOfLines = 0
        
        self.sentenceLabel.backgroundColor = .white
        self.sentenceLabel.layer.borderColor = UIColor.red.cgColor
        self.sentenceLabel.layer.borderWidth = 1
        self.sentenceLabel.layer.cornerRadius = 10
        
        let modalButton = UIButton()
        
        modalButton.addTarget(self, action: #selector(modalTapped), for: .touchUpInside)
        
        self.addSubview(modalButton)
        
        modalButton.setTitle("Close", for: .normal)
        
        modalButton.translatesAutoresizingMaskIntoConstraints = false
        modalButton.topAnchor.constraint(equalTo: sentenceLabel.bottomAnchor, constant: 20).isActive = true
        modalButton.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1/2).isActive = true
        modalButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
        modalButton.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        
        modalButton.backgroundColor = .white
        modalButton.setTitleColor(.black, for: .normal)
        modalButton.layer.borderColor = UIColor.red.cgColor
        modalButton.layer.borderWidth = 1
        modalButton.layer.cornerRadius = 10
    }
    
    func showSentence(_ sentence: String) {
        self.sentenceLabel.text = sentence
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc
    private func modalTapped() {
        self.delegate?.modalTapped()
    }
}
