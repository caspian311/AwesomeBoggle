import Foundation

class BoggleGame {
    let id: String
    let score: Int
    let date: Date
    
    init(id: String, date: Date, score: Int) {
        self.id = id
        self.date = date
        self.score = score
    }
}
