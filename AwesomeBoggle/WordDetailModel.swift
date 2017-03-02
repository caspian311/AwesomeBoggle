import Foundation

protocol WordDetailModelProtocol: class {
    func showSentence(_ sentence: String)
}

class WordDetailModel {
    var delegate: WordDetailModelProtocol?
    
    private let sentence: String
    
    init(sentence: String) {
        self.sentence = sentence
    }
    
    func populate() {
        self.delegate?.showSentence(sentence)
    }
}
