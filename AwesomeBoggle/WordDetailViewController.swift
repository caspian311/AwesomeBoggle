import Foundation
import UIKit

class WordDetailViewController: UIViewController {
    private let wordDetailView: WordDetailView
    private let boggleModel: BoggleModel
    
    init(wordDetailView: WordDetailView = WordDetailView(), boggleModel: BoggleModel = BoggleModel()) {
        self.wordDetailView = wordDetailView
        self.boggleModel = boggleModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = wordDetailView
        wordDetailView.delegate = self
    }
}

extension WordDetailViewController: WordDetailViewProtocol {
    func modalTapped() {
    }
}
