import Foundation
import UIKit

class WordDetailViewController: UIViewController {
    let wordDetailView: WordDetailView
    let wordDetailModel: WordDetailModel
    
    init(wordDetailView: WordDetailView = WordDetailView(), wordDetailModel: WordDetailModel) {
        self.wordDetailView = wordDetailView
        self.wordDetailModel = wordDetailModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = wordDetailView
        self.wordDetailView.delegate = self
        self.wordDetailModel.delegate = self
        self.wordDetailModel.populate()
    }
}

extension WordDetailViewController: WordDetailModelProtocol {
    func showSentence(_ sentence: String) {
        self.wordDetailView.showSentence(sentence)
    }
}

extension WordDetailViewController: WordDetailViewProtocol {
    func modalTapped() {
        self.dismiss(animated: true, completion: nil)
    }
}
