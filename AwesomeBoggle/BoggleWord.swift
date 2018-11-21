import Foundation

class BoggleWord {
    private let value: String
    
    init(_ value: String) {
        self.value = value
    }
    
    func text() -> String {
        return self.value
    }
    
    func score() -> Int {
        return self.value.count
    }
}
