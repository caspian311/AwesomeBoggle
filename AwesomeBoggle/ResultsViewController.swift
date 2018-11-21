import Foundation
import UIKit

class ResultsViewController: UIViewController {
    let resultsView: ResultsView
    let resultsModel: ResultsModel
    
    init(resultsView: ResultsView = ResultsView(), resultsModel: ResultsModel) {
        self.resultsView = resultsView
        self.resultsModel = resultsModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = self.resultsView
        self.resultsView.delegate = self
        self.resultsView.setupNavigationBar(self.navigationItem)
        self.resultsModel.delegate = self
        
        self.resultsModel.populate()
    }
}

extension ResultsViewController: ResultsViewProtocol {
    func done() {
        _ = self.navigationController?.popToRootViewController(animated: true)
    }
}

extension ResultsViewController: ResultsModelProtocol {
    func populateWordList(_ wordList: [BoggleWord]) {
        self.resultsView.updateWordList(wordList)
    }
    
    func populateScore(_ score: Int) {
        self.resultsView.updateScore(score)
    }
    
    func showError() {
    }
}
